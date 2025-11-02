---
name: database-integrator
description: Complete database integration workflow with TypeORM, migrations, and optimized query patterns. Use this skill when designing database schemas, creating migrations, implementing repositories, optimizing queries, and ensuring data integrity. Uses Context7 for ORM documentation, Serena for pattern analysis, and Postman MCP for API testing with database operations.
---

# Database Integrator

## Overview

This skill provides a comprehensive database integration workflow covering schema design, entity modeling, migration management, repository patterns, query optimization, and data integrity. The process includes analyzing data requirements, designing normalized schemas, implementing TypeORM entities, creating migrations, building repositories, optimizing queries, and ensuring production-ready database operations.

## Core Workflow

### Phase 1: Database Design & Planning

**1. Analyze Data Requirements**

Identify database needs:
- Data models and entities
- Relationships (one-to-one, one-to-many, many-to-many)
- Business constraints and rules
- Query patterns and access patterns
- Performance requirements
- Scalability requirements
- Data integrity requirements
- Security and privacy requirements

**2. Research Database Patterns**

Use Serena MCP to find existing patterns:
```
mcp__serena__search_for_pattern - Search for entity and repository patterns
mcp__serena__find_symbol - Find existing database models
mcp__serena__get_symbols_overview - Understand data model structure
mcp__serena__get_code_graph - Map entity relationships
```

Analyze:
- Existing entity models
- Repository implementations
- Query patterns
- Migration strategies
- Connection management
- Transaction handling

**3. Study ORM Documentation**

Use Context7 MCP for TypeORM best practices:
```
mcp__context7__get-library-docs - Get TypeORM documentation
mcp__context7__get-library-docs - Get PostgreSQL/MySQL docs
mcp__context7__get-library-docs - Get database indexing guides
```

Research:
- TypeORM entity decorators
- Relationship mapping
- Query builder patterns
- Transaction management
- Migration generation
- Index optimization

**4. Design Database Schema**

Create entity-relationship diagram:

```
Users Table
├── id (PK, UUID)
├── email (UNIQUE)
├── password
├── name
├── role (ENUM)
├── avatar
├── emailVerified
├── createdAt
├── updatedAt
└── lastLoginAt

Posts Table
├── id (PK, UUID)
├── title
├── content
├── slug (UNIQUE)
├── status (ENUM)
├── authorId (FK → Users.id)
├── publishedAt
├── createdAt
└── updatedAt

Categories Table
├── id (PK, UUID)
├── name (UNIQUE)
├── slug (UNIQUE)
├── description
├── createdAt
└── updatedAt

PostCategories Table (Junction)
├── postId (FK → Posts.id)
├── categoryId (FK → Categories.id)
└── PRIMARY KEY (postId, categoryId)

Comments Table
├── id (PK, UUID)
├── content
├── postId (FK → Posts.id)
├── authorId (FK → Users.id)
├── parentId (FK → Comments.id, nullable)
├── createdAt
└── updatedAt
```

### Phase 2: Entity Implementation

**5. Create Base Entity**

Implement common fields:

```typescript
// src/entities/base/Base.entity.ts
import {
  PrimaryGeneratedColumn,
  CreateDateColumn,
  UpdateDateColumn,
  BaseEntity as TypeORMBaseEntity,
} from 'typeorm';

export abstract class BaseEntity extends TypeORMBaseEntity {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @CreateDateColumn({ type: 'timestamp' })
  createdAt: Date;

  @UpdateDateColumn({ type: 'timestamp' })
  updatedAt: Date;
}
```

**6. Implement User Entity**

Create user model with relationships:

```typescript
// src/entities/User.entity.ts
import {
  Entity,
  Column,
  Index,
  OneToMany,
  BeforeInsert,
  BeforeUpdate,
} from 'typeorm';
import { BaseEntity } from './base/Base.entity';
import { Post } from './Post.entity';
import { Comment } from './Comment.entity';
import * as bcrypt from 'bcrypt';

export enum UserRole {
  ADMIN = 'admin',
  USER = 'user',
  GUEST = 'guest',
}

export enum UserStatus {
  ACTIVE = 'active',
  SUSPENDED = 'suspended',
  DELETED = 'deleted',
}

@Entity('users')
@Index(['email'], { unique: true })
@Index(['role'])
@Index(['status'])
export class User extends BaseEntity {
  @Column({ type: 'varchar', length: 255, unique: true })
  email: string;

  @Column({ type: 'varchar', length: 255, select: false })
  password: string;

  @Column({ type: 'varchar', length: 100 })
  name: string;

  @Column({
    type: 'enum',
    enum: UserRole,
    default: UserRole.USER,
  })
  role: UserRole;

  @Column({
    type: 'enum',
    enum: UserStatus,
    default: UserStatus.ACTIVE,
  })
  status: UserStatus;

  @Column({ type: 'varchar', length: 500, nullable: true })
  avatar: string | null;

  @Column({ type: 'boolean', default: false })
  emailVerified: boolean;

  @Column({ type: 'timestamp', nullable: true })
  lastLoginAt: Date | null;

  // Relationships
  @OneToMany(() => Post, (post) => post.author)
  posts: Post[];

  @OneToMany(() => Comment, (comment) => comment.author)
  comments: Comment[];

  // Hooks
  @BeforeInsert()
  @BeforeUpdate()
  async hashPassword() {
    if (this.password && !this.password.startsWith('$2b$')) {
      this.password = await bcrypt.hash(this.password, 10);
    }
  }

  @BeforeInsert()
  async setDefaults() {
    this.emailVerified = false;
    this.status = UserStatus.ACTIVE;
  }

  // Methods
  async comparePassword(plainPassword: string): Promise<boolean> {
    return bcrypt.compare(plainPassword, this.password);
  }

  toJSON() {
    const { password, ...user } = this;
    return user;
  }
}
```

**7. Implement Post Entity**

Create post model with relationships:

```typescript
// src/entities/Post.entity.ts
import {
  Entity,
  Column,
  Index,
  ManyToOne,
  ManyToMany,
  OneToMany,
  JoinColumn,
  JoinTable,
  BeforeInsert,
  BeforeUpdate,
} from 'typeorm';
import { BaseEntity } from './base/Base.entity';
import { User } from './User.entity';
import { Category } from './Category.entity';
import { Comment } from './Comment.entity';
import slugify from 'slugify';

export enum PostStatus {
  DRAFT = 'draft',
  PUBLISHED = 'published',
  ARCHIVED = 'archived',
}

@Entity('posts')
@Index(['slug'], { unique: true })
@Index(['authorId'])
@Index(['status'])
@Index(['publishedAt'])
@Index(['createdAt'])
export class Post extends BaseEntity {
  @Column({ type: 'varchar', length: 255 })
  title: string;

  @Column({ type: 'varchar', length: 300, unique: true })
  slug: string;

  @Column({ type: 'text' })
  content: string;

  @Column({ type: 'text', nullable: true })
  excerpt: string | null;

  @Column({ type: 'varchar', length: 500, nullable: true })
  featuredImage: string | null;

  @Column({
    type: 'enum',
    enum: PostStatus,
    default: PostStatus.DRAFT,
  })
  status: PostStatus;

  @Column({ type: 'integer', default: 0 })
  viewCount: number;

  @Column({ type: 'timestamp', nullable: true })
  publishedAt: Date | null;

  // Relationships
  @Column({ type: 'uuid' })
  authorId: string;

  @ManyToOne(() => User, (user) => user.posts, {
    onDelete: 'CASCADE',
    eager: false,
  })
  @JoinColumn({ name: 'authorId' })
  author: User;

  @ManyToMany(() => Category, (category) => category.posts, {
    cascade: true,
  })
  @JoinTable({
    name: 'post_categories',
    joinColumn: { name: 'postId', referencedColumnName: 'id' },
    inverseJoinColumn: { name: 'categoryId', referencedColumnName: 'id' },
  })
  categories: Category[];

  @OneToMany(() => Comment, (comment) => comment.post)
  comments: Comment[];

  // Hooks
  @BeforeInsert()
  @BeforeUpdate()
  async generateSlug() {
    if (!this.slug || this.slug === '') {
      this.slug = slugify(this.title, { lower: true, strict: true });
    }
  }

  @BeforeInsert()
  async setDefaults() {
    this.status = PostStatus.DRAFT;
    this.viewCount = 0;
  }
}
```

**8. Implement Category Entity**

Create category with many-to-many relationship:

```typescript
// src/entities/Category.entity.ts
import {
  Entity,
  Column,
  Index,
  ManyToMany,
  BeforeInsert,
  BeforeUpdate,
} from 'typeorm';
import { BaseEntity } from './base/Base.entity';
import { Post } from './Post.entity';
import slugify from 'slugify';

@Entity('categories')
@Index(['slug'], { unique: true })
@Index(['name'], { unique: true })
export class Category extends BaseEntity {
  @Column({ type: 'varchar', length: 100, unique: true })
  name: string;

  @Column({ type: 'varchar', length: 120, unique: true })
  slug: string;

  @Column({ type: 'text', nullable: true })
  description: string | null;

  @Column({ type: 'integer', default: 0 })
  postCount: number;

  // Relationships
  @ManyToMany(() => Post, (post) => post.categories)
  posts: Post[];

  // Hooks
  @BeforeInsert()
  @BeforeUpdate()
  async generateSlug() {
    if (!this.slug || this.slug === '') {
      this.slug = slugify(this.name, { lower: true, strict: true });
    }
  }
}
```

**9. Implement Comment Entity**

Create hierarchical comments:

```typescript
// src/entities/Comment.entity.ts
import {
  Entity,
  Column,
  Index,
  ManyToOne,
  OneToMany,
  JoinColumn,
  Tree,
  TreeChildren,
  TreeParent,
} from 'typeorm';
import { BaseEntity } from './base/Base.entity';
import { User } from './User.entity';
import { Post } from './Post.entity';

@Entity('comments')
@Tree('materialized-path')
@Index(['postId'])
@Index(['authorId'])
@Index(['createdAt'])
export class Comment extends BaseEntity {
  @Column({ type: 'text' })
  content: string;

  @Column({ type: 'boolean', default: false })
  isEdited: boolean;

  // Relationships
  @Column({ type: 'uuid' })
  postId: string;

  @ManyToOne(() => Post, (post) => post.comments, {
    onDelete: 'CASCADE',
  })
  @JoinColumn({ name: 'postId' })
  post: Post;

  @Column({ type: 'uuid' })
  authorId: string;

  @ManyToOne(() => User, (user) => user.comments, {
    onDelete: 'CASCADE',
  })
  @JoinColumn({ name: 'authorId' })
  author: User;

  // Hierarchical structure
  @TreeParent()
  parent: Comment | null;

  @TreeChildren()
  children: Comment[];
}
```

### Phase 3: Migration Management

**10. Configure TypeORM**

Setup database connection:

```typescript
// src/config/database.config.ts
import { DataSource, DataSourceOptions } from 'typeorm';
import { User } from '@/entities/User.entity';
import { Post } from '@/entities/Post.entity';
import { Category } from '@/entities/Category.entity';
import { Comment } from '@/entities/Comment.entity';

export const dataSourceOptions: DataSourceOptions = {
  type: 'postgres',
  host: process.env.DB_HOST || 'localhost',
  port: parseInt(process.env.DB_PORT || '5432'),
  username: process.env.DB_USERNAME || 'postgres',
  password: process.env.DB_PASSWORD || 'postgres',
  database: process.env.DB_DATABASE || 'myapp',
  entities: [User, Post, Category, Comment],
  migrations: ['src/migrations/*.ts'],
  synchronize: false, // Never use in production
  logging: process.env.NODE_ENV === 'development',
  ssl: process.env.DB_SSL === 'true' ? { rejectUnauthorized: false } : false,
  poolSize: parseInt(process.env.DB_POOL_SIZE || '10'),
  extra: {
    max: 20,
    connectionTimeoutMillis: 10000,
    idleTimeoutMillis: 30000,
  },
};

export const AppDataSource = new DataSource(dataSourceOptions);
```

**11. Generate Initial Migration**

Create database schema migration:

```bash
# Generate migration from entities
npm run typeorm migration:generate -- src/migrations/InitialSchema

# Or create empty migration
npm run typeorm migration:create -- src/migrations/InitialSchema
```

