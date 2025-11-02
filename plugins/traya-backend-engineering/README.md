# Traya Backend Engineering Plugin

AI-powered backend development workflow with compounding engineering principles. This plugin provides specialized agents, skills, and commands for building scalable Node.js/NestJS APIs with PostgreSQL, MongoDB, Redis, and TypeORM.

## Overview

The Traya Backend Engineering plugin brings comprehensive backend development capabilities to Claude Code. It includes 12 specialized AI agents, 5 workflow skills, and 6 commands that leverage 3 bundled MCP servers to provide end-to-end support for API development, database design, testing, and deployment.

**Philosophy: Compounding Engineering**
Each unit of engineering work should make subsequent units of work easier—not harder.

## Components

### 12 Specialized Agents

**Core Development (4 agents):**
- `api-designer` - REST and GraphQL API design with OpenAPI specifications
- `nestjs-specialist` - NestJS framework expertise (modules, DI, guards, interceptors)
- `express-specialist` - Express.js development with middleware patterns
- `typescript-reviewer` - TypeScript code review with backend-specific type safety

**Database & ORM (3 agents):**
- `database-modeler` - PostgreSQL and MongoDB schema design and optimization
- `typeorm-specialist` - TypeORM entities, repositories, migrations, and queries
- `redis-cache-specialist` - Redis caching strategies and session management

**API Documentation (1 agent):**
- `api-documenter` - OpenAPI 3.0/3.1, Swagger, AsyncAPI, GraphQL schemas, Postman collections

**Quality & Testing (3 agents):**
- `testing-specialist` - Jest, Supertest, integration and E2E testing
- `performance-analyzer` - Query optimization, profiling, and load testing
- `security-auditor` - Authentication, authorization, and OWASP best practices

**Architecture & Strategy (1 agent):**
- `architecture-strategist` - Backend architecture and design decisions

### 5 Workflow Skills

1. **api-developer** - Complete API development workflow
   - API design and architecture
   - Implementation with NestJS or Express
   - Request/response validation
   - Authentication and authorization
   - Testing and documentation
   - Production deployment

2. **api-documentation-generator** - Automated API documentation
   - OpenAPI 3.0/3.1 specification generation
   - Swagger UI integration
   - AsyncAPI for event-driven APIs
   - GraphQL schema documentation
   - Postman collection generation with test scripts
   - CI/CD integration

3. **database-integrator** - Database integration workflow
   - Schema design and normalization
   - TypeORM entity creation
   - Migration management
   - Repository pattern implementation
   - Query optimization and indexing
   - Transaction handling

4. **api-tester** - Comprehensive API testing
   - Unit tests for services and repositories
   - Integration tests for controllers
   - End-to-end API tests
   - Postman collection validation
   - Performance and load testing
   - Security testing

5. **code-reviewer** - Dual-layer code review
   - Task completion verification
   - Technical quality assessment
   - Backend best practices validation
   - Security audit (OWASP Top 10)
   - Performance review
   - Documentation completeness

### 6 Commands

- `/traya-backend-engineering:plan` - Create structured GitHub issues for backend features
- `/traya-backend-engineering:work` - Execute work plans with automatic skill invocation
- `/traya-backend-engineering:review` - Comprehensive code review
- `/traya-backend-engineering:triage` - Issue triage and prioritization
- `/traya-backend-engineering:resolve_todo_parallel` - Parallel TODO resolution
- `/traya-backend-engineering:generate_command` - Create custom commands

## Bundled MCP Servers

The plugin automatically configures 3 MCP servers:

1. **Postman MCP** - API testing, collection management, and validation
2. **Context7 MCP** - Access to Node.js, Express, NestJS, TypeORM documentation
3. **Serena MCP** - Codebase pattern analysis and semantic code search

## Technology Stack

This plugin is optimized for:

**Frameworks:**
- Node.js with TypeScript
- NestJS (modules, DI, decorators)
- Express.js (middleware, routing)

**Databases:**
- PostgreSQL (relational data)
- MongoDB (document store)
- Redis (caching, sessions)

**ORM:**
- TypeORM (entities, migrations, repositories)

**Testing:**
- Jest (unit tests)
- Supertest (API integration tests)

**Documentation:**
- OpenAPI 3.0/3.1 (Swagger)
- AsyncAPI (event-driven APIs)
- GraphQL SDL (GraphQL schemas)

## Installation

### 1. Install the Plugin

From Claude Code:
```bash
claude /plugin marketplace add https://github.com/trayahealth/traya-plugin
claude /plugin install traya-backend-engineering
```

### 2. Setup Requirements

**Postman MCP (for API testing):**
- Automatically configured via npx
- No additional setup required
- Optional: Import existing Postman collections

**Context7 MCP (for documentation):**
- Automatically configured via npx
- No additional setup required
- Provides access to Node.js, Express, NestJS, TypeORM docs

**Serena MCP (for pattern analysis):**
- Automatically configured via uvx
- Optionally index your project for better results:
  ```bash
  uvx --from git+https://github.com/oraios/serena serena project index
  ```

## Usage

### Quick Start Workflow

1. **Plan** your backend feature:
   ```bash
   claude /traya-backend-engineering:plan "Add user authentication with JWT and refresh tokens"
   ```

2. **Execute** the plan:
   ```bash
   claude /traya-backend-engineering:work path/to/plan.md
   ```

   The `/work` command automatically:
   - Detects task type (API development, database integration, documentation)
   - Invokes appropriate skills (api-developer → api-documentation-generator → api-tester → code-reviewer)
   - Tests endpoints with Postman
   - Validates OpenAPI specifications
   - Provides iterative refinement until complete

3. **Review** the implementation:
   ```bash
   claude /traya-backend-engineering:review
   ```

### Using Individual Agents

