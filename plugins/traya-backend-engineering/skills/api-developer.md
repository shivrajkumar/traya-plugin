---
name: api-developer
description: Complete API development workflow from design to tested endpoints with documentation. Use this skill when building RESTful or GraphQL APIs, implementing authentication, designing database schemas, creating endpoints, and ensuring production-ready quality. Uses Postman MCP for API testing, Context7 for framework documentation, and Serena for pattern analysis.
---

# API Developer

## Overview

This skill provides a comprehensive API development workflow covering design, implementation, testing, and documentation. The process includes requirement analysis, API design, database schema creation, endpoint implementation, authentication setup, comprehensive testing, performance optimization, and complete documentation.

## Core Workflow

### Phase 1: Requirements Analysis & Design

**1. Analyze API Requirements**

Identify development needs:
- Functional requirements (resources, operations)
- Authentication & authorization requirements
- Data models and relationships
- Performance requirements (latency, throughput)
- Scalability requirements
- Security requirements (data validation, rate limiting)
- Integration requirements (third-party APIs)

**2. Design API Architecture**

Use Serena MCP to analyze existing patterns:
```
mcp__serena__search_for_pattern - Search for similar API implementations
mcp__serena__get_symbols_overview - Understand existing API structure
mcp__serena__find_symbol - Find controller/service patterns
```

Design decisions:
- API style (REST, GraphQL, gRPC)
- URL structure and versioning
- HTTP methods and status codes
- Authentication strategy (JWT, OAuth2, API keys)
- Request/response formats
- Error handling conventions
- Pagination strategy
- Rate limiting approach

**3. Research Framework Documentation**

Use Context7 MCP for best practices:
```
mcp__context7__get-library-docs - Get Express.js/Fastify/NestJS docs
mcp__context7__get-library-docs - Get authentication library docs
mcp__context7__get-library-docs - Get validation library docs
```

Research:
- Framework-specific patterns
- Middleware architecture
- Validation libraries (Joi, Zod, class-validator)
- ORM features (TypeORM, Prisma, Sequelize)
- Security best practices

**4. Create API Specification**

Define OpenAPI/Swagger specification:

```yaml
# openapi.yaml
openapi: 3.1.0
info:
  title: User Management API
  version: 1.0.0
  description: Complete user management system with authentication

servers:
  - url: http://localhost:3000/api/v1
    description: Development server

paths:
  /users:
    get:
      summary: List users
      tags: [Users]
      parameters:
        - name: page
          in: query
          schema:
            type: integer
            default: 1
        - name: limit
          in: query
          schema:
            type: integer
            default: 20
      responses:
        '200':
          description: Successful response
          content:
            application/json:
              schema:
                type: object
                properties:
                  data:
                    type: array
                    items:
                      $ref: '#/components/schemas/User'
                  meta:
                    $ref: '#/components/schemas/PaginationMeta'

    post:
      summary: Create user
      tags: [Users]
      security:
        - bearerAuth: []
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/CreateUserRequest'
      responses:
        '201':
          description: User created
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/User'

  /users/{id}:
    get:
      summary: Get user by ID
      tags: [Users]
      parameters:
        - name: id
          in: path
          required: true
          schema:
            type: string
            format: uuid
      responses:
        '200':
          description: Successful response
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/User'
        '404':
          description: User not found

components:
  schemas:
    User:
      type: object
      properties:
        id:
          type: string
          format: uuid
        email:
          type: string
          format: email
        name:
          type: string
        role:
          type: string
          enum: [admin, user, guest]
        createdAt:
          type: string
          format: date-time
        updatedAt:
          type: string
          format: date-time

    CreateUserRequest:
      type: object
      required:
        - email
        - password
        - name
      properties:
        email:
          type: string
          format: email
        password:
          type: string
          minLength: 8
        name:
          type: string
          minLength: 2

    PaginationMeta:
      type: object
      properties:
        page:
          type: integer
        limit:
          type: integer
        total:
          type: integer
        totalPages:
          type: integer

  securitySchemes:
    bearerAuth:
      type: http
      scheme: bearer
      bearerFormat: JWT
```

### Phase 2: Database Schema Implementation

**5. Design Database Schema**

Create entity models with TypeORM:

