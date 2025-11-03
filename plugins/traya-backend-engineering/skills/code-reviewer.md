---
name: code-reviewer
description: Dual-layer code review workflow for backend applications. Use this skill after all development and testing are complete to perform comprehensive code review including task completion verification, technical quality assessment, Node.js/NestJS/Express best practices validation, API design review, database optimization review, security audit, and documentation verification using Serena MCP for codebase analysis.
---

# Code Reviewer

## Overview

This skill provides comprehensive dual-layer code review for backend applications. The review process verifies task completion against requirements, evaluates technical quality, ensures backend best practices, validates TypeScript usage, checks API design, reviews database queries, audits security, and verifies documentation completeness.

## Core Workflow

### Layer 1: Task Completion Verification

**1. Review Requirements**

Verify all requirements met:
- Original task/issue requirements
- Acceptance criteria fulfilled
- API contract requirements
- Database schema requirements
- Performance targets met
- Security requirements satisfied
- Documentation requirements complete

**2. Functional Verification**

Confirm functionality:
- All API endpoints work as described
- Database operations complete correctly
- Business logic implements requirements
- Error handling covers edge cases
- Validation rules are enforced
- Authentication works correctly
- Authorization rules are applied
- Rate limiting functions properly

**3. API Contract Validation**

Verify API compliance:
- Request/response schemas match specification
- HTTP status codes are correct
- Error responses are consistent
- Pagination works properly
- Filtering and sorting work
- OpenAPI/Swagger documentation accurate
- Breaking changes identified

### Layer 2: Technical Quality Assessment

**4. Code Structure Review**

Use Serena MCP to analyze:
```
mcp__serena__find_symbol - Find controllers/services/repositories
mcp__serena__find_referencing_symbols - Check dependencies
mcp__serena__search_for_pattern - Find anti-patterns
mcp__serena__get_code_graph - Understand architecture
```

Evaluate:
- Proper layering (controllers, services, repositories)
- Separation of concerns
- Single Responsibility Principle
- Dependency injection usage
- File organization
- Code duplication
- Module structure

**5. TypeScript Review**

Check type safety:
- No `any` types (except where necessary)
- Complete DTO interfaces
- Explicit return types for functions
- Type guards used appropriately
- Generic types properly constrained
- Entity types correctly defined
- Validation decorators applied
- Proper use of `unknown` vs `any`

**6. Backend Best Practices**

Verify adherence:

**NestJS Specific:**
- Controllers use proper decorators
- Services use dependency injection
- DTOs use class-validator decorators
- Guards implemented for authentication
- Interceptors for cross-cutting concerns
- Pipes for validation and transformation
- Exception filters for error handling
- Modules properly organized

**Express Specific:**
- Routes properly defined
- Middleware correctly ordered
- Error handling middleware at end
- Request/response typing
- Async error handling
- Route parameter validation

**Universal:**
- RESTful API design principles
- Proper HTTP method usage
- Consistent naming conventions
- Environment variable usage
- Configuration management
- Logging strategy

**7. Database Review**

Check database operations:
- Entities properly defined with decorators
- Relationships correctly mapped
- Indexes on foreign keys and frequent queries
- Migrations generated and tested
- No N+1 query problems
- Query optimization applied
- Transactions used where needed
- Connection pooling configured
- Soft deletes vs hard deletes
- Cascading operations understood

**8. API Design Review**

Evaluate API quality:
- RESTful resource naming
- Proper HTTP verbs (GET, POST, PUT, DELETE)
- Consistent URL structure
- API versioning strategy
- Pagination for list endpoints
- Filtering and sorting options
- Proper status codes (200, 201, 400, 404, 500)
- HATEOAS compliance (if applicable)
- Rate limiting implemented
- CORS configured correctly

**9. Error Handling Review**

Check error management:
- Custom error classes defined
- Global exception filters configured
- Proper error status codes
- Consistent error response format
- Error logging implemented
- Stack traces not exposed in production
- Validation errors user-friendly
- Database errors handled gracefully
- Network errors recovered from
- Timeout handling

