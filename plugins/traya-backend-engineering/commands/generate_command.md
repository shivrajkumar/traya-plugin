# Create a Custom Backend Command

## Model Recommendation

**⚠️ MODEL SWITCH RECOMMENDED**: Switch to **Claude Haiku** for this command generation phase.

For optimal results with this command:
1. Switch to Haiku model for fast command creation and implementation
2. Focus on practical, executable command structure
3. Use templates and patterns for consistency

This leverages our multi-model workflow: Haiku for implementation and creation (70% cost, 30% quality).

---

Create a new slash command in `.claude/commands/` for backend development tasks.

## Goal

#$ARGUMENTS

## Key Capabilities for Backend Development

**File Operations:**
- Read, Edit, Write - modify TypeScript/JavaScript files, configs, migrations
- Glob, Grep - search codebase for controllers, services, entities
- MultiEdit - atomic multi-part changes across backend files

**Backend Development:**
- Bash - run backend commands (npm, database migrations, tests, linters)
- Task - launch specialized backend agents (api-designer, database-modeler, nestjs-specialist, etc.)
- TodoWrite - track progress with todo lists

**Database Operations:**
- TypeORM migrations - create, run, revert
- Database schema analysis
- Query optimization
- Seed data management

**API Development:**
- NestJS/Express scaffolding
- Controller and service generation
- DTO and entity creation
- OpenAPI/Swagger documentation
- Postman collection management

**Testing & Quality:**
- Jest unit tests
- Supertest integration tests
- E2E testing
- TypeScript compilation
- ESLint/Prettier

**Web & APIs:**
- WebFetch, WebSearch - research NestJS, TypeORM, PostgreSQL, MongoDB docs
- GitHub (gh cli) - PRs, issues, reviews
- Postman MCP - API testing and validation
- Context7 MCP - framework and library documentation

**Backend-Specific Integrations:**
- Postman - API testing, collection management
- Context7 - NestJS, Express, TypeORM documentation
- Serena - codebase pattern analysis

## Backend Development Best Practices

1. **API-First Design** - design API contracts before implementation
2. **Database Safety** - always create reversible migrations
3. **Type Safety** - use TypeScript strict mode, comprehensive DTOs
4. **Input Validation** - validate all inputs with class-validator
5. **Error Handling** - consistent error responses (RFC 7807)
6. **Testing** - unit tests (services) + integration tests (APIs)
7. **Documentation** - OpenAPI specs, Postman collections, inline comments
8. **Security** - OWASP Top 10 compliance, authentication/authorization
9. **Performance** - caching (Redis), query optimization, benchmarking
10. **Code Quality** - ESLint, Prettier, code reviews

## Backend Command Structure

```markdown
# [Command Name]

[Brief description of what this backend command does]

## Prerequisites

- Node.js and npm/yarn installed
- Database connection configured (PostgreSQL/MongoDB)
- TypeScript compiler available
- [Any other backend-specific requirements]

## Steps

1. **[First step - usually analysis or planning]**
   - Analyze existing API structure
   - Review database schema
   - Check for similar implementations
   - Consider security and performance implications

2. **[Implementation step]**
   - Generate controllers/services/entities
   - Create database migrations
   - Implement business logic
   - Add input validation

3. **[Testing step]**
   - Write unit tests for services
   - Create integration tests for APIs
   - Test database migrations (up/down)
   - Validate with Postman

4. **[Documentation step]**
   - Update OpenAPI specification
   - Create/update Postman collection
   - Add inline code documentation
   - Update CHANGELOG

5. **[Validation step]**
   - Run TypeScript compilation
   - Run ESLint
   - Execute test suite
   - Verify API contracts

## Success Criteria

- [ ] TypeScript compilation successful
- [ ] All tests pass (unit + integration)
- [ ] ESLint passes with no warnings
- [ ] API documentation updated (OpenAPI spec)
- [ ] Postman collection includes new endpoints
- [ ] Database migrations tested (up and down)
- [ ] Performance benchmarks meet targets
- [ ] Security review passed (OWASP compliance)
- [ ] Code reviewed by senior backend developer
```

## Backend-Specific Command Patterns

### Pattern 1: API Endpoint Creation