```typescript
// src/entities/User.entity.ts
import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  CreateDateColumn,
  UpdateDateColumn,
  Index,
  OneToMany,
} from 'typeorm';
import { Post } from './Post.entity';

export enum UserRole {
  ADMIN = 'admin',
  USER = 'user',
  GUEST = 'guest',
}

@Entity('users')
@Index(['email'], { unique: true })
export class User {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column({ type: 'varchar', length: 255, unique: true })
  @Index()
  email: string;

  @Column({ type: 'varchar', length: 255 })
  name: string;

  @Column({ type: 'varchar', length: 255, select: false })
  password: string;

  @Column({
    type: 'enum',
    enum: UserRole,
    default: UserRole.USER,
  })
  role: UserRole;

  @Column({ type: 'boolean', default: false })
  emailVerified: boolean;

  @Column({ type: 'varchar', length: 255, nullable: true })
  avatar: string | null;

  @OneToMany(() => Post, (post) => post.author)
  posts: Post[];

  @CreateDateColumn()
  createdAt: Date;

  @UpdateDateColumn()
  updatedAt: Date;

  @Column({ type: 'timestamp', nullable: true })
  lastLoginAt: Date | null;
}
```

**6. Create Database Migration**

Generate and customize migration:

```typescript
// src/migrations/1699999999999-CreateUsersTable.ts
import { MigrationInterface, QueryRunner, Table, TableIndex } from 'typeorm';

export class CreateUsersTable1699999999999 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.createTable(
      new Table({
        name: 'users',
        columns: [
          {
            name: 'id',
            type: 'uuid',
            isPrimary: true,
            generationStrategy: 'uuid',
            default: 'uuid_generate_v4()',
          },
          {
            name: 'email',
            type: 'varchar',
            length: '255',
            isUnique: true,
          },
          {
            name: 'name',
            type: 'varchar',
            length: '255',
          },
          {
            name: 'password',
            type: 'varchar',
            length: '255',
          },
          {
            name: 'role',
            type: 'enum',
            enum: ['admin', 'user', 'guest'],
            default: "'user'",
          },
          {
            name: 'emailVerified',
            type: 'boolean',
            default: false,
          },
          {
            name: 'avatar',
            type: 'varchar',
            length: '255',
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
            onUpdate: 'CURRENT_TIMESTAMP',
          },
          {
            name: 'lastLoginAt',
            type: 'timestamp',
            isNullable: true,
          },
        ],
      }),
      true
    );

    // Create indexes
    await queryRunner.createIndex(
      'users',
      new TableIndex({
        name: 'IDX_USERS_EMAIL',
        columnNames: ['email'],
      })
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.dropTable('users');
  }
}
```

### Phase 3: Service Layer Implementation

**7. Create Data Transfer Objects (DTOs)**

Define validation schemas:

```typescript
// src/dtos/user.dto.ts
import {
  IsEmail,
  IsString,
  MinLength,
  MaxLength,
  IsEnum,
  IsOptional,
  IsUUID,
} from 'class-validator';
import { UserRole } from '@/entities/User.entity';

export class CreateUserDto {
  @IsEmail()
  email: string;

  @IsString()
  @MinLength(8)
  @MaxLength(100)
  password: string;

  @IsString()
  @MinLength(2)
  @MaxLength(100)
  name: string;

  @IsEnum(UserRole)
  @IsOptional()
  role?: UserRole;
}

export class UpdateUserDto {
  @IsString()
  @MinLength(2)
  @MaxLength(100)
  @IsOptional()
  name?: string;

  @IsString()
  @IsOptional()
  avatar?: string;
}

export class UserResponseDto {
  @IsUUID()
  id: string;

  @IsEmail()
  email: string;

  @IsString()
  name: string;

  @IsEnum(UserRole)
  role: UserRole;

  @IsString()
  @IsOptional()
  avatar?: string | null;

  createdAt: Date;
  updatedAt: Date;
}
```

**8. Implement Service Layer**

Create business logic services:

```typescript
// src/services/user.service.ts
import { Injectable, NotFoundException, ConflictException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import * as bcrypt from 'bcrypt';
import { User } from '@/entities/User.entity';
import { CreateUserDto, UpdateUserDto, UserResponseDto } from '@/dtos/user.dto';

export interface PaginationParams {
  page: number;
  limit: number;
}

export interface PaginatedResponse<T> {
  data: T[];
  meta: {
    page: number;
    limit: number;
    total: number;
    totalPages: number;
  };
}

@Injectable()
export class UserService {
  constructor(
    @InjectRepository(User)
    private readonly userRepository: Repository<User>,
  ) {}

  async create(createUserDto: CreateUserDto): Promise<UserResponseDto> {
    const existingUser = await this.userRepository.findOne({
      where: { email: createUserDto.email },
    });

    if (existingUser) {
      throw new ConflictException('Email already exists');
    }

    const hashedPassword = await bcrypt.hash(createUserDto.password, 10);

    const user = this.userRepository.create({
      ...createUserDto,
      password: hashedPassword,
    });

    const savedUser = await this.userRepository.save(user);

    return this.toResponseDto(savedUser);
  }

  async findAll(params: PaginationParams): Promise<PaginatedResponse<UserResponseDto>> {
    const { page, limit } = params;
    const skip = (page - 1) * limit;

    const [users, total] = await this.userRepository.findAndCount({
      skip,
      take: limit,
      order: { createdAt: 'DESC' },
    });

    return {
      data: users.map((user) => this.toResponseDto(user)),
      meta: {
        page,
        limit,
        total,
        totalPages: Math.ceil(total / limit),
      },
    };
  }

  async findById(id: string): Promise<UserResponseDto> {
    const user = await this.userRepository.findOne({ where: { id } });

    if (!user) {
      throw new NotFoundException(`User with ID ${id} not found`);
    }

    return this.toResponseDto(user);
  }

  async update(id: string, updateUserDto: UpdateUserDto): Promise<UserResponseDto> {
    const user = await this.userRepository.findOne({ where: { id } });

    if (!user) {
      throw new NotFoundException(`User with ID ${id} not found`);
    }

    Object.assign(user, updateUserDto);
    const updatedUser = await this.userRepository.save(user);

    return this.toResponseDto(updatedUser);
  }

  async delete(id: string): Promise<void> {
    const result = await this.userRepository.delete(id);

    if (result.affected === 0) {
      throw new NotFoundException(`User with ID ${id} not found`);
    }
  }

  private toResponseDto(user: User): UserResponseDto {
    const { password, ...userWithoutPassword } = user;
    return userWithoutPassword as UserResponseDto;
  }
}
```

### Phase 4: Controller & Route Implementation

**9. Create Controllers**

Implement API endpoints:

```typescript
// src/controllers/user.controller.ts
import {
  Controller,
  Get,
  Post,
  Put,
  Delete,
  Param,
  Body,
  Query,
  HttpCode,
  HttpStatus,
  UseGuards,
  ParseUUIDPipe,
  ValidationPipe,
} from '@nestjs/common';
import {
  ApiTags,
  ApiOperation,
  ApiResponse,
  ApiBearerAuth,
  ApiQuery,
} from '@nestjs/swagger';
import { UserService } from '@/services/user.service';
import { CreateUserDto, UpdateUserDto, UserResponseDto } from '@/dtos/user.dto';
import { JwtAuthGuard } from '@/guards/jwt-auth.guard';
import { RolesGuard } from '@/guards/roles.guard';
import { Roles } from '@/decorators/roles.decorator';
import { UserRole } from '@/entities/User.entity';

@ApiTags('users')
@Controller('users')
export class UserController {
  constructor(private readonly userService: UserService) {}

  @Post()
  @ApiBearerAuth()
  @UseGuards(JwtAuthGuard, RolesGuard)
  @Roles(UserRole.ADMIN)
  @HttpCode(HttpStatus.CREATED)
  @ApiOperation({ summary: 'Create a new user' })
  @ApiResponse({
    status: 201,
    description: 'User created successfully',
    type: UserResponseDto,
  })
  @ApiResponse({ status: 409, description: 'Email already exists' })
  async create(
    @Body(ValidationPipe) createUserDto: CreateUserDto,
  ): Promise<UserResponseDto> {
    return this.userService.create(createUserDto);
  }

  @Get()
  @ApiOperation({ summary: 'List all users with pagination' })
  @ApiQuery({ name: 'page', required: false, type: Number })
  @ApiQuery({ name: 'limit', required: false, type: Number })
  @ApiResponse({ status: 200, description: 'Users retrieved successfully' })
  async findAll(
    @Query('page') page: number = 1,
    @Query('limit') limit: number = 20,
  ) {
    return this.userService.findAll({ page, limit });
  }

  @Get(':id')
  @ApiOperation({ summary: 'Get user by ID' })
  @ApiResponse({
    status: 200,
    description: 'User retrieved successfully',
    type: UserResponseDto,
  })
  @ApiResponse({ status: 404, description: 'User not found' })
  async findById(
    @Param('id', ParseUUIDPipe) id: string,
  ): Promise<UserResponseDto> {
    return this.userService.findById(id);
  }

  @Put(':id')
  @ApiBearerAuth()
  @UseGuards(JwtAuthGuard)
  @ApiOperation({ summary: 'Update user by ID' })
  @ApiResponse({
    status: 200,
    description: 'User updated successfully',
    type: UserResponseDto,
  })
  @ApiResponse({ status: 404, description: 'User not found' })
  async update(
    @Param('id', ParseUUIDPipe) id: string,
    @Body(ValidationPipe) updateUserDto: UpdateUserDto,
  ): Promise<UserResponseDto> {
    return this.userService.update(id, updateUserDto);
  }

  @Delete(':id')
  @ApiBearerAuth()
  @UseGuards(JwtAuthGuard, RolesGuard)
  @Roles(UserRole.ADMIN)
  @HttpCode(HttpStatus.NO_CONTENT)
  @ApiOperation({ summary: 'Delete user by ID' })
  @ApiResponse({ status: 204, description: 'User deleted successfully' })
  @ApiResponse({ status: 404, description: 'User not found' })
  async delete(@Param('id', ParseUUIDPipe) id: string): Promise<void> {
    return this.userService.delete(id);
  }
}
```

**10. Implement Authentication**

Create JWT authentication:

```typescript
// src/services/auth.service.ts
import { Injectable, UnauthorizedException } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import * as bcrypt from 'bcrypt';
import { User } from '@/entities/User.entity';

export interface LoginDto {
  email: string;
  password: string;
}

export interface AuthResponse {
  accessToken: string;
  refreshToken: string;
  user: {
    id: string;
    email: string;
    name: string;
    role: string;
  };
}

@Injectable()
export class AuthService {
  constructor(
    @InjectRepository(User)
    private readonly userRepository: Repository<User>,
    private readonly jwtService: JwtService,
  ) {}

  async login(loginDto: LoginDto): Promise<AuthResponse> {
    const user = await this.userRepository.findOne({
      where: { email: loginDto.email },
      select: ['id', 'email', 'name', 'role', 'password'],
    });

    if (!user) {
      throw new UnauthorizedException('Invalid credentials');
    }

    const isPasswordValid = await bcrypt.compare(loginDto.password, user.password);

    if (!isPasswordValid) {
      throw new UnauthorizedException('Invalid credentials');
    }

    // Update last login
    await this.userRepository.update(user.id, { lastLoginAt: new Date() });

    const tokens = await this.generateTokens(user);

    return {
      ...tokens,
      user: {
        id: user.id,
        email: user.email,
        name: user.name,
        role: user.role,
      },
    };
  }

  async generateTokens(user: User) {
    const payload = { sub: user.id, email: user.email, role: user.role };

    const [accessToken, refreshToken] = await Promise.all([
      this.jwtService.signAsync(payload, { expiresIn: '15m' }),
      this.jwtService.signAsync(payload, { expiresIn: '7d' }),
    ]);

    return { accessToken, refreshToken };
  }

  async validateUser(userId: string): Promise<User | null> {
    return this.userRepository.findOne({ where: { id: userId } });
  }
}
```

### Phase 5: Middleware & Error Handling

**11. Create Global Error Handler**

Implement error handling middleware:

```typescript
// src/filters/http-exception.filter.ts
import {
  ExceptionFilter,
  Catch,
  ArgumentsHost,
  HttpException,
  HttpStatus,
} from '@nestjs/common';
import { Request, Response } from 'express';

export interface ErrorResponse {
  statusCode: number;
  timestamp: string;
  path: string;
  message: string | string[];
  error?: string;
}

@Catch()
export class AllExceptionsFilter implements ExceptionFilter {
  catch(exception: unknown, host: ArgumentsHost) {
    const ctx = host.switchToHttp();
    const response = ctx.getResponse<Response>();
    const request = ctx.getRequest<Request>();

    let status = HttpStatus.INTERNAL_SERVER_ERROR;
    let message: string | string[] = 'Internal server error';
    let error = 'Internal Server Error';

    if (exception instanceof HttpException) {
      status = exception.getStatus();
      const exceptionResponse = exception.getResponse();

      if (typeof exceptionResponse === 'string') {
        message = exceptionResponse;
      } else if (typeof exceptionResponse === 'object') {
        message = (exceptionResponse as any).message || message;
        error = (exceptionResponse as any).error || error;
      }
    } else if (exception instanceof Error) {
      message = exception.message;
    }

    const errorResponse: ErrorResponse = {
      statusCode: status,
      timestamp: new Date().toISOString(),
      path: request.url,
      message,
      error,
    };

    // Log error for monitoring
    console.error('Error:', {
      ...errorResponse,
      stack: exception instanceof Error ? exception.stack : undefined,
    });

    response.status(status).json(errorResponse);
  }
}
```

**12. Implement Request Validation**

Add global validation pipe:

```typescript
// src/main.ts
import { NestFactory } from '@nestjs/core';
import { ValidationPipe } from '@nestjs/common';
import { SwaggerModule, DocumentBuilder } from '@nestjs/swagger';
import { AppModule } from './app.module';
import { AllExceptionsFilter } from './filters/http-exception.filter';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  // Global prefix
  app.setGlobalPrefix('api/v1');

  // Global validation
  app.useGlobalPipes(
    new ValidationPipe({
      whitelist: true,
      forbidNonWhitelisted: true,
      transform: true,
      transformOptions: {
        enableImplicitConversion: true,
      },
    }),
  );

  // Global error handling
  app.useGlobalFilters(new AllExceptionsFilter());

  // CORS
  app.enableCors({
    origin: process.env.ALLOWED_ORIGINS?.split(',') || '*',
    credentials: true,
  });

  // Swagger documentation
  const config = new DocumentBuilder()
    .setTitle('User Management API')
    .setDescription('Complete user management system')
    .setVersion('1.0')
    .addBearerAuth()
    .build();

  const document = SwaggerModule.createDocument(app, config);
  SwaggerModule.setup('api/docs', app, document);

  await app.listen(process.env.PORT || 3000);
}

bootstrap();
```

### Phase 6: Testing & Verification

**13. Test with Postman MCP**

Use Postman to verify endpoints:
```
mcp__postman__postman - Test all endpoints
```

Test scenarios:
- **Create User**: POST /api/v1/users with valid data
- **Validation Errors**: POST with invalid email/password
- **Get User**: GET /api/v1/users/{id} with valid UUID
- **List Users**: GET /api/v1/users?page=1&limit=20
- **Update User**: PUT /api/v1/users/{id} with auth token
- **Delete User**: DELETE /api/v1/users/{id} with admin token
- **Authentication**: POST /api/v1/auth/login
- **Authorization**: Test protected routes without token
- **Rate Limiting**: Rapid requests to test limits
- **Error Handling**: Invalid UUIDs, missing fields

**14. Write Unit Tests**

Create comprehensive tests:

```typescript
// src/services/user.service.spec.ts
import { Test, TestingModule } from '@nestjs/testing';
import { getRepositoryToken } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { UserService } from './user.service';
import { User, UserRole } from '@/entities/User.entity';
import { NotFoundException, ConflictException } from '@nestjs/common';

describe('UserService', () => {
  let service: UserService;
  let repository: Repository<User>;

  const mockUser: User = {
    id: '123e4567-e89b-12d3-a456-426614174000',
    email: 'test@example.com',
    name: 'Test User',
    password: 'hashedpassword',
    role: UserRole.USER,
    emailVerified: false,
    avatar: null,
    posts: [],
    createdAt: new Date(),
    updatedAt: new Date(),
    lastLoginAt: null,
  };

  const mockRepository = {
    create: jest.fn(),
    save: jest.fn(),
    findOne: jest.fn(),
    findAndCount: jest.fn(),
    update: jest.fn(),
    delete: jest.fn(),
  };

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        UserService,
        {
          provide: getRepositoryToken(User),
          useValue: mockRepository,
        },
      ],
    }).compile();

    service = module.get<UserService>(UserService);
    repository = module.get<Repository<User>>(getRepositoryToken(User));
  });

  afterEach(() => {
    jest.clearAllMocks();
  });

  describe('create', () => {
    it('should create a new user successfully', async () => {
      const createUserDto = {
        email: 'test@example.com',
        password: 'password123',
        name: 'Test User',
      };

      mockRepository.findOne.mockResolvedValue(null);
      mockRepository.create.mockReturnValue(mockUser);
      mockRepository.save.mockResolvedValue(mockUser);

      const result = await service.create(createUserDto);

      expect(result).toEqual(expect.objectContaining({
        id: mockUser.id,
        email: mockUser.email,
        name: mockUser.name,
      }));
      expect(result).not.toHaveProperty('password');
    });

    it('should throw ConflictException if email exists', async () => {
      const createUserDto = {
        email: 'test@example.com',
        password: 'password123',
        name: 'Test User',
      };

      mockRepository.findOne.mockResolvedValue(mockUser);

      await expect(service.create(createUserDto)).rejects.toThrow(
        ConflictException,
      );
    });
  });

  describe('findById', () => {
    it('should return user when found', async () => {
      mockRepository.findOne.mockResolvedValue(mockUser);

      const result = await service.findById(mockUser.id);

      expect(result.id).toBe(mockUser.id);
      expect(mockRepository.findOne).toHaveBeenCalledWith({
        where: { id: mockUser.id },
      });
    });

    it('should throw NotFoundException when user not found', async () => {
      mockRepository.findOne.mockResolvedValue(null);

      await expect(service.findById('nonexistent-id')).rejects.toThrow(
        NotFoundException,
      );
    });
  });
});
```

**15. Write Integration Tests**

Test API endpoints end-to-end:

```typescript
// test/users.e2e-spec.ts
import { Test, TestingModule } from '@nestjs/testing';
import { INestApplication } from '@nestjs/common';
import * as request from 'supertest';
import { AppModule } from '@/app.module';

describe('UserController (e2e)', () => {
  let app: INestApplication;
  let authToken: string;
  let userId: string;

  beforeAll(async () => {
    const moduleFixture: TestingModule = await Test.createTestingModule({
      imports: [AppModule],
    }).compile();

    app = moduleFixture.createNestApplication();
    await app.init();

    // Login to get auth token
    const loginResponse = await request(app.getHttpServer())
      .post('/api/v1/auth/login')
      .send({
        email: 'admin@example.com',
        password: 'admin123',
      });

    authToken = loginResponse.body.accessToken;
  });

  afterAll(async () => {
    await app.close();
  });

  describe('/api/v1/users (POST)', () => {
    it('should create a new user', () => {
      return request(app.getHttpServer())
        .post('/api/v1/users')
        .set('Authorization', `Bearer ${authToken}`)
        .send({
          email: 'newuser@example.com',
          password: 'password123',
          name: 'New User',
        })
        .expect(201)
        .expect((res) => {
          expect(res.body).toHaveProperty('id');
          expect(res.body.email).toBe('newuser@example.com');
          userId = res.body.id;
        });
    });

    it('should return 409 for duplicate email', () => {
      return request(app.getHttpServer())
        .post('/api/v1/users')
        .set('Authorization', `Bearer ${authToken}`)
        .send({
          email: 'newuser@example.com',
          password: 'password123',
          name: 'Duplicate User',
        })
        .expect(409);
    });
  });

  describe('/api/v1/users/:id (GET)', () => {
    it('should get user by id', () => {
      return request(app.getHttpServer())
        .get(`/api/v1/users/${userId}`)
        .expect(200)
        .expect((res) => {
          expect(res.body.id).toBe(userId);
          expect(res.body).not.toHaveProperty('password');
        });
    });

    it('should return 404 for non-existent user', () => {
      return request(app.getHttpServer())
        .get('/api/v1/users/123e4567-e89b-12d3-a456-426614174999')
        .expect(404);
    });
  });
});
```