```typescript
// src/migrations/1699999999999-InitialSchema.ts
import {
  MigrationInterface,
  QueryRunner,
  Table,
  TableIndex,
  TableForeignKey,
} from 'typeorm';

export class InitialSchema1699999999999 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    // Enable UUID extension
    await queryRunner.query('CREATE EXTENSION IF NOT EXISTS "uuid-ossp"');

    // Create users table
    await queryRunner.createTable(
      new Table({
        name: 'users',
        columns: [
          {
            name: 'id',
            type: 'uuid',
            isPrimary: true,
            default: 'uuid_generate_v4()',
          },
          {
            name: 'email',
            type: 'varchar',
            length: '255',
            isUnique: true,
          },
          {
            name: 'password',
            type: 'varchar',
            length: '255',
          },
          {
            name: 'name',
            type: 'varchar',
            length: '100',
          },
          {
            name: 'role',
            type: 'enum',
            enum: ['admin', 'user', 'guest'],
            default: "'user'",
          },
          {
            name: 'status',
            type: 'enum',
            enum: ['active', 'suspended', 'deleted'],
            default: "'active'",
          },
          {
            name: 'avatar',
            type: 'varchar',
            length: '500',
            isNullable: true,
          },
          {
            name: 'emailVerified',
            type: 'boolean',
            default: false,
          },
          {
            name: 'lastLoginAt',
            type: 'timestamp',
            isNullable: true,
          },
          {
            name: 'createdAt',
            type: 'timestamp',
            default: 'CURRENT_TIMESTAMP',
          },
          {
            name: 'updatedAt',
            type: 'timestamp',
            default: 'CURRENT_TIMESTAMP',
          },
        ],
      }),
      true
    );

    // Create indexes for users
    await queryRunner.createIndex(
      'users',
      new TableIndex({
        name: 'IDX_USERS_EMAIL',
        columnNames: ['email'],
      })
    );

    await queryRunner.createIndex(
      'users',
      new TableIndex({
        name: 'IDX_USERS_ROLE',
        columnNames: ['role'],
      })
    );

    await queryRunner.createIndex(
      'users',
      new TableIndex({
        name: 'IDX_USERS_STATUS',
        columnNames: ['status'],
      })
    );

    // Create posts table
    await queryRunner.createTable(
      new Table({
        name: 'posts',
        columns: [
          {
            name: 'id',
            type: 'uuid',
            isPrimary: true,
            default: 'uuid_generate_v4()',
          },
          {
            name: 'title',
            type: 'varchar',
            length: '255',
          },
          {
            name: 'slug',
            type: 'varchar',
            length: '300',
            isUnique: true,
          },
          {
            name: 'content',
            type: 'text',
          },
          {
            name: 'excerpt',
            type: 'text',
            isNullable: true,
          },
          {
            name: 'featuredImage',
            type: 'varchar',
            length: '500',
            isNullable: true,
          },
          {
            name: 'status',
            type: 'enum',
            enum: ['draft', 'published', 'archived'],
            default: "'draft'",
          },
          {
            name: 'viewCount',
            type: 'integer',
            default: 0,
          },
          {
            name: 'authorId',
            type: 'uuid',
          },
          {
            name: 'publishedAt',
            type: 'timestamp',
            isNullable: true,
          },
          {
            name: 'createdAt',
            type: 'timestamp',
            default: 'CURRENT_TIMESTAMP',
          },
          {
            name: 'updatedAt',
            type: 'timestamp',
            default: 'CURRENT_TIMESTAMP',
          },
        ],
      }),
      true
    );

    // Create foreign key
    await queryRunner.createForeignKey(
      'posts',
      new TableForeignKey({
        name: 'FK_POSTS_AUTHOR',
        columnNames: ['authorId'],
        referencedTableName: 'users',
        referencedColumnNames: ['id'],
        onDelete: 'CASCADE',
      })
    );

    // Create indexes for posts
    await queryRunner.createIndex(
      'posts',
      new TableIndex({
        name: 'IDX_POSTS_SLUG',
        columnNames: ['slug'],
      })
    );

    await queryRunner.createIndex(
      'posts',
      new TableIndex({
        name: 'IDX_POSTS_AUTHOR',
        columnNames: ['authorId'],
      })
    );

    await queryRunner.createIndex(
      'posts',
      new TableIndex({
        name: 'IDX_POSTS_STATUS',
        columnNames: ['status'],
      })
    );

    await queryRunner.createIndex(
      'posts',
      new TableIndex({
        name: 'IDX_POSTS_PUBLISHED_AT',
        columnNames: ['publishedAt'],
      })
    );

    // Create categories table
    await queryRunner.createTable(
      new Table({
        name: 'categories',
        columns: [
          {
            name: 'id',
            type: 'uuid',
            isPrimary: true,
            default: 'uuid_generate_v4()',
          },
          {
            name: 'name',
            type: 'varchar',
            length: '100',
            isUnique: true,
          },
          {
            name: 'slug',
            type: 'varchar',
            length: '120',
            isUnique: true,
          },
          {
            name: 'description',
            type: 'text',
            isNullable: true,
          },
          {
            name: 'postCount',
            type: 'integer',
            default: 0,
          },
          {
            name: 'createdAt',
            type: 'timestamp',
            default: 'CURRENT_TIMESTAMP',
          },
          {
            name: 'updatedAt',
            type: 'timestamp',
            default: 'CURRENT_TIMESTAMP',
          },
        ],
      }),
      true
    );

    // Create junction table for posts and categories
    await queryRunner.createTable(
      new Table({
        name: 'post_categories',
        columns: [
          {
            name: 'postId',
            type: 'uuid',
          },
          {
            name: 'categoryId',
            type: 'uuid',
          },
        ],
      }),
      true
    );

    await queryRunner.createPrimaryKey('post_categories', ['postId', 'categoryId']);

    await queryRunner.createForeignKeys('post_categories', [
      new TableForeignKey({
        name: 'FK_POST_CATEGORIES_POST',
        columnNames: ['postId'],
        referencedTableName: 'posts',
        referencedColumnNames: ['id'],
        onDelete: 'CASCADE',
      }),
      new TableForeignKey({
        name: 'FK_POST_CATEGORIES_CATEGORY',
        columnNames: ['categoryId'],
        referencedTableName: 'categories',
        referencedColumnNames: ['id'],
        onDelete: 'CASCADE',
      }),
    ]);

    // Create comments table
    await queryRunner.createTable(
      new Table({
        name: 'comments',
        columns: [
          {
            name: 'id',
            type: 'uuid',
            isPrimary: true,
            default: 'uuid_generate_v4()',
          },
          {
            name: 'content',
            type: 'text',
          },
          {
            name: 'isEdited',
            type: 'boolean',
            default: false,
          },
          {
            name: 'postId',
            type: 'uuid',
          },
          {
            name: 'authorId',
            type: 'uuid',
          },
          {
            name: 'mpath',
            type: 'varchar',
            isNullable: true,
          },
          {
            name: 'createdAt',
            type: 'timestamp',
            default: 'CURRENT_TIMESTAMP',
          },
          {
            name: 'updatedAt',
            type: 'timestamp',
            default: 'CURRENT_TIMESTAMP',
          },
        ],
      }),
      true
    );

    await queryRunner.createForeignKeys('comments', [
      new TableForeignKey({
        name: 'FK_COMMENTS_POST',
        columnNames: ['postId'],
        referencedTableName: 'posts',
        referencedColumnNames: ['id'],
        onDelete: 'CASCADE',
      }),
      new TableForeignKey({
        name: 'FK_COMMENTS_AUTHOR',
        columnNames: ['authorId'],
        referencedTableName: 'users',
        referencedColumnNames: ['id'],
        onDelete: 'CASCADE',
      }),
    ]);

    await queryRunner.createIndex(
      'comments',
      new TableIndex({
        name: 'IDX_COMMENTS_POST',
        columnNames: ['postId'],
      })
    );

    await queryRunner.createIndex(
      'comments',
      new TableIndex({
        name: 'IDX_COMMENTS_AUTHOR',
        columnNames: ['authorId'],
      })
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.dropTable('comments');
    await queryRunner.dropTable('post_categories');
    await queryRunner.dropTable('categories');
    await queryRunner.dropTable('posts');
    await queryRunner.dropTable('users');
    await queryRunner.query('DROP EXTENSION IF EXISTS "uuid-ossp"');
  }
}
```

