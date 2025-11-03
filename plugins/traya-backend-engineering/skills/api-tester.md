---
name: api-tester
description: Comprehensive API testing workflow covering unit, integration, and E2E tests with Postman validation. Use this skill when testing REST APIs, validating endpoints, writing test suites, ensuring code coverage, and verifying API contracts. Uses Postman MCP for API testing, Context7 for testing framework documentation, and Serena for test pattern analysis.
---

# API Tester

## Overview

This skill provides a complete API testing workflow covering unit tests, integration tests, end-to-end tests, contract testing, performance testing, and security testing. The process includes test planning, writing comprehensive test suites, implementing test utilities, validating with Postman, measuring coverage, and ensuring production-ready API quality.

## Core Workflow

### Phase 1: Test Planning & Strategy

**1. Analyze Testing Requirements**

Identify testing scope:
- Unit test coverage (services, repositories, utilities)
- Integration test coverage (controllers, middleware, database)
- E2E test coverage (complete user flows)
- Contract testing (API specifications)
- Performance testing (load, stress)
- Security testing (authentication, authorization, injection)
- Edge cases and error scenarios

**2. Research Testing Patterns**

Use Serena MCP to find existing tests:
```
mcp__serena__search_for_pattern - Search for test patterns
mcp__serena__find_symbol - Find existing test files
mcp__serena__get_symbols_overview - Understand test structure
```

Analyze:
- Test file organization
- Mock strategies
- Fixture patterns
- Test utilities
- Coverage configuration

**3. Study Testing Frameworks**

Use Context7 MCP for testing documentation:
```
mcp__context7__get-library-docs - Get Jest documentation
mcp__context7__get-library-docs - Get Supertest documentation
mcp__context7__get-library-docs - Get Testing Library docs
```

Research:
- Jest configuration and best practices
- Supertest for HTTP testing
- Test fixtures and factories
- Mocking strategies
- Code coverage tools

**4. Define Test Categories**

Organize tests by type:

```
tests/
├── unit/
│   ├── services/          # Business logic tests
│   ├── repositories/      # Data access tests
│   ├── utils/             # Utility function tests
│   └── validators/        # Validation tests
├── integration/
│   ├── controllers/       # API endpoint tests
│   ├── middleware/        # Middleware tests
│   └── database/          # Database integration tests
├── e2e/
│   ├── auth.e2e-spec.ts   # Authentication flows
│   ├── users.e2e-spec.ts  # User management flows
│   └── posts.e2e-spec.ts  # Post management flows
├── fixtures/              # Test data
├── mocks/                 # Mock objects
└── utils/                 # Test utilities
```

### Phase 2: Unit Testing

**5. Test Service Layer**

Create comprehensive service tests:

