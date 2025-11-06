# Review Command for Backend Development

<command_purpose> Perform exhaustive backend code reviews using multi-agent analysis, ultra-thinking, and Git worktrees for deep local inspection of APIs, databases, and services. </command_purpose>

## Introduction

<role>Senior Backend Architect with expertise in API design, database optimization, security, performance, and distributed systems</role>

## Prerequisites

<requirements>
- Git repository with GitHub CLI (`gh`) installed and authenticated
- Clean main/master branch
- Proper permissions to create worktrees and access the repository
- For document reviews: Path to a markdown file or document
- Backend-specific tools: Node.js, npm/yarn, TypeScript compiler
</requirements>

## Main Tasks

### 1. Worktree Creation and Branch Checkout (ALWAYS FIRST)

<review_target> #$ARGUMENTS </review_target>

<critical_requirement> MUST create worktree FIRST to enable local code analysis. No exceptions. </critical_requirement>

<thinking>
First, I need to determine the review target type and set up the worktree.
This enables all subsequent agents to analyze actual backend code, database schemas, API implementations, not just diffs.
</thinking>

#### Immediate Actions:

<task_list>

- [ ] Determine review type: PR number (numeric), GitHub URL, file path (.md), or empty (latest PR)
- [ ] Create worktree directory structure at `$git_root/.worktrees/reviews/pr-$identifier`
- [ ] Check out PR branch in isolated worktree using `gh pr checkout`
- [ ] Navigate to worktree - ALL subsequent analysis happens here

- Fetch PR metadata using `gh pr view --json` for title, body, files, linked issues
- Clone PR branch into worktree with full history `gh pr checkout $identifier`
- Set up backend analysis tools (TypeScript compiler, ESLint, database schema tools)
- Prepare security scanning environment (OWASP checks, dependency audit)

Ensure that the worktree is set up correctly and that the PR is checked out. ONLY then proceed to the next step.

</task_list>

#### Detect Project Type

<thinking>
Determine the backend project type by analyzing the codebase structure and files.
This will inform which framework-specific reviewers to use.
</thinking>

<project_type_detection>

Check for these indicators to determine backend project type:

**NestJS Project**:
- `nest-cli.json`
- `package.json` with `@nestjs/core`, `@nestjs/common`
- Decorators: `@Module()`, `@Controller()`, `@Injectable()`
- File patterns: `*.controller.ts`, `*.service.ts`, `*.module.ts`

**Express.js Project**:
- `package.json` with `express`
- File patterns: `app.js`, `server.js`, `routes/*.js`
- Middleware patterns

**TypeORM Database**:
- `ormconfig.json` or `ormconfig.ts`
- `package.json` with `typeorm`
- Entity files: `*.entity.ts`
- Migration files: `migrations/*.ts`

**PostgreSQL/MongoDB**:
- Database configuration files
- Schema definitions
- Migration scripts

**API Documentation**:
- `swagger.json`, `openapi.yaml`
- Postman collection files

Based on detection, set appropriate reviewers for parallel execution.

</project_type_detection>

#### Parallel Agents to Review the PR:

<parallel_tasks>

Run ALL or most of these backend-specific agents at the same time:

**Backend Framework Reviewers (choose based on project type)**:

For NestJS projects:
1. Task nestjs-specialist(PR content)

For Express projects:
2. Task express-specialist(PR content)

**Database & ORM Reviewers**:
3. Task database-modeler(PR content)
4. Task typeorm-specialist(PR content)
5. Task redis-cache-specialist(PR content)

**API & Documentation Reviewers**:
6. Task api-designer(PR content)
7. Task api-documenter(PR content)

**Quality & Testing Reviewers**:
8. Task testing-specialist(PR content)
9. Task typescript-reviewer(PR content)

**Performance & Security**:
10. Task performance-analyzer(PR content)
11. Task security-auditor(PR content)

**Universal Backend Reviewers**:
12. Task architecture-strategist(PR content)

</parallel_tasks>

### 2. Ultra-Thinking Deep Dive Phases