**12. Run Migrations**

Execute migrations:

```bash
# Run pending migrations
npm run typeorm migration:run

# Revert last migration
npm run typeorm migration:revert

# Show migration status
npm run typeorm migration:show
```

### Phase 4: Repository Implementation

**13. Create Base Repository**

Implement reusable repository pattern:

```typescript
// src/repositories/base/Base.repository.ts
import { Repository, FindOptionsWhere, FindManyOptions, DeepPartial } from 'typeorm';
import { BaseEntity } from '@/entities/base/Base.entity';

export interface PaginationOptions {
  page: number;
  limit: number;
}

export interface PaginatedResult<T> {
  data: T[];
  meta: {
    page: number;
    limit: number;
    total: number;
    totalPages: number;
  };
}

export class BaseRepository<T extends BaseEntity> {
  constructor(protected repository: Repository<T>) {}

  async findById(id: string): Promise<T | null> {
    return this.repository.findOne({ where: { id } as FindOptionsWhere<T> });
  }

  async findAll(options?: FindManyOptions<T>): Promise<T[]> {
    return this.repository.find(options);
  }

  async findPaginated(
    options: PaginationOptions,
    findOptions?: FindManyOptions<T>
  ): Promise<PaginatedResult<T>> {
    const { page, limit } = options;
    const skip = (page - 1) * limit;

    const [data, total] = await this.repository.findAndCount({
      ...findOptions,
      skip,
      take: limit,
    });

    return {
      data,
      meta: {
        page,
        limit,
        total,
        totalPages: Math.ceil(total / limit),
      },
    };
  }

  async create(data: DeepPartial<T>): Promise<T> {
    const entity = this.repository.create(data);
    return this.repository.save(entity);
  }

  async update(id: string, data: DeepPartial<T>): Promise<T | null> {
    await this.repository.update(id, data as any);
    return this.findById(id);
  }

  async delete(id: string): Promise<boolean> {
    const result = await this.repository.delete(id);
    return (result.affected ?? 0) > 0;
  }

  async exists(where: FindOptionsWhere<T>): Promise<boolean> {
    const count = await this.repository.count({ where });
    return count > 0;
  }
}
```