**10. Authentication & Authorization Review**

Verify security implementation:
- JWT tokens properly signed
- Token expiration configured
- Refresh token strategy
- Password hashing (bcrypt/argon2)
- Role-based access control (RBAC)
- Guards/middleware on protected routes
- User session management
- Secure cookie settings
- CSRF protection where needed
- OAuth integration (if applicable)

### Layer 3: Performance Review

**11. Query Performance**

Analyze database queries:
- Use of indexes verified
- Query complexity analyzed
- N+1 queries prevented
- Batch loading implemented
- Query pagination applied
- Database indexes created
- Slow query logging enabled
- Connection pool optimized
- Read replicas considered (if needed)

**12. Caching Strategy**

Evaluate caching:
- Redis/cache layer implemented
- Cache invalidation strategy
- Cache key naming convention
- TTL values appropriate
- Cache hit/miss logging
- Cache warming strategy
- Distributed caching (if needed)

**13. API Response Times**

Check performance targets:
- Response times < 200ms for simple queries
- Response times < 500ms for complex queries
- Pagination reduces load
- Compression enabled (gzip)
- Static assets optimized
- Database queries optimized
- Unnecessary data not returned
- Lazy loading applied

### Layer 4: Security Audit

**14. Input Validation**

Verify input security:
- All inputs validated with DTOs
- SQL injection prevention (parameterized queries)
- XSS prevention (input sanitization)
- NoSQL injection prevention
- Path traversal prevention
- Command injection prevention
- File upload validation
- Size limits enforced

**15. Authentication Security**

Check auth security:
- Passwords hashed, never stored plain
- JWT secrets in environment variables
- Token expiration enforced
- Secure session management
- Account lockout after failed attempts
- Password complexity requirements
- Rate limiting on auth endpoints
- Brute force protection

**16. Data Security**

Verify data protection:
- Sensitive data encrypted at rest
- Sensitive data encrypted in transit (HTTPS)
- PII handled according to regulations
- Secrets not in version control
- Environment variables used for config
- Database connection strings secured
- API keys rotated regularly
- Audit logging for sensitive operations

**17. Authorization Security**

Check authorization:
- User permissions verified before actions
- Role-based access control enforced
- Resource ownership validated
- Admin routes properly protected
- Cross-user data access prevented
- API key validation (if applicable)

### Layer 5: Code Quality Metrics

**18. Code Complexity**

Analyze complexity:
- Functions < 50 lines
- Classes < 300 lines
- Cyclomatic complexity reasonable
- Nesting depth < 4 levels
- No overly complex logic
- Readable code structure

**19. Test Coverage**

Verify testing:
- Unit tests for services (>80% coverage)
- Integration tests for controllers
- E2E tests for critical flows
- Repository tests complete
- Error scenarios tested
- Edge cases covered
- Mocks properly used
- Test names descriptive

**20. Documentation**

Check documentation:
- README updated with setup instructions
- API documentation complete (OpenAPI/Swagger)
- Code comments for complex logic
- DTOs documented
- Environment variables documented
- Migration instructions provided
- Deployment guide updated
- Architecture diagrams (if needed)

## Review Checklist

### Task Completion
- [ ] All requirements implemented
- [ ] Acceptance criteria met
- [ ] API endpoints work as specified
- [ ] Database operations correct
- [ ] Error scenarios handled
- [ ] Performance targets met

### Code Structure
- [ ] Proper layering (controller/service/repository)
- [ ] Separation of concerns clear
- [ ] No code duplication
- [ ] Dependency injection used
- [ ] Module structure logical
- [ ] File naming consistent

### TypeScript
- [ ] No unnecessary `any` types
- [ ] DTO interfaces complete
- [ ] Return types explicit
- [ ] Validation decorators applied
- [ ] Entity types correct
- [ ] No type errors

### Backend Best Practices
- [ ] RESTful API design
- [ ] Proper HTTP methods
- [ ] Consistent error responses
- [ ] Environment-based config
- [ ] Logging implemented
- [ ] Middleware properly ordered