Invoke agents for specific tasks:

```bash
# API design consultation
claude agent api-designer "Design REST API for e-commerce orders"

# NestJS implementation help
claude agent nestjs-specialist "Implement custom guard for role-based access"

# Database schema design
claude agent database-modeler "Design schema for multi-tenant SaaS application"

# TypeORM optimization
claude agent typeorm-specialist "Optimize N+1 query problem in user relations"

# API documentation generation
claude agent api-documenter "Generate OpenAPI spec from existing controllers"

# Security audit
claude agent security-auditor "Review authentication implementation for vulnerabilities"

# Performance analysis
claude agent performance-analyzer "Identify slow database queries and optimize"
```

### Using Skills Directly

Invoke skills for complete workflows:

```bash
# API development workflow
claude /skill api-developer

# Generate comprehensive API documentation
claude /skill api-documentation-generator

# Database integration workflow
claude /skill database-integrator

# Complete API testing suite
claude /skill api-tester

# Code review
claude /skill code-reviewer
```

## Workflow Examples

### Example 1: Building a REST API

```bash
# 1. Plan the feature
claude /traya-backend-engineering:plan "Create REST API for blog posts with CRUD operations"

# 2. Execute development (automatically invokes api-developer skill)
claude /traya-backend-engineering:work blog-api-plan.md

# This automatically:
# - Designs API endpoints with api-designer
# - Implements with nestjs-specialist
# - Creates database schema with database-modeler
# - Implements TypeORM entities with typeorm-specialist
# - Generates OpenAPI docs with api-documenter
# - Tests with api-tester
# - Reviews with code-reviewer

# 3. Review the PR
claude /traya-backend-engineering:review 123
```

### Example 2: Database Migration

```bash
# 1. Plan migration
claude /traya-backend-engineering:plan "Add full-text search to articles table"

# 2. Execute (automatically invokes database-integrator skill)
claude /traya-backend-engineering:work search-migration-plan.md

# This automatically:
# - Designs schema changes with database-modeler
# - Creates TypeORM migration with typeorm-specialist
# - Updates entities and repositories
# - Tests migration up/down
# - Verifies query performance

# 3. Review changes
claude /traya-backend-engineering:review
```

### Example 3: API Documentation

```bash
# Generate comprehensive API documentation
claude /skill api-documentation-generator

# This automatically:
# - Analyzes existing controllers and routes
# - Generates OpenAPI 3.1 specification
# - Sets up Swagger UI
# - Creates Postman collection with tests
# - Documents GraphQL schemas (if applicable)
# - Validates all documentation
# - Integrates with CI/CD
```

### Example 4: Security Audit

```bash
# Comprehensive security review
claude agent security-auditor "Audit authentication and authorization implementation"

# This covers:
# - JWT token validation
# - Password hashing (bcrypt)
# - SQL injection prevention
# - XSS protection
# - CSRF protection
# - Rate limiting
# - Input validation
# - OWASP Top 10 compliance
```

## Automatic Skill Invocation

The `/work` command intelligently detects task types and invokes appropriate skills:

**API Development Tasks:**
```
api-developer → api-documentation-generator → api-tester → code-reviewer
```

**Database Integration Tasks:**
```
database-integrator → api-tester → code-reviewer
```

**Documentation Tasks:**
```
api-documentation-generator → api-tester → code-reviewer
```

**Testing Tasks:**
```
api-tester → code-reviewer
```

## Best Practices

### API Design
- Follow RESTful principles
- Use proper HTTP methods and status codes
- Implement versioning from the start
- Document with OpenAPI specifications
- Design for pagination, filtering, and sorting

### Database Design
- Normalize schema appropriately
- Create indexes for frequently queried fields
- Use migrations for schema changes
- Implement proper relationships
- Optimize queries to avoid N+1 problems

### Security
- Validate all input data
- Use parameterized queries
- Implement JWT authentication
- Add rate limiting
- Follow OWASP Top 10 guidelines
- Hash passwords with bcrypt
- Sanitize error messages

### Testing
- Aim for >80% test coverage
- Write unit tests for services
- Write integration tests for controllers
- Test error scenarios
- Validate API contracts with Postman
- Test database migrations (up and down)

### Documentation
- Generate OpenAPI specs from code
- Keep documentation in sync with code
- Include request/response examples
- Document error responses
- Provide Postman collections for testing

## Integration with MCP Servers

### Postman MCP
```bash
# Test API endpoints
mcp__postman__postman

# Import/export collections
# Validate API contracts
# Generate test scripts
```

### Context7 MCP
```bash
# Access Node.js documentation
mcp__context7__get-library-docs

# Get Express.js best practices
# Learn NestJS patterns
# TypeORM query examples
```

### Serena MCP
```bash
# Find similar patterns in codebase
mcp__serena__search_for_pattern

# Locate specific symbols
mcp__serena__find_symbol

# Understand code structure
mcp__serena__get_symbols_overview
```

## Quality Gates

All work must pass these quality gates:

1. **TypeScript Compilation** - Zero errors with strict mode
2. **Linting** - ESLint with no warnings
3. **Testing** - >80% coverage (unit + integration)
4. **API Validation** - OpenAPI spec validation
5. **Security** - OWASP Top 10 compliance
6. **Performance** - <200ms p95 response time
7. **Documentation** - Complete API documentation

## Contributing

This plugin follows the compounding engineering philosophy. When adding new agents, commands, or skills:

1. Update `plugin.json` with component counts
2. Update this README with descriptions
3. Follow existing patterns and conventions
4. Test thoroughly before committing
5. Document integration points

## Support

For issues or questions:
- GitHub Issues: https://github.com/trayahealth/traya-plugin/issues
- Documentation: https://github.com/trayahealth/traya-plugin

## License

See repository root for license information.
