# Triage Command for Backend Development

Present all findings, decisions, or issues here one by one for triage. The goal is to go through each item and decide whether to add it to the CLI todo system.

**IMPORTANT: DO NOT CODE ANYTHING DURING TRIAGE!**

This command is for:
- Triaging backend code review findings
- Processing API security audit results
- Reviewing database performance analysis
- Handling API design improvements
- Processing dependency vulnerability reports
- Reviewing any other categorized backend findings that need tracking

## Workflow

### Step 1: Present Each Finding

For each finding, present in this format:

```
---
Progress: [X/Y completed] | Estimated time remaining: [Z minutes]

Issue #X: [Brief Title]

Severity: 🔴 P1 (CRITICAL) / 🟡 P2 (IMPORTANT) / 🔵 P3 (NICE-TO-HAVE)

Category: [API-Design/Database/Security/Performance/Testing/Architecture/etc.]

Description:
[Detailed explanation of the backend issue or improvement]

Location: [file_path:line_number]

Problem Scenario:
[Step by step what's wrong or could happen]

Backend Impact:
- API Consumers: [How this affects API users]
- Database: [Schema/performance/integrity impact]
- Security: [Vulnerability or compliance issue]
- Performance: [Response time/throughput/scalability impact]
- Breaking Change: [Yes/No - will this break existing API contracts?]

Proposed Solution:
[How to fix it with specific backend implementation details]

Technical Details:
- Affected Endpoints: [List API endpoints]
- Database Tables: [List tables/entities]
- Migration Required: [Yes/No]
- TypeORM Entities: [List entities]
- Services/Controllers: [List affected components]

Code Example:
```typescript
// Current problematic code
[Show current implementation]

// Proposed fix
[Show corrected implementation]
```

Estimated Effort: [Small (< 2 hours) / Medium (2-8 hours) / Large (> 8 hours)]

Testing Requirements:
- [ ] Unit tests needed
- [ ] Integration tests needed
- [ ] API contract testing needed
- [ ] Database migration testing needed
- [ ] Performance benchmarking needed
- [ ] Security testing needed

---
Do you want to add this to the todo list?
1. yes - create todo file
2. next - skip this item
3. custom - modify before creating
```

### Step 2: Handle User Decision

**When user says "yes":**

1. **Determine next issue ID:**
   ```bash
   ls todos/ | grep -o '^[0-9]\+' | sort -n | tail -1
   ```

2. **Create filename:**
   ```
   {next_id}-pending-{priority}-{brief-description}.md
   ```

   Priority mapping:
   - 🔴 P1 (CRITICAL) → `p1`
   - 🟡 P2 (IMPORTANT) → `p2`
   - 🔵 P3 (NICE-TO-HAVE) → `p3`

   Example: `042-pending-p1-api-authentication-vulnerability.md`

3. **Create from template:**
   ```bash
   cp todos/000-pending-p1-TEMPLATE.md todos/{new_filename}
   ```