```markdown
Create a new API endpoint for #$ARGUMENTS following these steps:

1. **API Design**
   - Task api-designer("Design REST endpoint for #$ARGUMENTS")
   - Define request/response DTOs
   - Plan authentication/authorization requirements
   - Consider rate limiting and caching

2. **Database Schema** (if needed)
   - Task database-modeler("Design schema for #$ARGUMENTS")
   - Create TypeORM entity
   - Generate migration script
   - Add indexes for performance

3. **Implementation**
   - Task nestjs-specialist("Implement #$ARGUMENTS endpoint")
   - Create controller with decorators
   - Implement service layer logic
   - Add DTO validation with class-validator
   - Implement error handling

4. **Testing**
   - Task testing-specialist("Test #$ARGUMENTS endpoint")
   - Write service unit tests
   - Create API integration tests with Supertest
   - Test authentication/authorization
   - Test error scenarios

5. **Documentation**
   - Task api-documenter("Document #$ARGUMENTS endpoint")
   - Add OpenAPI decorators
   - Create Postman collection example
   - Document authentication requirements

6. **Validation**
   - Run tests: `npm test`
   - Test with Postman: validate request/response schemas
   - Check TypeScript: `tsc --noEmit`
   - Lint code: `npm run lint`
   - Benchmark performance: response time < 200ms (p95)

7. **Commit** (optional)
   - Stage changes
   - Write descriptive commit message following conventions
   - Include breaking changes if applicable
```

### Pattern 2: Database Migration

```markdown
Create database migration for #$ARGUMENTS following these steps:

1. **Schema Design**
   - Task database-modeler("Design schema changes for #$ARGUMENTS")
   - Create ERD if complex changes
   - Plan for zero-downtime deployment
   - Consider data migration strategy

2. **Create Migration**
   - Task typeorm-specialist("Create migration for #$ARGUMENTS")
   - Generate migration: `npm run migration:generate -- -n MigrationName`
   - Implement up() method
   - Implement down() method (rollback)
   - Add data migration if needed

3. **Update Entities**
   - Update TypeORM entities
   - Add/modify decorators
   - Update relationships
   - Regenerate DTOs if needed

4. **Testing**
   - Test on fresh database: `npm run migration:run`
   - Test rollback: `npm run migration:revert`
   - Test with seed data
   - Verify data integrity
   - Check index performance

5. **Validation**
   - Verify migration runs successfully
   - Check database schema matches expectations
   - Test affected API endpoints
   - Benchmark query performance
   - Document migration in CHANGELOG

6. **Commit**
   - Commit migration file
   - Commit entity changes
   - Document breaking changes
   - Update deployment notes
```

### Pattern 3: Security Audit & Fix

```markdown
Perform security audit for #$ARGUMENTS following these steps:

1. **Security Scan**
   - Task security-auditor("Audit security for #$ARGUMENTS")
   - Check OWASP Top 10 compliance
   - Scan dependencies: `npm audit`
   - Review authentication/authorization
   - Check input validation
   - Review SQL injection risks

2. **Identify Vulnerabilities**
   - Categorize by severity (Critical/High/Medium/Low)
   - Document attack vectors
   - Assess impact on API consumers
   - Prioritize fixes

3. **Implement Fixes**
   - Fix critical vulnerabilities first
   - Add input sanitization
   - Implement parameterized queries
   - Add authentication guards
   - Update dependencies: `npm audit fix`

4. **Security Testing**
   - Test injection attacks (SQL, NoSQL, XSS)
   - Test authentication bypass attempts
   - Test authorization edge cases
   - Fuzz test API endpoints
   - Validate JWT token handling

5. **Documentation**
   - Document security fixes
   - Update security best practices
   - Add to security checklist
   - Create incident report if needed

6. **Validation**
   - Re-run security audit
   - Verify all tests pass
   - Check for similar vulnerabilities in codebase
   - Review by security team
```

### Pattern 4: Performance Optimization