<ultrathink_instruction> For each phase below, spend maximum cognitive effort. Think step by step. Consider all angles. Question assumptions. Bring all reviews in a synthesis to the user.</ultrathink_instruction>

#### Phase 1: API Contract Analysis

<thinking_prompt> ULTRA-THINK: Analyze API design, contracts, versioning, and backward compatibility. What could break for API consumers? </thinking_prompt>

<api_analysis_checklist>

- [ ] **REST Principles**: Proper HTTP methods, status codes, resource naming
- [ ] **API Versioning**: URI versioning, header versioning, deprecation strategy
- [ ] **Request Validation**: DTO validation, schema constraints, type safety
- [ ] **Response Format**: Consistent structure, error handling (RFC 7807)
- [ ] **Authentication**: JWT, OAuth, API keys - proper implementation
- [ ] **Authorization**: Role-based access control, permissions, guards
- [ ] **Rate Limiting**: Throttling, abuse prevention
- [ ] **API Documentation**: OpenAPI spec, Postman collection, examples
- [ ] **Breaking Changes**: Backward compatibility, migration path
- [ ] **Idempotency**: POST/PUT/DELETE idempotency keys

</api_analysis_checklist>

<deliverable>
Complete API contract analysis with endpoint-by-endpoint review
</deliverable>

#### Phase 2: Database Architecture Review

<thinking_prompt> ULTRA-THINK: Analyze database schema design, migrations, query performance, and data integrity. What could cause data corruption or performance issues? </thinking_prompt>

<database_analysis_checklist>

- [ ] **Schema Design**: Normalization, relationships, constraints
- [ ] **Migrations**: Reversible migrations, zero-downtime deployment
- [ ] **Indexes**: Proper indexing for query performance
- [ ] **Queries**: N+1 problems, query optimization, eager/lazy loading
- [ ] **Transactions**: ACID compliance, transaction boundaries
- [ ] **Data Integrity**: Foreign keys, cascades, validation
- [ ] **Concurrency**: Race conditions, locking strategies
- [ ] **Performance**: Query execution plans, slow query analysis
- [ ] **Scalability**: Partitioning, sharding considerations
- [ ] **Backup Strategy**: Data recovery, migration rollback

</database_analysis_checklist>

<deliverable>
Complete database architecture map with schema diagrams and performance analysis
</deliverable>

#### Phase 3: Stakeholder Perspective Analysis

<thinking_prompt> ULTRA-THINK: Put yourself in each stakeholder's shoes. What matters to them? What are their pain points? </thinking_prompt>

<stakeholder_perspectives>

1. **API Consumer Perspective** <questions>

   - Are API contracts clear and well-documented?
   - Is error handling informative?
   - Are response times acceptable?
   - Is authentication straightforward?
   - Are there breaking changes? </questions>

2. **Backend Developer Perspective** <questions>

   - Is the code maintainable and testable?
   - Are design patterns consistent?
   - Is the service layer properly separated?
   - Can I debug issues easily?
   - Are TypeScript types comprehensive? </questions>

3. **Database Administrator Perspective** <questions>

   - Are migrations safe and reversible?
   - Are indexes optimized?
   - Is query performance acceptable?
   - Are there data integrity risks?
   - Is the schema normalized properly? </questions>

4. **DevOps/Operations Perspective** <questions>

   - How do I deploy this safely?
   - What metrics and logs are available?
   - How do I troubleshoot issues?
   - What are the resource requirements?
   - Is health checking implemented? </questions>

5. **Security Team Perspective** <questions>

   - What's the attack surface?
   - Is input validation comprehensive?
   - Are SQL injection risks mitigated?
   - Is authentication/authorization secure?
   - Are sensitive data encrypted?
   - OWASP Top 10 compliance? </questions>

6. **Performance Team Perspective** <questions>

   - What are the response time targets?
   - Is caching implemented properly?
   - Are database queries optimized?
   - Is there a load testing strategy?
   - What's the throughput capacity? </questions>

7. **Business Perspective** <questions>
   - Does this API enable business requirements?
   - Are there compliance risks?
   - What's the operational cost?
   - Is there an SLA commitment? </questions> </stakeholder_perspectives>