### Database
- [ ] Entities properly defined
- [ ] Relationships correctly mapped
- [ ] Indexes on foreign keys
- [ ] Migrations created
- [ ] No N+1 queries
- [ ] Transactions used where needed

### API Design
- [ ] RESTful naming conventions
- [ ] Proper status codes
- [ ] Pagination implemented
- [ ] Filtering/sorting available
- [ ] API versioning strategy
- [ ] Rate limiting configured

### Error Handling
- [ ] Custom error classes
- [ ] Global exception filter
- [ ] Consistent error format
- [ ] Proper status codes
- [ ] Stack traces hidden in prod
- [ ] Error logging complete

### Authentication & Authorization
- [ ] JWT properly implemented
- [ ] Password hashing secure
- [ ] Token expiration set
- [ ] RBAC enforced
- [ ] Protected routes guarded
- [ ] Session management secure

### Performance
- [ ] Response times acceptable
- [ ] Database queries optimized
- [ ] Indexes created
- [ ] Caching implemented
- [ ] No N+1 queries
- [ ] Connection pooling configured

### Security
- [ ] Input validation comprehensive
- [ ] SQL injection prevented
- [ ] XSS prevention applied
- [ ] Passwords hashed
- [ ] Secrets in environment
- [ ] HTTPS enforced
- [ ] Rate limiting active

### Testing
- [ ] Unit tests present (>80%)
- [ ] Integration tests complete
- [ ] E2E tests for flows
- [ ] Edge cases tested
- [ ] Error scenarios tested
- [ ] All tests passing

### Documentation
- [ ] README updated
- [ ] API docs complete
- [ ] Environment vars documented
- [ ] Setup instructions clear
- [ ] Deployment guide provided

## Common Issues to Flag

### Critical Issues (Block Merge)
- Security vulnerabilities (SQL injection, XSS, etc.)
- Hardcoded secrets or credentials
- No authentication on sensitive endpoints
- SQL queries without parameterization
- Passwords stored in plain text
- Missing authorization checks
- Critical performance issues (>5s response)
- Database migrations missing
- Type safety violations (`any` everywhere)

### Major Issues (Fix Before Merge)
- Missing error handling
- No input validation
- Incomplete DTOs
- Missing database indexes
- N+1 query problems
- No unit tests for services
- Missing API documentation
- Inconsistent error responses
- Poor TypeScript usage
- Memory leaks

### Minor Issues (Can Address Later)
- Missing JSDoc comments
- Inconsistent naming
- Code complexity
- Minor style violations
- Opportunities for refactoring
- Additional test coverage
- Performance optimizations
- Better error messages

## Review Process

1. **Analyze Codebase with Serena**
   - Find all modified files
   - Review controller/service/repository structure
   - Check for anti-patterns
   - Identify code duplication
   - Map dependencies

2. **Run Automated Checks**
   - TypeScript compilation (`tsc --noEmit`)
   - Test suite (`npm test`)
   - Linter (`npm run lint`)
   - Code coverage report
   - Database migration check

3. **Manual Code Review**
   - Read through all changes
   - Verify best practices
   - Check for edge cases
   - Assess code quality
   - Review error handling

4. **API Testing**
   - Test all endpoints manually or with Postman
   - Verify request/response schemas
   - Test error scenarios
   - Check authentication/authorization
   - Verify rate limiting

5. **Database Review**
   - Review migrations
   - Check entity definitions
   - Verify indexes
   - Test queries
   - Check for N+1 queries

6. **Security Audit**
   - Check for hardcoded secrets
   - Verify input validation
   - Review authentication
   - Check authorization
   - Test for common vulnerabilities

7. **Performance Check**
   - Test API response times
   - Review database query plans
   - Check for performance bottlenecks
   - Verify caching strategy
   - Test under load (if possible)

8. **Documentation Check**
   - Verify API documentation
   - Check README completeness
   - Review code comments
   - Ensure setup instructions work
   - Verify environment variables documented