```typescript
// tests/unit/services/user.service.spec.ts
import { Test, TestingModule } from '@nestjs/testing';
import { getRepositoryToken } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { ConflictException, NotFoundException } from '@nestjs/common';
import { UserService } from '@/services/user.service';
import { User, UserRole } from '@/entities/User.entity';
import { CreateUserDto } from '@/dtos/user.dto';

describe('UserService', () => {
  let service: UserService;
  let repository: Repository<User>;

  const mockUser: User = {
    id: '123e4567-e89b-12d3-a456-426614174000',
    email: 'test@example.com',
    name: 'Test User',
    password: '$2b$10$hashedpassword',
    role: UserRole.USER,
    status: 'active',
    emailVerified: false,
    avatar: null,
    lastLoginAt: null,
    createdAt: new Date('2024-01-01'),
    updatedAt: new Date('2024-01-01'),
    posts: [],
    comments: [],
    toJSON: () => ({ id: '123', email: 'test@example.com', name: 'Test User' }),
    hashPassword: async () => {},
    setDefaults: async () => {},
    comparePassword: async () => true,
    hasId: () => true,
    save: async () => mockUser,
    remove: async () => mockUser,
    softRemove: async () => mockUser,
    recover: async () => mockUser,
    reload: async () => {},
  };

  const mockRepository = {
    create: jest.fn(),
    save: jest.fn(),
    findOne: jest.fn(),
    findAndCount: jest.fn(),
    find: jest.fn(),
    update: jest.fn(),
    delete: jest.fn(),
    count: jest.fn(),
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
    const createUserDto: CreateUserDto = {
      email: 'newuser@example.com',
      password: 'password123',
      name: 'New User',
    };

    it('should create a new user successfully', async () => {
      mockRepository.findOne.mockResolvedValue(null);
      mockRepository.create.mockReturnValue(mockUser);
      mockRepository.save.mockResolvedValue(mockUser);

      const result = await service.create(createUserDto);

      expect(mockRepository.findOne).toHaveBeenCalledWith({
        where: { email: createUserDto.email },
      });
      expect(mockRepository.create).toHaveBeenCalled();
      expect(mockRepository.save).toHaveBeenCalled();
      expect(result).toBeDefined();
      expect(result.email).toBe(mockUser.email);
    });

    it('should throw ConflictException if email already exists', async () => {
      mockRepository.findOne.mockResolvedValue(mockUser);

      await expect(service.create(createUserDto)).rejects.toThrow(
        ConflictException
      );
      expect(mockRepository.save).not.toHaveBeenCalled();
    });

    it('should hash password before saving', async () => {
      mockRepository.findOne.mockResolvedValue(null);
      mockRepository.create.mockReturnValue(mockUser);
      mockRepository.save.mockResolvedValue(mockUser);

      await service.create(createUserDto);

      const savedUser = mockRepository.save.mock.calls[0][0];
      expect(savedUser.password).not.toBe(createUserDto.password);
    });
  });

  describe('findById', () => {
    it('should return user when found', async () => {
      mockRepository.findOne.mockResolvedValue(mockUser);

      const result = await service.findById(mockUser.id);

      expect(result).toEqual(expect.objectContaining({
        id: mockUser.id,
        email: mockUser.email,
      }));
      expect(mockRepository.findOne).toHaveBeenCalledWith({
        where: { id: mockUser.id },
      });
    });

    it('should throw NotFoundException when user not found', async () => {
      mockRepository.findOne.mockResolvedValue(null);

      await expect(service.findById('nonexistent-id')).rejects.toThrow(
        NotFoundException
      );
    });
  });

  describe('findAll', () => {
    it('should return paginated users', async () => {
      const users = [mockUser];
      mockRepository.findAndCount.mockResolvedValue([users, 1]);

      const result = await service.findAll({ page: 1, limit: 20 });

      expect(result.data).toEqual(users);
      expect(result.meta).toEqual({
        page: 1,
        limit: 20,
        total: 1,
        totalPages: 1,
      });
    });

    it('should calculate total pages correctly', async () => {
      mockRepository.findAndCount.mockResolvedValue([[], 45]);

      const result = await service.findAll({ page: 1, limit: 20 });

      expect(result.meta.totalPages).toBe(3); // 45 / 20 = 2.25 → 3
    });
  });

  describe('update', () => {
    const updateUserDto = { name: 'Updated Name' };

    it('should update user successfully', async () => {
      const updatedUser = { ...mockUser, name: 'Updated Name' };
      mockRepository.findOne.mockResolvedValue(mockUser);
      mockRepository.save.mockResolvedValue(updatedUser);

      const result = await service.update(mockUser.id, updateUserDto);

      expect(result.name).toBe('Updated Name');
      expect(mockRepository.save).toHaveBeenCalled();
    });

    it('should throw NotFoundException when user not found', async () => {
      mockRepository.findOne.mockResolvedValue(null);

      await expect(
        service.update('nonexistent-id', updateUserDto)
      ).rejects.toThrow(NotFoundException);
    });
  });

  describe('delete', () => {
    it('should delete user successfully', async () => {
      mockRepository.delete.mockResolvedValue({ affected: 1 });

      await service.delete(mockUser.id);

      expect(mockRepository.delete).toHaveBeenCalledWith(mockUser.id);
    });

    it('should throw NotFoundException when user not found', async () => {
      mockRepository.delete.mockResolvedValue({ affected: 0 });

      await expect(service.delete('nonexistent-id')).rejects.toThrow(
        NotFoundException
      );
    });
  });
});
```