4. **Populate the file:**
   ```yaml
   ---
   status: pending
   priority: p1  # or p2, p3 based on severity
   issue_id: "042"
   tags: [category, api, database, security, performance, nestjs, typeorm]
   dependencies: []
   breaking_change: false  # true if API breaking change
   migration_required: false  # true if database migration needed
   ---

   # [Issue Title]

   ## Problem Statement
   [Description from finding]

   ## Findings
   - [Key discoveries]
   - Location: [file_path:line_number]
   - [Scenario details]

   ## Backend Impact Analysis

   ### API Consumers
   - [Impact on API users]
   - Breaking change: [Yes/No]
   - API version affected: [v1, v2, etc.]

   ### Database
   - Schema changes: [Details]
   - Migration required: [Yes/No]
   - Performance impact: [Query time, throughput]
   - Data integrity: [Concerns]

   ### Security
   - Vulnerability type: [SQL injection, XSS, authentication, etc.]
   - OWASP category: [If applicable]
   - Severity: [Critical/High/Medium/Low]

   ### Performance
   - Response time impact: [Current vs expected]
   - Throughput impact: [Requests/sec]
   - Resource usage: [Memory, CPU, connections]

   ## Proposed Solutions

   ### Option 1: [Primary solution]
   - **Pros**: [Benefits]
   - **Cons**: [Drawbacks if any]
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
   [Leave blank - will be filled during approval]

   ## Technical Details
   - **Affected Files**: [List files]
   - **API Endpoints**: [List endpoints]
   - **Database Tables**: [List tables]
   - **TypeORM Entities**: [List entities]
   - **Services**: [List services]
   - **Controllers**: [List controllers]
   - **Middleware**: [If applicable]
   - **Guards/Interceptors**: [If applicable]
   - **Database Changes**: [Yes/No - describe if yes]
   - **Migration Script**: [Path if exists]

   ## Testing Requirements
   - [ ] Unit tests for service layer
   - [ ] Integration tests for API endpoints
   - [ ] API contract testing (Supertest)
   - [ ] Database migration testing (up/down)
   - [ ] Performance benchmarking
   - [ ] Security testing (penetration, OWASP)
   - [ ] Load testing
   - [ ] Postman collection validation

   ## Resources
   - Original finding: [Source of this issue]
   - Related issues: [If any]
   - OpenAPI spec: [Link if applicable]
   - Database schema: [Link to ERD]
   - OWASP reference: [If security issue]
   - NestJS docs: [Relevant documentation]

   ## Acceptance Criteria
   - [ ] [Specific success criteria]
   - [ ] All tests pass (unit + integration)
   - [ ] TypeScript compilation successful
   - [ ] ESLint passes
   - [ ] API documentation updated
   - [ ] Postman collection updated
   - [ ] Migration tested (if applicable)
   - [ ] Performance benchmarks meet targets
   - [ ] Security audit passed
   - [ ] Code reviewed by 2+ developers

   ## Work Log

   ### {date} - Initial Discovery
   **By:** Claude Triage System
   **Actions:**
   - Issue discovered during [triage session type]
   - Categorized as {severity}
   - Backend impact assessed
   - Estimated effort: {effort}

   **Learnings:**
   - [Context and insights]

   ## Notes
   Source: Triage session on {date}
   Breaking change: [Yes/No]
   Migration required: [Yes/No]
   ```

5. **Confirm creation:**
   "✅ Created: `{filename}` - Issue #{issue_id}"

**When user says "next":**
- Skip to the next item
- Track skipped items for summary

**When user says "custom":**
- Ask what to modify (priority, description, technical details, testing requirements)
- Update the information
- Present revised version
- Ask again: yes/next/custom

### Step 3: Continue Until All Processed

- Process all items one by one
- Track using TodoWrite for visibility
- Show progress with each item (X/Y completed, estimated time remaining)
- Don't wait for approval between items - keep moving

### Step 4: Final Summary

After all items processed:

```markdown
## Backend Triage Complete

**Total Items:** [X]
**Todos Created:** [Y]
**Skipped:** [Z]

### Triage Statistics:
- 🌐 API Design issues: [count]
- 🗄️ Database issues: [count]
- 🔒 Security issues: [count]
- ⚡ Performance issues: [count]
- ✅ Testing improvements: [count]
- 📝 Code quality: [count]

### Breaking Changes Identified:
- [List any items that will break API contracts]

### Database Migrations Required:
- [List items requiring migrations]

### Created Todos:
- `042-pending-p1-api-authentication-vulnerability.md` - JWT token validation issue
- `043-pending-p2-database-query-optimization.md` - N+1 query in user service
- `044-pending-p1-sql-injection-search-endpoint.md` - Raw query vulnerability
...

### Skipped Items:
- Item #5: [reason]
- Item #12: [reason]

### Next Steps:
1. Review pending todos: `ls todos/*-pending-*.md`
2. Approve for work: Move from pending → ready status
3. Start work: Use `/traya-backend-engineering:resolve_todo_parallel` or pick individually
4. For breaking changes: Plan API versioning strategy
5. For migrations: Test on staging environment first
```

## Example Response Format

```
---
Progress: 5/12 completed | Estimated time remaining: 14 minutes

Issue #5: Missing Input Validation in User Search Endpoint

Severity: 🔴 P1 (CRITICAL)

Category: Security / API Design

Description:
The user search endpoint in UserController does not validate or sanitize search input,
allowing potential SQL injection through raw query execution in the repository layer.

Location: src/api/controllers/user.controller.ts:45-58, src/repositories/user.repository.ts:123-130

Problem Scenario:
1. Attacker sends malicious search query: `'; DROP TABLE users; --`
2. Raw SQL query concatenates user input directly
3. Database executes destructive SQL command
4. Data loss and system compromise

Backend Impact:
- API Consumers: Vulnerable to exploitation, data breach risk
- Database: Risk of data deletion, unauthorized access, schema manipulation
- Security: CRITICAL - SQL injection (OWASP A03:2021)
- Performance: No impact if fixed properly
- Breaking Change: No - fix is backward compatible

Proposed Solution:
1. Replace raw SQL with TypeORM QueryBuilder with parameter binding
2. Add DTO validation using class-validator
3. Implement input sanitization
4. Add rate limiting to search endpoint

Technical Details:
- Affected Endpoints: GET /api/v1/users/search
- Database Tables: users, user_profiles
- Migration Required: No
- TypeORM Entities: User, UserProfile
- Services/Controllers: UserService, UserController

Code Example:
```typescript
// Current problematic code (user.repository.ts)
async searchUsers(query: string): Promise<User[]> {
  // DANGEROUS: Direct string concatenation
  return this.query(`SELECT * FROM users WHERE name LIKE '%${query}%'`);
}

// Proposed fix (user.repository.ts)
async searchUsers(query: string): Promise<User[]> {
  return this.createQueryBuilder('user')
    .where('user.name LIKE :query', { query: `%${query}%` })
    .limit(50)
    .getMany();
}

// Add DTO validation (user.controller.ts)
export class SearchUserDto {
  @IsString()
  @Length(2, 50)
  @Matches(/^[a-zA-Z0-9\s]+$/, {
    message: 'Search query contains invalid characters'
  })
  query: string;
}

@Get('search')
async search(@Query() searchDto: SearchUserDto): Promise<UserDto[]> {
  return this.userService.searchUsers(searchDto.query);
}
```

Estimated Effort: Small (2 hours)

Testing Requirements:
- [x] Unit tests needed - test QueryBuilder implementation
- [x] Integration tests needed - test endpoint with various inputs
- [x] API contract testing needed - validate response schema
- [ ] Database migration testing needed - not required
- [x] Performance benchmarking needed - ensure query performance
- [x] Security testing needed - test injection attempts, fuzzing

---
Do you want to add this to the todo list?
1. yes - create todo file
2. next - skip this item
3. custom - modify before creating
```

## Backend-Specific Triage Guidelines

### Security Issues (CRITICAL)
- Always create todos for security vulnerabilities
- Tag with OWASP category
- Include proof of concept if available
- Add security testing requirements
- Plan for security audit after fix

### Database Issues
- Assess migration complexity
- Consider zero-downtime deployment
- Plan rollback strategy
- Include performance testing
- Review with DBA if schema changes

### API Breaking Changes
- Evaluate impact on consumers
- Plan API versioning strategy
- Document migration path
- Add deprecation warnings
- Coordinate with frontend teams

### Performance Issues
- Establish baseline metrics
- Set target performance goals
- Include load testing requirements
- Consider caching strategies
- Monitor production impact

Do not code during triage. Every time you present a todo, show progress (how many completed, how many left) and estimated time for completion based on pace.