**14. Implement User Repository**

Create specialized user repository:

```typescript
// src/repositories/User.repository.ts
import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { User, UserRole, UserStatus } from '@/entities/User.entity';
import { BaseRepository } from './base/Base.repository';

@Injectable()
export class UserRepository extends BaseRepository<User> {
  constructor(
    @InjectRepository(User)
    repository: Repository<User>
  ) {
    super(repository);
  }

  async findByEmail(email: string): Promise<User | null> {
    return this.repository.findOne({
      where: { email },
      select: ['id', 'email', 'password', 'name', 'role', 'status'],
    });
  }

  async findActiveUsers(page: number, limit: number) {
    return this.findPaginated(
      { page, limit },
      {
        where: { status: UserStatus.ACTIVE },
        order: { createdAt: 'DESC' },
      }
    );
  }

  async findByRole(role: UserRole) {
    return this.repository.find({
      where: { role },
      order: { createdAt: 'DESC' },
    });
  }

  async updateLastLogin(userId: string): Promise<void> {
    await this.repository.update(userId, {
      lastLoginAt: new Date(),
    });
  }

  async searchUsers(searchTerm: string, page: number, limit: number) {
    const query = this.repository
      .createQueryBuilder('user')
      .where('user.name ILIKE :search OR user.email ILIKE :search', {
        search: `%${searchTerm}%`,
      })
      .andWhere('user.status = :status', { status: UserStatus.ACTIVE })
      .orderBy('user.createdAt', 'DESC')
      .skip((page - 1) * limit)
      .take(limit);

    const [data, total] = await query.getManyAndCount();

    return {
      data,
      meta: {
        page,
        limit,
        total,
        totalPages: Math.ceil(total / limit),
      },
    };
  }
}
```

**15. Implement Post Repository**

Create post repository with advanced queries:

```typescript
// src/repositories/Post.repository.ts
import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository, In } from 'typeorm';
import { Post, PostStatus } from '@/entities/Post.entity';
import { BaseRepository } from './base/Base.repository';

@Injectable()
export class PostRepository extends BaseRepository<Post> {
  constructor(
    @InjectRepository(Post)
    repository: Repository<Post>
  ) {
    super(repository);
  }

  async findBySlug(slug: string): Promise<Post | null> {
    return this.repository.findOne({
      where: { slug },
      relations: ['author', 'categories', 'comments'],
    });
  }

  async findPublishedPosts(page: number, limit: number) {
    return this.findPaginated(
      { page, limit },
      {
        where: { status: PostStatus.PUBLISHED },
        order: { publishedAt: 'DESC' },
        relations: ['author', 'categories'],
      }
    );
  }

  async findPostsByAuthor(authorId: string, page: number, limit: number) {
    return this.findPaginated(
      { page, limit },
      {
        where: { authorId },
        order: { createdAt: 'DESC' },
        relations: ['categories'],
      }
    );
  }

  async findPostsByCategory(categoryId: string, page: number, limit: number) {
    const query = this.repository
      .createQueryBuilder('post')
      .leftJoinAndSelect('post.author', 'author')
      .leftJoinAndSelect('post.categories', 'category')
      .where('category.id = :categoryId', { categoryId })
      .andWhere('post.status = :status', { status: PostStatus.PUBLISHED })
      .orderBy('post.publishedAt', 'DESC')
      .skip((page - 1) * limit)
      .take(limit);

    const [data, total] = await query.getManyAndCount();

    return {
      data,
      meta: {
        page,
        limit,
        total,
        totalPages: Math.ceil(total / limit),
      },
    };
  }

  async incrementViewCount(postId: string): Promise<void> {
    await this.repository.increment({ id: postId }, 'viewCount', 1);
  }

  async getTrendingPosts(limit: number = 10): Promise<Post[]> {
    return this.repository.find({
      where: { status: PostStatus.PUBLISHED },
      order: { viewCount: 'DESC', publishedAt: 'DESC' },
      take: limit,
      relations: ['author', 'categories'],
    });
  }
}
```