**6. Test Repository Layer**

Create repository tests:

```typescript
// tests/unit/repositories/user.repository.spec.ts
import { Test, TestingModule } from '@nestjs/testing';
import { getRepositoryToken } from '@nestjs/typeorm';
import { UserRepository } from '@/repositories/User.repository';
import { User, UserRole, UserStatus } from '@/entities/User.entity';

describe('UserRepository', () => {
  let userRepository: UserRepository;
  let mockRepository: any;

  beforeEach(async () => {
    mockRepository = {
      findOne: jest.fn(),
      find: jest.fn(),
      findAndCount: jest.fn(),
      update: jest.fn(),
      createQueryBuilder: jest.fn(() => ({
        where: jest.fn().mockReturnThis(),
        andWhere: jest.fn().mockReturnThis(),
        orderBy: jest.fn().mockReturnThis(),
        skip: jest.fn().mockReturnThis(),
        take: jest.fn().mockReturnThis(),
        getManyAndCount: jest.fn(),
      })),
    };

    const module: TestingModule = await Test.createTestingModule({
      providers: [
        UserRepository,
        {
          provide: getRepositoryToken(User),
          useValue: mockRepository,
        },
      ],
    }).compile();

    userRepository = module.get<UserRepository>(UserRepository);
  });

  describe('findByEmail', () => {
    it('should find user by email with password', async () => {
      const mockUser = {
        id: '123',
        email: 'test@example.com',
        password: 'hashed',
      } as User;

      mockRepository.findOne.mockResolvedValue(mockUser);

      const result = await userRepository.findByEmail('test@example.com');

      expect(result).toEqual(mockUser);
      expect(mockRepository.findOne).toHaveBeenCalledWith({
        where: { email: 'test@example.com' },
        select: expect.arrayContaining(['password']),
      });
    });
  });

  describe('findActiveUsers', () => {
    it('should return only active users', async () => {
      const activeUsers = [
        { id: '1', status: UserStatus.ACTIVE },
        { id: '2', status: UserStatus.ACTIVE },
      ] as User[];

      mockRepository.findAndCount.mockResolvedValue([activeUsers, 2]);

      const result = await userRepository.findActiveUsers(1, 20);

      expect(result.data).toHaveLength(2);
      expect(mockRepository.findAndCount).toHaveBeenCalledWith(
        expect.objectContaining({
          where: { status: UserStatus.ACTIVE },
        })
      );
    });
  });

  describe('searchUsers', () => {
    it('should search users by name or email', async () => {
      const queryBuilder = mockRepository.createQueryBuilder();
      queryBuilder.getManyAndCount.mockResolvedValue([[], 0]);

      await userRepository.searchUsers('john', 1, 20);

      expect(queryBuilder.where).toHaveBeenCalledWith(
        expect.stringContaining('ILIKE'),
        expect.objectContaining({ search: '%john%' })
      );
    });
  });
});
```

**7. Test Utility Functions**

Create utility tests:

```typescript
// tests/unit/utils/validation.spec.ts
import { validateEmail, validatePassword, sanitizeInput } from '@/utils/validation';

describe('Validation Utils', () => {
  describe('validateEmail', () => {
    it('should validate correct email formats', () => {
      expect(validateEmail('user@example.com')).toBe(true);
      expect(validateEmail('user.name@example.co.uk')).toBe(true);
      expect(validateEmail('user+tag@example.com')).toBe(true);
    });

    it('should reject invalid email formats', () => {
      expect(validateEmail('invalid')).toBe(false);
      expect(validateEmail('@example.com')).toBe(false);
      expect(validateEmail('user@')).toBe(false);
      expect(validateEmail('')).toBe(false);
    });
  });

  describe('validatePassword', () => {
    it('should validate strong passwords', () => {
      expect(validatePassword('StrongP@ss123')).toBe(true);
      expect(validatePassword('C0mpl3x!Pass')).toBe(true);
    });

    it('should reject weak passwords', () => {
      expect(validatePassword('weak')).toBe(false);
      expect(validatePassword('12345678')).toBe(false);
      expect(validatePassword('password')).toBe(false);
    });
  });
});
```

### Phase 3: Integration Testing

**8. Test Controllers**

Create controller integration tests:

```typescript
// tests/integration/controllers/user.controller.spec.ts
import { Test, TestingModule } from '@nestjs/testing';
import { INestApplication, ValidationPipe } from '@nestjs/common';
import * as request from 'supertest';
import { AppModule } from '@/app.module';
import { getRepositoryToken } from '@nestjs/typeorm';
import { User } from '@/entities/User.entity';

describe('UserController (Integration)', () => {
  let app: INestApplication;
  let mockRepository: any;

  beforeAll(async () => {
    mockRepository = {
      findOne: jest.fn(),
      findAndCount: jest.fn(),
      create: jest.fn(),
      save: jest.fn(),
      update: jest.fn(),
      delete: jest.fn(),
    };

    const moduleFixture: TestingModule = await Test.createTestingModule({
      imports: [AppModule],
    })
      .overrideProvider(getRepositoryToken(User))
      .useValue(mockRepository)
      .compile();

    app = moduleFixture.createNestApplication();

    app.useGlobalPipes(
      new ValidationPipe({
        whitelist: true,
        forbidNonWhitelisted: true,
        transform: true,
      })
    );

    await app.init();
  });

  afterAll(async () => {
    await app.close();
  });

  describe('POST /users', () => {
    it('should create a new user with valid data', () => {
      const newUser = {
        email: 'newuser@example.com',
        password: 'password123',
        name: 'New User',
      };

      mockRepository.findOne.mockResolvedValue(null);
      mockRepository.create.mockReturnValue(newUser);
      mockRepository.save.mockResolvedValue({
        id: '123',
        ...newUser,
        password: 'hashed',
      });

      return request(app.getHttpServer())
        .post('/api/v1/users')
        .send(newUser)
        .expect(201)
        .expect((res) => {
          expect(res.body).toHaveProperty('id');
          expect(res.body.email).toBe(newUser.email);
          expect(res.body).not.toHaveProperty('password');
        });
    });

    it('should return 400 for invalid email', () => {
      return request(app.getHttpServer())
        .post('/api/v1/users')
        .send({
          email: 'invalid-email',
          password: 'password123',
          name: 'Test User',
        })
        .expect(400)
        .expect((res) => {
          expect(res.body.message).toContain('email');
        });
    });

    it('should return 400 for short password', () => {
      return request(app.getHttpServer())
        .post('/api/v1/users')
        .send({
          email: 'test@example.com',
          password: 'short',
          name: 'Test User',
        })
        .expect(400)
        .expect((res) => {
          expect(res.body.message).toContain('password');
        });
    });

    it('should return 409 for duplicate email', () => {
      mockRepository.findOne.mockResolvedValue({ id: '123' });

      return request(app.getHttpServer())
        .post('/api/v1/users')
        .send({
          email: 'existing@example.com',
          password: 'password123',
          name: 'Test User',
        })
        .expect(409);
    });
  });

  describe('GET /users', () => {
    it('should return paginated users', () => {
      mockRepository.findAndCount.mockResolvedValue([
        [
          { id: '1', email: 'user1@example.com', name: 'User 1' },
          { id: '2', email: 'user2@example.com', name: 'User 2' },
        ],
        2,
      ]);

      return request(app.getHttpServer())
        .get('/api/v1/users?page=1&limit=20')
        .expect(200)
        .expect((res) => {
          expect(res.body).toHaveProperty('data');
          expect(res.body).toHaveProperty('meta');
          expect(res.body.data).toHaveLength(2);
          expect(res.body.meta.page).toBe(1);
          expect(res.body.meta.total).toBe(2);
        });
    });

    it('should apply default pagination', () => {
      mockRepository.findAndCount.mockResolvedValue([[], 0]);

      return request(app.getHttpServer())
        .get('/api/v1/users')
        .expect(200)
        .expect((res) => {
          expect(res.body.meta.page).toBe(1);
          expect(res.body.meta.limit).toBe(20);
        });
    });
  });

  describe('GET /users/:id', () => {
    it('should return user by id', () => {
      const mockUser = {
        id: '123',
        email: 'test@example.com',
        name: 'Test User',
      };

      mockRepository.findOne.mockResolvedValue(mockUser);

      return request(app.getHttpServer())
        .get('/api/v1/users/123')
        .expect(200)
        .expect((res) => {
          expect(res.body.id).toBe('123');
          expect(res.body.email).toBe('test@example.com');
        });
    });

    it('should return 404 for non-existent user', () => {
      mockRepository.findOne.mockResolvedValue(null);

      return request(app.getHttpServer())
        .get('/api/v1/users/nonexistent-id')
        .expect(404);
    });
  });

  describe('PUT /users/:id', () => {
    it('should update user successfully', () => {
      const existingUser = {
        id: '123',
        email: 'test@example.com',
        name: 'Old Name',
      };

      const updatedUser = {
        ...existingUser,
        name: 'New Name',
      };

      mockRepository.findOne.mockResolvedValue(existingUser);
      mockRepository.save.mockResolvedValue(updatedUser);

      return request(app.getHttpServer())
        .put('/api/v1/users/123')
        .send({ name: 'New Name' })
        .expect(200)
        .expect((res) => {
          expect(res.body.name).toBe('New Name');
        });
    });
  });

  describe('DELETE /users/:id', () => {
    it('should delete user successfully', () => {
      mockRepository.delete.mockResolvedValue({ affected: 1 });

      return request(app.getHttpServer())
        .delete('/api/v1/users/123')
        .expect(204);
    });

    it('should return 404 when user not found', () => {
      mockRepository.delete.mockResolvedValue({ affected: 0 });

      return request(app.getHttpServer())
        .delete('/api/v1/users/nonexistent')
        .expect(404);
    });
  });
});
```