9. **Provide Feedback**
   - List critical issues
   - Note major issues
   - Suggest improvements
   - Highlight good practices
   - Provide actionable recommendations

## Backend-Specific Review Patterns

### NestJS Controller Review

```typescript
// ✅ GOOD: Proper controller structure
@ApiTags('users')
@Controller('api/v1/users')
@UseGuards(JwtAuthGuard)
export class UsersController {
  constructor(private readonly usersService: UsersService) {}

  @Post()
  @Roles('admin')
  @UseGuards(RolesGuard)
  @ApiOperation({ summary: 'Create user' })
  @ApiResponse({ status: 201, type: UserResponseDto })
  async create(@Body() createUserDto: CreateUserDto): Promise<UserResponseDto> {
    return this.usersService.create(createUserDto);
  }
}

// ❌ BAD: Missing decorators, no type safety, no guards
export class UsersController {
  @Post('users')
  async create(req: any, res: any) {
    const user = await this.db.query('INSERT INTO users...');
    res.json(user);
  }
}
```

### Service Layer Review

```typescript
// ✅ GOOD: Proper service with error handling
@Injectable()
export class UsersService {
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

    return this.userRepository.save(user);
  }
}

// ❌ BAD: No error handling, no validation
@Injectable()
export class UsersService {
  async create(data: any) {
    return this.db.query('INSERT INTO users VALUES (?, ?)', [data.email, data.password]);
  }
}
```

### Database Entity Review

```typescript
// ✅ GOOD: Proper entity with indexes and relationships
@Entity('users')
@Index(['email'], { unique: true })
@Index(['role'])
export class User extends BaseEntity {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column({ type: 'varchar', length: 255, unique: true })
  email: string;

  @Column({ type: 'varchar', length: 255, select: false })
  password: string;

  @Column({ type: 'enum', enum: UserRole, default: UserRole.USER })
  role: UserRole;

  @OneToMany(() => Post, (post) => post.author)
  posts: Post[];
}

// ❌ BAD: Missing indexes, no relationships, poor typing
@Entity()
export class User {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  email: any;

  @Column()
  password: any;
}
```

### Error Handling Review

```typescript
// ✅ GOOD: Proper error handling with custom exceptions
async findById(id: string): Promise<User> {
  const user = await this.userRepository.findOne({ where: { id } });

  if (!user) {
    throw new NotFoundException(`User with ID ${id} not found`);
  }

  return user;
}

// ❌ BAD: No error handling
async findById(id: string) {
  return this.userRepository.findOne({ where: { id } });
}
```

### Validation Review

```typescript
// ✅ GOOD: Comprehensive validation with decorators
export class CreateUserDto {
  @IsEmail()
  @MaxLength(255)
  email: string;

  @IsString()
  @MinLength(8)
  @MaxLength(100)
  @Matches(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)/, {
    message: 'Password must contain uppercase, lowercase, and number',
  })
  password: string;

  @IsString()
  @MinLength(2)
  @MaxLength(100)
  name: string;

  @IsEnum(UserRole)
  @IsOptional()
  role?: UserRole;
}

// ❌ BAD: No validation
export class CreateUserDto {
  email: any;
  password: any;
  name: any;
}
```

## Completion Criteria

Code review is complete when:

1. ✅ All requirements verified as met
2. ✅ Code follows backend best practices
3. ✅ TypeScript usage is correct and type-safe
4. ✅ API design follows REST principles
5. ✅ Database queries are optimized
6. ✅ No N+1 query problems
7. ✅ Security issues resolved
8. ✅ Tests are comprehensive (>80%)
9. ✅ Documentation is complete
10. ✅ No critical or major issues
11. ✅ Performance meets requirements
12. ✅ Error handling is comprehensive
13. ✅ Authentication/authorization correct
14. ✅ Migrations created and tested
15. ✅ Feedback provided to developer

Success is achieved when the code is production-ready, maintainable, performant, secure, well-tested, properly documented, and follows established backend development best practices for Node.js/NestJS/Express applications.