#### Phase 4: Backend Scenario Exploration

<thinking_prompt> ULTRA-THINK: Explore edge cases and failure scenarios specific to backend systems. What could go wrong? How does the system behave under stress? </thinking_prompt>

<scenario_checklist>

**API Scenarios:**
- [ ] **Happy Path**: Valid requests with correct authentication
- [ ] **Invalid Inputs**: Null, empty, malformed JSON/XML
- [ ] **Authentication Failures**: Invalid tokens, expired sessions
- [ ] **Authorization Failures**: Insufficient permissions
- [ ] **Rate Limiting**: Throttling, DDoS protection
- [ ] **Validation Errors**: DTO validation failures
- [ ] **Content Negotiation**: Accept headers, unsupported formats

**Database Scenarios:**
- [ ] **Concurrent Writes**: Race conditions, deadlocks
- [ ] **Transaction Rollbacks**: Partial failures, data consistency
- [ ] **Connection Pool Exhaustion**: High load scenarios
- [ ] **Migration Failures**: Rollback procedures
- [ ] **Data Constraints**: Foreign key violations, unique constraints
- [ ] **Query Timeouts**: Slow queries under load
- [ ] **Cascade Deletes**: Unintended data deletion

**Integration Scenarios:**
- [ ] **External API Failures**: Timeouts, 5xx errors
- [ ] **Network Issues**: Retries, circuit breakers
- [ ] **Message Queue Failures**: Dead letter queues
- [ ] **Cache Misses**: Redis unavailability, cache invalidation
- [ ] **File Storage Failures**: Upload/download errors

**Scale & Performance:**
- [ ] **10x Load**: Response time degradation
- [ ] **100x Load**: System breaking points
- [ ] **Memory Leaks**: Long-running processes
- [ ] **Connection Leaks**: Database connection handling
- [ ] **Disk Space**: Log growth, temp files

**Security Scenarios:**
- [ ] **SQL Injection**: Parameterized queries
- [ ] **NoSQL Injection**: MongoDB injection
- [ ] **XSS**: Output encoding
- [ ] **CSRF**: Token validation
- [ ] **JWT Attacks**: Algorithm confusion, token expiry
- [ ] **Sensitive Data Exposure**: Logging, error messages

</scenario_checklist>

### 3. Multi-Angle Backend Review Perspectives

#### API Design Excellence

- REST/GraphQL best practices
- OpenAPI 3.0 specification quality
- Endpoint naming and resource modeling
- HTTP method and status code correctness
- Request/response schema validation
- Error handling consistency (RFC 7807)
- API versioning strategy
- Documentation completeness

#### Database Quality

- Schema design and normalization
- Migration safety and reversibility
- Index optimization
- Query performance
- Transaction management
- Data integrity constraints
- ORM usage patterns (TypeORM best practices)
- Connection pooling configuration

#### Security Hardening

- OWASP Top 10 compliance
- Input validation and sanitization
- SQL/NoSQL injection prevention
- Authentication implementation (JWT, OAuth)
- Authorization and RBAC
- Sensitive data handling
- Dependency vulnerabilities (`npm audit`)
- Security headers (helmet.js)

#### Performance Optimization

- API response time targets (<200ms p95)
- Database query optimization
- Caching strategy (Redis)
- Connection pooling
- Load testing results
- Memory usage profiling
- Async/await patterns
- Batch operations

#### Testing Coverage

- Unit test coverage (>80%)
- Integration test completeness
- API contract testing (Supertest)
- Database transaction testing
- Error scenario coverage
- Performance benchmarks
- Load testing
- Security testing

#### Code Quality

- TypeScript strict mode compliance
- Consistent code style (ESLint, Prettier)
- Service layer separation
- Dependency injection patterns
- Error handling consistency
- Logging and monitoring
- Documentation and comments
- Code duplication analysis

### 4. Backend Simplification Review

Run the Task code-simplicity-reviewer() to identify opportunities to simplify backend code:

- Reduce complexity in service methods
- Eliminate redundant database queries
- Simplify DTO definitions
- Streamline middleware chains
- Optimize import statements
- Reduce cyclomatic complexity

### 5. Findings Synthesis and Todo Creation

<critical_requirement> All findings MUST be converted to actionable todos in the CLI todo system </critical_requirement>

#### Step 1: Synthesize All Findings

<thinking>
Consolidate all backend agent reports into a categorized list of findings.
Remove duplicates, prioritize by severity and impact on API consumers, database, security, and performance.
</thinking>

<synthesis_tasks>
- [ ] Collect findings from all parallel backend agents
- [ ] Categorize by type: api-design, database, security, performance, testing, code-quality
- [ ] Assign severity levels: 🔴 CRITICAL (P1), 🟡 IMPORTANT (P2), 🔵 NICE-TO-HAVE (P3)
- [ ] Remove duplicate or overlapping findings
- [ ] Estimate effort for each finding (Small/Medium/Large)
- [ ] Identify breaking changes for API consumers
</synthesis_tasks>

#### Step 2: Present Findings for Triage

For EACH finding, present in this format:

```
---
Finding #X: [Brief Title]

Severity: 🔴 P1 / 🟡 P2 / 🔵 P3

Category: [API-Design/Database/Security/Performance/Testing/Code-Quality]

Description:
[Detailed explanation of the issue or improvement]

Location: [file_path:line_number]

Problem:
[What's wrong or could be better]

Impact:
- API consumers: [How this affects API users]
- Database: [Schema/performance impact]
- Security: [Vulnerability or compliance issue]
- Performance: [Response time/throughput impact]

Proposed Solution:
[How to fix it with code examples]

Backend-Specific Details:
- Migration required: [Yes/No]
- Breaking change: [Yes/No]
- Database indexes: [Add/modify/remove]
- API version: [Affected versions]

Effort: Small/Medium/Large

---
Do you want to add this to the todo list?
1. yes - create todo file
2. next - skip this finding
3. custom - modify before creating
```

#### Step 3: Create Todo Files for Approved Findings

<instructions>
When user says "yes", create a properly formatted todo file:
</instructions>

<todo_creation_process>

1. **Determine next issue ID:**
   ```bash
   ls todos/ | grep -o '^[0-9]\+' | sort -n | tail -1
   ```

2. **Generate filename:**
   ```
   {next_id}-pending-{priority}-{brief-description}.md
   ```
   Example: `042-pending-p1-sql-injection-user-search.md`

3. **Create file from template:**
   ```bash
   cp todos/000-pending-p1-TEMPLATE.md todos/{new_filename}
   ```