**9. Test Middleware**

Create middleware tests:

```typescript
// tests/integration/middleware/auth.middleware.spec.ts
import { Test, TestingModule } from '@nestjs/testing';
import { INestApplication } from '@nestjs/common';
import * as request from 'supertest';
import { JwtService } from '@nestjs/jwt';
import { AppModule } from '@/app.module';

describe('Authentication Middleware', () => {
  let app: INestApplication;
  let jwtService: JwtService;

  beforeAll(async () => {
    const moduleFixture: TestingModule = await Test.createTestingModule({
      imports: [AppModule],
    }).compile();

    app = moduleFixture.createNestApplication();
    jwtService = moduleFixture.get<JwtService>(JwtService);

    await app.init();
  });

  afterAll(async () => {
    await app.close();
  });

  describe('Protected Routes', () => {
    it('should allow access with valid token', async () => {
      const token = jwtService.sign({ sub: '123', email: 'test@example.com' });

      return request(app.getHttpServer())
        .get('/api/v1/users/me')
        .set('Authorization', `Bearer ${token}`)
        .expect(200);
    });

    it('should reject request without token', () => {
      return request(app.getHttpServer())
        .get('/api/v1/users/me')
        .expect(401);
    });

    it('should reject request with invalid token', () => {
      return request(app.getHttpServer())
        .get('/api/v1/users/me')
        .set('Authorization', 'Bearer invalid-token')
        .expect(401);
    });

    it('should reject request with expired token', () => {
      const expiredToken = jwtService.sign(
        { sub: '123', email: 'test@example.com' },
        { expiresIn: '0s' }
      );

      return request(app.getHttpServer())
        .get('/api/v1/users/me')
        .set('Authorization', `Bearer ${expiredToken}`)
        .expect(401);
    });
  });
});
```