### Phase 5: Query Optimization

**16. Analyze Query Performance**

Use database query analysis:

```typescript
// src/utils/query-logger.ts
import { QueryRunner } from 'typeorm';

export class QueryLogger {
  async analyzeQuery(queryRunner: QueryRunner, sql: string) {
    const explain = await queryRunner.query(`EXPLAIN ANALYZE ${sql}`);
    console.log('Query Plan:', explain);

    // Look for:
    // - Sequential scans (should use indexes)
    // - High execution time
    // - N+1 query problems
    return explain;
  }
}
```

**17. Add Database Indexes**

Create performance migration:

```typescript
// src/migrations/1700000000000-AddPerformanceIndexes.ts
import { MigrationInterface, QueryRunner, TableIndex } from 'typeorm';

export class AddPerformanceIndexes1700000000000 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    // Composite index for common query patterns
    await queryRunner.createIndex(
      'posts',
      new TableIndex({
        name: 'IDX_POSTS_STATUS_PUBLISHED',
        columnNames: ['status', 'publishedAt'],
      })
    );

    // Full-text search index
    await queryRunner.query(`
      ALTER TABLE posts ADD COLUMN searchVector tsvector;
    `);

    await queryRunner.query(`
      UPDATE posts SET searchVector =
        to_tsvector('english', coalesce(title, '') || ' ' || coalesce(content, ''));
    `);

    await queryRunner.query(`
      CREATE INDEX IDX_POSTS_SEARCH ON posts USING GIN(searchVector);
    `);

    // Partial index for active users
    await queryRunner.query(`
      CREATE INDEX IDX_USERS_ACTIVE
      ON users(createdAt)
      WHERE status = 'active';
    `);
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.dropIndex('posts', 'IDX_POSTS_STATUS_PUBLISHED');
    await queryRunner.query('DROP INDEX IF EXISTS IDX_POSTS_SEARCH');
    await queryRunner.query('DROP INDEX IF EXISTS IDX_USERS_ACTIVE');
    await queryRunner.query('ALTER TABLE posts DROP COLUMN IF EXISTS searchVector');
  }
}
```

**18. Optimize with Query Builder**

Implement efficient queries:

```typescript
// src/repositories/Post.repository.ts (optimized methods)
export class PostRepository extends BaseRepository<Post> {
  // Efficient search with full-text search
  async searchPosts(searchTerm: string, page: number, limit: number) {
    const query = this.repository
      .createQueryBuilder('post')
      .select([
        'post.id',
        'post.title',
        'post.slug',
        'post.excerpt',
        'post.publishedAt',
      ])
      .addSelect('author.id', 'author.name', 'author.avatar')
      .leftJoin('post.author', 'author')
      .where(`post.searchVector @@ plainto_tsquery('english', :search)`, {
        search: searchTerm,
      })
      .andWhere('post.status = :status', { status: PostStatus.PUBLISHED })
      .orderBy(
        `ts_rank(post.searchVector, plainto_tsquery('english', :search))`,
        'DESC'
      )
      .addOrderBy('post.publishedAt', 'DESC')
      .skip((page - 1) * limit)
      .take(limit);

    const [data, total] = await query.getManyAndCount();

    return {
      data,
      meta: { page, limit, total, totalPages: Math.ceil(total / limit) },
    };
  }

  // Batch loading to prevent N+1 queries
  async findPostsWithRelations(postIds: string[]): Promise<Post[]> {
    return this.repository
      .createQueryBuilder('post')
      .leftJoinAndSelect('post.author', 'author')
      .leftJoinAndSelect('post.categories', 'category')
      .whereInIds(postIds)
      .getMany();
  }

  // Optimized count query
  async getPostCountByStatus(): Promise<Record<PostStatus, number>> {
    const counts = await this.repository
      .createQueryBuilder('post')
      .select('post.status', 'status')
      .addSelect('COUNT(*)', 'count')
      .groupBy('post.status')
      .getRawMany();

    return counts.reduce((acc, { status, count }) => {
      acc[status as PostStatus] = parseInt(count);
      return acc;
    }, {} as Record<PostStatus, number>);
  }
}
```