### Phase 7: Performance Optimization

**16. Add Caching**

Implement Redis caching:

```typescript
// src/services/cache.service.ts
import { Injectable, Inject } from '@nestjs/common';
import { CACHE_MANAGER } from '@nestjs/cache-manager';
import { Cache } from 'cache-manager';

@Injectable()
export class CacheService {
  constructor(@Inject(CACHE_MANAGER) private cacheManager: Cache) {}

  async get<T>(key: string): Promise<T | null> {
    return this.cacheManager.get<T>(key);
  }

  async set(key: string, value: any, ttl: number = 3600): Promise<void> {
    await this.cacheManager.set(key, value, ttl);
  }

  async delete(key: string): Promise<void> {
    await this.cacheManager.del(key);
  }

  async invalidatePattern(pattern: string): Promise<void> {
    const keys = await this.cacheManager.store.keys();
    const matchingKeys = keys.filter((key: string) => key.includes(pattern));
    await Promise.all(matchingKeys.map((key: string) => this.delete(key)));
  }
}
```

**17. Implement Rate Limiting**

Add rate limiting middleware:

```typescript
// src/middleware/rate-limit.middleware.ts
import { Injectable, NestMiddleware } from '@nestjs/common';
import { Request, Response, NextFunction } from 'express';
import * as rateLimit from 'express-rate-limit';

export const apiLimiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 100, // limit each IP to 100 requests per windowMs
  message: 'Too many requests from this IP, please try again later',
  standardHeaders: true,
  legacyHeaders: false,
});

export const authLimiter = rateLimit({
  windowMs: 15 * 60 * 1000,
  max: 5, // limit each IP to 5 login requests per windowMs
  message: 'Too many login attempts, please try again later',
  skipSuccessfulRequests: true,
});
```

## Best Practices

1. **Follow RESTful Conventions**: Use proper HTTP methods and status codes
2. **Validate All Input**: Use DTOs and validation pipes
3. **Secure Passwords**: Always hash passwords with bcrypt
4. **Use TypeORM Migrations**: Never modify schema directly
5. **Implement Proper Error Handling**: Global exception filters
6. **Add Authentication & Authorization**: JWT with role-based access
7. **Write Comprehensive Tests**: Unit, integration, and E2E tests
8. **Document with OpenAPI**: Keep Swagger docs updated
9. **Implement Caching**: Redis for frequently accessed data
10. **Add Rate Limiting**: Protect against abuse
11. **Use Database Indexes**: Optimize query performance
12. **Log Everything**: Structured logging for debugging
13. **Handle Database Transactions**: Use transactions for multi-step operations
14. **Implement Pagination**: Always paginate list endpoints
15. **Version Your API**: Use versioning in URLs (/api/v1)

## Completion Criteria

API development is complete when:

1. ✅ OpenAPI specification is complete and accurate
2. ✅ Database schema is designed with proper indexes
3. ✅ Migrations are created and tested
4. ✅ DTOs have comprehensive validation rules
5. ✅ Service layer implements all business logic
6. ✅ Controllers handle all endpoints correctly
7. ✅ Authentication and authorization work properly
8. ✅ All endpoints tested with Postman MCP
9. ✅ Unit tests cover all service methods
10. ✅ Integration tests cover all endpoints
11. ✅ Error handling works for all edge cases
12. ✅ Rate limiting is implemented
13. ✅ Caching is implemented for performance
14. ✅ Documentation is complete and published
15. ✅ Performance benchmarks are met

## Success Metrics

Measure API quality by:

- **Test Coverage**: >80% code coverage
- **Response Time**: p95 < 200ms for simple queries
- **Error Rate**: <1% of requests fail
- **Security**: All OWASP Top 10 vulnerabilities addressed
- **Documentation**: 100% of endpoints documented
- **Type Safety**: Zero TypeScript errors
- **Validation**: All inputs validated before processing

Success is achieved when the API is secure, performant, well-tested, and properly documented, providing a robust foundation for frontend applications.