### Phase 4: End-to-End Testing

**10. Test Complete User Flows**

Create E2E tests:

```typescript
// tests/e2e/user-flow.e2e-spec.ts
import { Test, TestingModule } from '@nestjs/testing';
import { INestApplication } from '@nestjs/common';
import * as request from 'supertest';
import { AppModule } from '@/app.module';
import { AppDataSource } from '@/config/database.config';

describe('User Flow (E2E)', () => {
  let app: INestApplication;
  let accessToken: string;
  let userId: string;

  beforeAll(async () => {
    const moduleFixture: TestingModule = await Test.createTestingModule({
      imports: [AppModule],
    }).compile();

    app = moduleFixture.createNestApplication();
    await app.init();

    // Initialize database
    await AppDataSource.initialize();
    await AppDataSource.runMigrations();
  });

  afterAll(async () => {
    // Clean up database
    await AppDataSource.dropDatabase();
    await AppDataSource.destroy();
    await app.close();
  });

  describe('Complete User Journey', () => {
    it('Step 1: Register new user', async () => {
      const response = await request(app.getHttpServer())
        .post('/api/v1/auth/register')
        .send({
          email: 'testuser@example.com',
          password: 'SecurePass123',
          name: 'Test User',
        })
        .expect(201);

      expect(response.body).toHaveProperty('id');
      userId = response.body.id;
    });

    it('Step 2: Login with credentials', async () => {
      const response = await request(app.getHttpServer())
        .post('/api/v1/auth/login')
        .send({
          email: 'testuser@example.com',
          password: 'SecurePass123',
        })
        .expect(200);

      expect(response.body).toHaveProperty('accessToken');
      expect(response.body).toHaveProperty('user');
      accessToken = response.body.accessToken;
    });

    it('Step 3: Get current user profile', async () => {
      const response = await request(app.getHttpServer())
        .get('/api/v1/users/me')
        .set('Authorization', `Bearer ${accessToken}`)
        .expect(200);

      expect(response.body.email).toBe('testuser@example.com');
    });

    it('Step 4: Update user profile', async () => {
      const response = await request(app.getHttpServer())
        .put(`/api/v1/users/${userId}`)
        .set('Authorization', `Bearer ${accessToken}`)
        .send({
          name: 'Updated Test User',
        })
        .expect(200);

      expect(response.body.name).toBe('Updated Test User');
    });

    it('Step 5: Create a post', async () => {
      const response = await request(app.getHttpServer())
        .post('/api/v1/posts')
        .set('Authorization', `Bearer ${accessToken}`)
        .send({
          title: 'My First Post',
          content: 'This is the content of my first post.',
        })
        .expect(201);

      expect(response.body).toHaveProperty('id');
      expect(response.body.title).toBe('My First Post');
    });

    it('Step 6: Get user posts', async () => {
      const response = await request(app.getHttpServer())
        .get(`/api/v1/users/${userId}/posts`)
        .set('Authorization', `Bearer ${accessToken}`)
        .expect(200);

      expect(response.body.data).toHaveLength(1);
      expect(response.body.data[0].title).toBe('My First Post');
    });
  });
});
```

### Phase 5: Postman Testing

**11. Test with Postman MCP**