### Phase 6: Testing & Validation

**19. Test Database Operations**

Use Postman MCP to test API with database:
```
mcp__postman__postman - Test CRUD operations with database
```

Test scenarios:
- Create records with relationships
- Query with pagination
- Update records
- Delete with cascading
- Test transactions
- Verify constraints
- Test indexes
- Check query performance

**20. Write Repository Tests**

Create comprehensive tests:

```typescript
// src/repositories/User.repository.spec.ts
import { Test, TestingModule } from '@nestjs/testing';
import { getRepositoryToken } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { UserRepository } from './User.repository';
import { User, UserRole, UserStatus } from '@/entities/User.entity';

describe('UserRepository', () => {
  let userRepository: UserRepository;
  let repository: Repository<User>;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        UserRepository,
        {
          provide: getRepositoryToken(User),
          useValue: {
            findOne: jest.fn(),
            find: jest.fn(),
            findAndCount: jest.fn(),
            create: jest.fn(),
            save: jest.fn(),
            update: jest.fn(),
            delete: jest.fn(),
            createQueryBuilder: jest.fn(),
          },
        },
      ],
    }).compile();

    userRepository = module.get<UserRepository>(UserRepository);
    repository = module.get<Repository<User>>(getRepositoryToken(User));
  });

  describe('findByEmail', () => {
    it('should find user by email', async () => {
      const mockUser = {
        id: '123',
        email: 'test@example.com',
        name: 'Test User',
      } as User;

      jest.spyOn(repository, 'findOne').mockResolvedValue(mockUser);

      const result = await userRepository.findByEmail('test@example.com');

      expect(result).toEqual(mockUser);
      expect(repository.findOne).toHaveBeenCalledWith({
        where: { email: 'test@example.com' },
        select: expect.any(Array),
      });
    });
  });
});
```

## Best Practices

1. **Never Use Synchronize in Production**: Always use migrations
2. **Use Transactions**: For multi-step operations
3. **Add Proper Indexes**: Optimize query performance
4. **Implement Soft Deletes**: Use status flags instead of hard deletes
5. **Use Query Builder**: For complex queries
6. **Prevent N+1 Queries**: Use eager loading or dataloader
7. **Validate Data**: Use DTOs and validation pipes
8. **Use Connection Pooling**: Configure pool size properly
9. **Handle Errors**: Implement proper error handling
10. **Log Queries**: Enable logging in development
11. **Use Cascading Carefully**: Understand cascade implications
12. **Implement Repository Pattern**: Separate data access logic
13. **Write Migrations**: Never modify schema directly
14. **Test Database Operations**: Write comprehensive tests
15. **Monitor Performance**: Track slow queries

## Completion Criteria

Database integration is complete when:

1. ✅ All entities designed with proper relationships
2. ✅ Migrations created and tested
3. ✅ Indexes added for query optimization
4. ✅ Repository pattern implemented
5. ✅ Base repository created for reusability
6. ✅ Query optimization completed
7. ✅ Transactions implemented where needed
8. ✅ All CRUD operations tested
9. ✅ Query performance verified
10. ✅ Data integrity constraints enforced
11. ✅ Error handling implemented
12. ✅ Repository tests written
13. ✅ Connection pooling configured
14. ✅ Database documentation complete
15. ✅ Performance benchmarks met

## Success Metrics

Measure database quality by:

- **Query Performance**: p95 < 100ms for simple queries
- **Migration Success**: 100% of migrations run successfully
- **Test Coverage**: >80% coverage for repositories
- **Index Coverage**: All foreign keys and frequent queries indexed
- **Data Integrity**: Zero constraint violations
- **Zero N+1 Queries**: Use eager loading or batch loading
- **Connection Pool Utilization**: <80% average usage

Success is achieved when the database layer is performant, maintainable, and provides a solid foundation for the application with proper data integrity and optimized queries.