```markdown
Optimize performance for #$ARGUMENTS following these steps:

1. **Baseline Measurement**
   - Task performance-analyzer("Analyze performance of #$ARGUMENTS")
   - Measure API response times
   - Profile database queries
   - Check memory usage
   - Identify bottlenecks

2. **Database Optimization**
   - Task database-modeler("Optimize queries for #$ARGUMENTS")
   - Add indexes to slow queries
   - Optimize N+1 queries
   - Use eager/lazy loading appropriately
   - Implement query result caching

3. **Caching Strategy**
   - Task redis-cache-specialist("Implement caching for #$ARGUMENTS")
   - Add Redis caching layer
   - Implement cache invalidation
   - Set appropriate TTLs
   - Cache expensive computations

4. **Code Optimization**
   - Optimize algorithm complexity
   - Use batch operations
   - Implement pagination
   - Add response streaming for large payloads
   - Optimize TypeScript compilation

5. **Performance Testing**
   - Benchmark before/after
   - Load test with realistic data
   - Test under concurrent requests
   - Monitor memory/CPU usage
   - Verify no regressions

6. **Documentation**
   - Document performance improvements
   - Update performance targets
   - Add monitoring/alerting
   - Create optimization playbook
```

## Tips for Effective Backend Commands

- **Use $ARGUMENTS** placeholder for dynamic inputs (API endpoint name, entity name, etc.)
- **Reference CLAUDE.md** for project patterns and backend conventions
- **Include verification steps** - tests, linting, TypeScript compilation, API validation
- **Be explicit about database changes** - migrations, schema impacts, rollback procedures
- **Consider security** - authentication, authorization, input validation, OWASP compliance
- **Plan for scale** - caching, query optimization, load testing
- **Use XML tags** for structured prompts: `<api_design>`, `<database_schema>`, `<security>`, `<performance>`

## Backend-Specific Verification Commands

```markdown
## Verification Steps

1. **TypeScript Compilation:**
   ```bash
   npm run build
   # or
   tsc --noEmit
   ```

2. **Linting:**
   ```bash
   npm run lint
   # or
   eslint . --ext .ts
   # or
   yarn lint
   ```

3. **Unit Tests:**
   ```bash
   npm test
   # or
   jest --coverage
   # or
   yarn test
   ```

4. **Integration Tests:**
   ```bash
   npm run test:integration
   # or
   jest --config jest.integration.config.js
   ```

5. **E2E Tests:**
   ```bash
   npm run test:e2e
   ```

6. **Database Migrations:**
   ```bash
   # Run migrations
   npm run migration:run

   # Revert last migration
   npm run migration:revert
   ```

7. **API Testing:**
   ```bash
   # Using Postman (if available)
   # Validate all endpoints
   # Check response schemas
   # Test authentication
   ```

8. **Performance Benchmarking:**
   ```bash
   # Custom benchmark script
   npm run benchmark

   # Or use tools like autocannon, ab
   autocannon -c 100 -d 30 http://localhost:3000/api/endpoint
   ```

9. **Security Audit:**
   ```bash
   npm audit
   npm audit fix
   ```

10. **Code Quality:**
    ```bash
    # Format code
    npm run format
    # or
    prettier --write .
    ```
```

## Example Backend Commands

### Generate CRUD API

```markdown
# Generate Complete CRUD API

Generate a complete CRUD API for #$ARGUMENTS

1. Use api-designer to plan RESTful endpoints
2. Use database-modeler to design entity schema
3. Use typeorm-specialist to create entity and repository
4. Use nestjs-specialist to create controller, service, DTOs
5. Use testing-specialist to create comprehensive tests
6. Use api-documenter to generate OpenAPI spec
7. Run all verification steps

Success criteria:
- All 5 REST endpoints implemented (GET, GET/:id, POST, PUT/:id, DELETE/:id)
- Full test coverage (>80%)
- OpenAPI spec complete
- Postman collection created
```

### Add Authentication

```markdown
# Add JWT Authentication

Add JWT authentication to the application

1. Use security-auditor to review current auth state
2. Use nestjs-specialist to implement JWT strategy
3. Implement authentication guards and decorators
4. Add refresh token mechanism
5. Create login/logout endpoints
6. Add comprehensive security tests
7. Update API documentation with auth requirements

Success criteria:
- JWT tokens properly signed and validated
- Refresh token rotation implemented
- All protected endpoints require authentication
- Security tests cover common attack vectors
```

Now create the command file at `.claude/commands/[name].md` with the structure above, adapted for your specific backend development need.