Use Postman MCP for comprehensive API testing:
```
mcp__postman__postman - Run Postman collection tests
```

Validate:
- All endpoints respond correctly
- Request validation works
- Response formats match specifications
- Error handling is consistent
- Authentication works properly
- Authorization rules are enforced
- Rate limiting is functional
- CORS headers are correct

**12. Create Postman Test Suite**

Build comprehensive Postman tests (see api-documentation-generator.md for detailed examples):

```javascript
// Postman test script for user creation
pm.test('Status code is 201', function () {
    pm.response.to.have.status(201);
});

pm.test('Response has user object', function () {
    const jsonData = pm.response.json();
    pm.expect(jsonData).to.have.property('id');
    pm.expect(jsonData).to.have.property('email');
    pm.expect(jsonData).not.to.have.property('password');
});

pm.test('Email format is valid', function () {
    const jsonData = pm.response.json();
    pm.expect(jsonData.email).to.match(/^[^\s@]+@[^\s@]+\.[^\s@]+$/);
});

pm.test('Response time is acceptable', function () {
    pm.expect(pm.response.responseTime).to.be.below(500);
});

// Save data for next requests
pm.collectionVariables.set('userId', pm.response.json().id);
```

### Phase 6: Coverage & Quality Metrics

**13. Configure Code Coverage**

Setup Jest coverage:

```typescript
// jest.config.js
module.exports = {
  moduleFileExtensions: ['js', 'json', 'ts'],
  rootDir: 'src',
  testRegex: '.*\\.spec\\.ts$',
  transform: {
    '^.+\\.(t|j)s$': 'ts-jest',
  },
  collectCoverageFrom: [
    '**/*.(t|j)s',
    '!**/*.spec.ts',
    '!**/node_modules/**',
    '!**/dist/**',
    '!**/migrations/**',
  ],
  coverageDirectory: '../coverage',
  testEnvironment: 'node',
  coverageThresholds: {
    global: {
      branches: 80,
      functions: 80,
      lines: 80,
      statements: 80,
    },
  },
  coverageReporters: ['text', 'lcov', 'html'],
};
```

**14. Run Coverage Reports**

Generate and analyze coverage:

```bash
# Run tests with coverage
npm run test:cov

# Generate HTML report
npm run test:cov -- --coverage --coverageReporters=html

# View coverage report
open coverage/index.html
```

**15. Write Missing Tests**

Identify untested code:

```typescript
// Example: Adding missing edge case tests
describe('UserService - Edge Cases', () => {
  it('should handle database connection errors', async () => {
    mockRepository.save.mockRejectedValue(new Error('Connection lost'));

    await expect(service.create(createUserDto)).rejects.toThrow();
  });

  it('should handle concurrent email registrations', async () => {
    // Simulate race condition
    mockRepository.findOne.mockResolvedValue(null);
    mockRepository.save.mockRejectedValue({
      code: '23505', // PostgreSQL unique violation
    });

    await expect(service.create(createUserDto)).rejects.toThrow();
  });

  it('should handle malformed UUID', async () => {
    await expect(service.findById('invalid-uuid')).rejects.toThrow();
  });
});
```

### Phase 7: Performance & Security Testing

**16. Test API Performance**

Create performance tests:

```typescript
// tests/performance/load-test.spec.ts
import * as request from 'supertest';
import { performance } from 'perf_hooks';

describe('Performance Tests', () => {
  it('should handle 100 concurrent requests', async () => {
    const requests = Array.from({ length: 100 }, () =>
      request(app.getHttpServer()).get('/api/v1/users?page=1&limit=20')
    );

    const start = performance.now();
    const responses = await Promise.all(requests);
    const end = performance.now();

    responses.forEach((response) => {
      expect(response.status).toBe(200);
    });

    const avgTime = (end - start) / 100;
    expect(avgTime).toBeLessThan(100); // Average < 100ms
  });

  it('should respond within SLA for simple queries', async () => {
    const start = performance.now();

    await request(app.getHttpServer())
      .get('/api/v1/users/123')
      .expect(200);

    const end = performance.now();
    expect(end - start).toBeLessThan(200); // < 200ms
  });
});
```