4. **Populate with finding data:**
   ```yaml
   ---
   status: pending
   priority: p1  # or p2, p3 based on severity
   issue_id: "042"
   tags: [code-review, security, api, database, nestjs]  # add relevant backend tags
   dependencies: []
   breaking_change: false  # or true if API breaking change
   migration_required: false  # or true if database migration needed
   ---

   # [Finding Title]

   ## Problem Statement
   [Detailed description from finding]

   ## Findings
   - Discovered during backend code review by [agent names]
   - Location: [file_path:line_number]
   - Category: [API/Database/Security/Performance]
   - [Key discoveries from agents]

   ## Impact Analysis

   ### API Consumers
   - [How this affects API users]
   - Breaking change: [Yes/No]

   ### Database
   - Schema changes: [Yes/No]
   - Migration required: [Yes/No]
   - Performance impact: [Description]

   ### Security
   - Vulnerability: [Type and severity]
   - OWASP category: [If applicable]

   ### Performance
   - Response time impact: [Measurement]
   - Throughput impact: [Measurement]

   ## Proposed Solutions

   ### Option 1: [Primary solution from finding]
   - **Pros**: [Benefits]
   - **Cons**: [Drawbacks]
   - **Effort**: [Small/Medium/Large]
   - **Risk**: [Low/Medium/High]
   - **Migration**: [Required/Not required]

   ### Code Example:
   ```typescript
   // Before
   [Current code]

   // After
   [Proposed fix]
   ```

   ## Recommended Action
   [Leave blank - needs manager triage]

   ## Technical Details
   - **Affected Files**: [List from finding]
   - **API Endpoints**: [List affected endpoints]
   - **Database Tables**: [List affected tables]
   - **Entities**: [TypeORM entities affected]
   - **Services**: [Service layer components affected]
   - **Controllers**: [Controllers affected]
   - **Database Changes**: [Schema modifications needed]
   - **Migration Script**: [Required/Not required]

   ## Testing Requirements
   - [ ] Unit tests for service layer
   - [ ] Integration tests for API endpoints
   - [ ] Database migration testing (up/down)
   - [ ] Performance benchmarking
   - [ ] Security testing
   - [ ] Postman collection validation

   ## Resources
   - Code review PR: [PR link if applicable]
   - Related findings: [Other finding numbers]
   - Agent reports: [Which agents flagged this]
   - OpenAPI spec: [Link to affected spec]
   - Database schema: [Link to ERD or schema docs]

   ## Acceptance Criteria
   - [ ] [Specific criteria based on solution]
   - [ ] All tests pass (unit + integration)
   - [ ] TypeScript compilation successful
   - [ ] ESLint passes with no warnings
   - [ ] API documentation updated (OpenAPI spec)
   - [ ] Postman collection updated
   - [ ] Database migration tested (if applicable)
   - [ ] Performance benchmarks meet targets
   - [ ] Security audit passed
   - [ ] Code reviewed by 2+ developers

   ## Work Log

   ### {date} - Code Review Discovery
   **By:** Claude Backend Code Review System
   **Actions:**
   - Discovered during comprehensive backend code review
   - Analyzed by multiple specialized backend agents
   - Categorized and prioritized
   - Impact analysis completed

   **Learnings:**
   - [Key insights from agent analysis]

   ## Notes
   Source: Backend code review performed on {date}
   Review command: /traya-backend-engineering:review {arguments}
   ```

5. **Track creation:**
   Add to TodoWrite list if tracking multiple findings

</todo_creation_process>

#### Step 4: Summary Report

After processing all findings:

```markdown
## Backend Code Review Complete

**Review Target:** [PR number or branch]
**Total Findings:** [X]
**Todos Created:** [Y]

### Findings by Category:
- 🌐 API Design: [count]
- 🗄️ Database: [count]
- 🔒 Security: [count]
- ⚡ Performance: [count]
- ✅ Testing: [count]
- 📝 Code Quality: [count]

### Breaking Changes:
- [List any API breaking changes]

### Database Migrations Required:
- [List migrations needed]

### Created Todos:
- `{issue_id}-pending-p1-{description}.md` - {title}
- `{issue_id}-pending-p2-{description}.md` - {title}
...

### Skipped Findings:
- [Finding #Z]: {reason}
...

### Next Steps:
1. Triage pending todos: `ls todos/*-pending-*.md`
2. Use `/traya-backend-engineering:triage` to review and approve
3. Work on approved items: `/traya-backend-engineering:resolve_todo_parallel`
4. Run migration scripts if database changes
5. Update API documentation if API changes
6. Notify API consumers of breaking changes
```

#### Alternative: Batch Creation

If user wants to convert all findings to todos without review:

```bash
# Ask: "Create todos for all X findings? (yes/no/show-critical-only)"
# If yes: create todo files for all findings in parallel
# If show-critical-only: only present P1 findings for triage
```

## Backend-Specific Review Outputs

### API Contract Compliance Report
- OpenAPI spec validation
- Endpoint consistency check
- Authentication/authorization review
- Error handling patterns
- API versioning assessment

### Database Health Report
- Schema design quality
- Migration safety assessment
- Index optimization recommendations
- Query performance analysis
- Transaction boundary review

### Security Audit Report
- OWASP Top 10 compliance
- Input validation coverage
- Authentication/authorization security
- Dependency vulnerability scan (`npm audit`)
- Sensitive data handling review

### Performance Assessment
- API response time analysis
- Database query optimization
- Caching effectiveness
- Load testing recommendations
- Resource usage profiling