**17. Test Security**

Create security tests:

```typescript
// tests/security/security.spec.ts
describe('Security Tests', () => {
  it('should prevent SQL injection', async () => {
    const maliciousInput = "'; DROP TABLE users; --";

    await request(app.getHttpServer())
      .get(`/api/v1/users/${maliciousInput}`)
      .expect(400); // Should reject invalid UUID
  });

  it('should prevent XSS in user input', async () => {
    const xssPayload = '<script>alert("XSS")</script>';

    const response = await request(app.getHttpServer())
      .post('/api/v1/users')
      .send({
        email: 'test@example.com',
        password: 'password123',
        name: xssPayload,
      });

    expect(response.body.name).not.toContain('<script>');
  });

  it('should enforce rate limiting', async () => {
    const requests = Array.from({ length: 101 }, () =>
      request(app.getHttpServer()).get('/api/v1/users')
    );

    const responses = await Promise.all(requests);
    const rateLimited = responses.filter((r) => r.status === 429);

    expect(rateLimited.length).toBeGreaterThan(0);
  });

  it('should not expose sensitive data in errors', async () => {
    const response = await request(app.getHttpServer())
      .get('/api/v1/users/nonexistent')
      .expect(404);

    expect(response.body).not.toHaveProperty('stack');
    expect(JSON.stringify(response.body)).not.toContain('password');
  });
});
```

## Best Practices

1. **Follow AAA Pattern**: Arrange, Act, Assert
2. **Test One Thing**: Each test should verify one behavior
3. **Use Descriptive Names**: Test names should explain what they test
4. **Mock External Dependencies**: Isolate unit tests
5. **Clean Up After Tests**: Prevent test pollution
6. **Test Edge Cases**: Boundary conditions, nulls, empty arrays
7. **Test Error Paths**: Not just happy paths
8. **Use Test Fixtures**: Reusable test data
9. **Maintain High Coverage**: Aim for >80% code coverage
10. **Run Tests in CI/CD**: Automate test execution
11. **Test Performance**: Monitor response times
12. **Test Security**: Validate input sanitization
13. **Keep Tests Fast**: Unit tests should run quickly
14. **Test API Contracts**: Ensure backward compatibility
15. **Document Test Scenarios**: Explain complex test cases

## Completion Criteria

API testing is complete when:

1. ✅ Unit tests cover >80% of service logic
2. ✅ Repository tests verify all data operations
3. ✅ Integration tests cover all endpoints
4. ✅ E2E tests validate complete user flows
5. ✅ Postman collection tests all APIs
6. ✅ Error handling tests verify all edge cases
7. ✅ Authentication tests verify security
8. ✅ Authorization tests verify permissions
9. ✅ Validation tests verify input checking
10. ✅ Performance tests verify SLA compliance
11. ✅ Security tests verify no vulnerabilities
12. ✅ Coverage reports show >80% coverage
13. ✅ All tests pass consistently
14. ✅ Tests run in CI/CD pipeline
15. ✅ Test documentation is complete

## Success Metrics

Measure testing quality by:

- **Code Coverage**: >80% lines, branches, functions
- **Test Count**: Comprehensive test suite (unit + integration + E2E)
- **Test Speed**: Unit tests < 1s, integration tests < 10s
- **Pass Rate**: 100% of tests passing
- **Bug Detection**: Catching bugs before production
- **Flakiness**: <1% flaky test rate
- **Performance**: p95 response time < 200ms
- **Security**: Zero critical vulnerabilities

Success is achieved when the test suite provides confidence that the API works correctly, handles errors gracefully, performs well, and is secure against common vulnerabilities.
