# Work Plan Execution Command for Backend Development

## Introduction

This command helps you analyze a backend work document (plan, Markdown file, API specification, database design, or any structured document), create a comprehensive todo list using the TodoWrite tool, and then systematically execute each task until the entire plan is completed. It combines deep analysis with practical execution to transform backend plans into production-ready APIs and services.

**Skill-Based Execution**: The command automatically detects backend task types (API development, database integration, documentation, testing) and invokes appropriate skills (api-developer, database-integrator, api-documentation-generator, api-tester, code-reviewer) for comprehensive, iterative workflows with built-in quality assurance. This leverages all bundled MCP servers (Postman, Context7, Serena) to ensure production-ready results.

## Prerequisites

- A work document to analyze (plan file, API specification, database design, or any structured document)
- Clear understanding of project context and goals
- Access to necessary tools and permissions for implementation
- Ability to test and validate completed work
- Git repository with main branch
- **Bundled MCP servers** (automatically configured with plugin):
  - Postman MCP (for API testing and validation)
  - Context7 MCP (for framework documentation and best practices)
  - Serena MCP (for codebase pattern analysis)

## Main Tasks

### 1. Setup Development Environment

- Ensure main branch is up to date
- Create feature branch with descriptive name
- Setup worktree for isolated development
- Configure development environment

### 2. Analyze Input Document

<input_document> #$ARGUMENTS </input_document>

## Execution Workflow

### Phase 1: Environment Setup

1. **Verify Current Environment**

   - Confirm you're in the correct project directory
   - Check current git branch: `git branch --show-current`
   - Verify git status is clean or has only expected changes: `git status`
   - Ensure all dependencies are installed

2. **Optional: Create Feature Branch and Worktree**

   If you want isolated development without affecting your current directory, optionally create a worktree:

   - Get the root directory of the Git repository:

   ```bash
   git_root=$(git rev-parse --show-toplevel)
   ```

   - Create worktrees directory if it doesn't exist:

   ```bash
   mkdir -p "$git_root/.worktrees"
   ```

   - Add .worktrees to .gitignore if not already there:

   ```bash
   if ! grep -q "^\.worktrees$" "$git_root/.gitignore"; then
     echo ".worktrees" >> "$git_root/.gitignore"
   fi
   ```

   - Create the new worktree with feature branch:

   ```bash
   git worktree add -b feature-branch-name "$git_root/.worktrees/feature-branch-name"
   ```

   - Change to the new worktree directory:

   ```bash
   cd "$git_root/.worktrees/feature-branch-name"
   ```

   **Note:** If you prefer to work in your current directory with your current branch, skip worktree creation and proceed directly to Phase 2.

3. **Install Dependencies (if needed)**
   - Run `npm install` or `yarn install` if dependencies are missing
   - Run initial tests to ensure clean state
   - Verify database connection and migrations are up to date

### Phase 2: Document Analysis and Planning

1. **Read Input Document**

   - Use Read tool to examine the work document
   - Identify all deliverables and requirements (API endpoints, database schemas, integrations)
   - Note any constraints or dependencies (external APIs, database migrations, authentication)
   - Extract success criteria (performance targets, test coverage, API contract compliance)

2. **Create Task Breakdown**

   - Convert requirements into specific backend tasks
   - Add implementation details for each task (controllers, services, entities, migrations)
   - Include testing and validation steps (unit tests, integration tests, API testing)
   - Consider edge cases and error handling (validation, error responses, rollback strategies)

3. **Build Todo List**
   - Use TodoWrite to create comprehensive list
   - Set priorities based on dependencies (database schema before API implementation)
   - Include all subtasks and checkpoints
   - Add documentation and review tasks (OpenAPI specs, Postman collections)

### Phase 3: Systematic Execution

1. **Detect Task Type and Invoke Skills**

   Analyze the work document and todo list to determine the backend task type, then automatically invoke appropriate skills for comprehensive execution:

   **A. For API Development Tasks**

   If the work involves building new API endpoints, implementing REST/GraphQL APIs, or creating controller logic:

   ```
   1. Invoke api-developer skill
      - Analyze API requirements and design specifications
      - Review existing API patterns with Serena MCP
      - Fetch NestJS/Express documentation with Context7 MCP
      - Implement controllers, services, DTOs
      - Set up request validation with class-validator
      - Implement authentication/authorization guards
      - Add error handling and response serialization
      - Visual API testing with Postman MCP
      - Iterate until API contract validated

   2. If database changes needed → Invoke database-integrator skill
      - Design database schema and ERD
      - Create TypeORM entities and repositories
      - Generate database migrations
      - Implement data access layer
      - Add indexes and optimize queries
      - Test migration up/down scripts
      - Validate data integrity

   3. Invoke api-documentation-generator skill
      - Generate OpenAPI 3.0 specification
      - Create Postman collection with examples
      - Document authentication requirements
      - Add request/response examples
      - Generate API changelog
      - Update developer documentation

   4. Invoke api-tester skill
      - Unit testing for services and controllers
      - Integration testing with Supertest
      - API contract testing with Postman MCP
      - Error scenario validation
      - Performance testing (response times)
      - Security testing (authentication, authorization, injection)
      - Issue documentation and fixing

   5. Invoke code-reviewer skill
      - Task completion verification
      - Technical quality review
      - Best practices validation (Context7 MCP)
      - Code structure and organization review
      - Performance, security, OWASP compliance checks
      - Project conventions compliance
   ```

   **B. For Database Integration Tasks**

   If the work focuses primarily on database design, migrations, or ORM implementation:

   ```
   1. Invoke database-integrator skill
      - Database schema design and ERD creation
      - TypeORM entity definitions
      - Migration scripts with rollback support
      - Repository pattern implementation
      - Query optimization and indexing
      - Data seeding for development
      - Migration testing and validation

   2. If APIs expose database → Invoke api-developer skill
      - Create controllers for CRUD operations
      - Implement DTOs and validation
      - Add pagination, filtering, sorting
      - Response serialization

   3. Invoke api-tester skill
      - Test database transactions and rollbacks
      - Validate migration scripts
      - Integration testing with test database
      - Performance testing for queries
      - Data integrity validation

   4. Invoke code-reviewer skill
      - Database design review
      - Migration safety verification
      - Query performance analysis
      - Index optimization review
   ```

   **C. For API Documentation Tasks**

   If the work involves creating or updating API documentation, OpenAPI specs, or Postman collections:

   ```
   1. Invoke api-documentation-generator skill
      - OpenAPI 3.0 specification generation
      - Postman collection creation
      - GraphQL schema documentation (if applicable)
      - Authentication guide
      - Error code reference
      - Integration examples

   2. Invoke api-tester skill
      - Validate documentation accuracy
      - Test all documented endpoints
      - Verify examples work correctly
      - Check authentication flows

   3. Invoke code-reviewer skill
      - Documentation completeness review
      - Accuracy verification
      - Best practices compliance
   ```

   **D. For Testing and Quality Assurance Tasks**

   If the work focuses on testing, quality improvements, or bug fixes:

   ```
   1. Invoke api-tester skill
      - Write comprehensive unit tests
      - Create integration test suites
      - API contract testing
      - Performance benchmarking
      - Security testing
      - Load testing

   2. Invoke code-reviewer skill
      - Test quality review
      - Coverage analysis
      - Edge case verification
      - Security audit
   ```

   **E. For Other Backend Tasks**

   If the work doesn't fit the above patterns (refactoring, configuration, DevOps, etc.), fall back to manual execution with the task loop below.

2. **Task Execution Loop** (Fallback for non-standard backend tasks)

   ```
   while (tasks remain):
     - Select next task (priority + dependencies)
     - Mark as in_progress
     - Execute task completely
     - Validate completion
     - Mark as completed
     - Update progress
   ```

3. **Quality Assurance**

   - Run tests after each task (lint, typecheck, unit tests, integration tests)
   - Execute lint command: `npm run lint` or `yarn lint`
   - Execute typecheck: `npm run type-check` or `tsc --noEmit`
   - Run unit tests: `npm test` or `yarn test`
   - Run integration tests if available
   - Verify no regressions
   - Check against acceptance criteria
   - Document any issues found
   - Ensure all MCP-based validations passed (if skills were used)

4. **Progress Tracking**
   - Regularly update task status
   - Note any blockers or delays
   - Create new tasks for discoveries
   - Maintain work visibility
   - Document skill execution results

### Phase 4: Local Testing, Review & Submission

1. **Final Local Validation**

   - Verify all tasks completed
   - Run comprehensive test suite locally
   - Execute final lint: `npm run lint`
   - Execute final typecheck: `tsc --noEmit`
   - Run all tests: `npm test`
   - Check all deliverables present (APIs, migrations, tests, docs)
   - Ensure documentation updated (OpenAPI specs, Postman collections)
   - Verify database migrations are reversible
   - Test API endpoints with Postman MCP
   - Manually test all functionality

2. **Review Changes Before Committing**

   - Show current git status: `git status`
   - Show detailed changes: `git diff`
   - Stage changes: `git add .`
   - Show staged changes: `git diff --cached`
   - **Wait for your approval** before proceeding to commit

3. **Commit (After Manual Testing & Review)**

   Only after you confirm that:
   - All local testing is complete
   - All functionality works as expected
   - Database migrations are validated
   - Changes are ready to be committed

   Then commit with descriptive message:
   ```bash
   git commit -m "Your descriptive commit message"
   ```

4. **Push (After Commit Approval)**

   Only after you confirm the commit is correct:
   ```bash
   git push -u origin current-branch-name
   ```

5. **Create Pull Request (Optional, On Request)**

   Create a pull request only when you're ready:
   ```bash
   gh pr create --title "feat: [API/Database/Feature Description]" --body "[Detailed description with API changes, database impacts, testing notes]"
   ```

## Backend-Specific Guidelines

### API Development Best Practices

- Follow REST principles (proper HTTP methods, status codes, resource naming)
- Use OpenAPI 3.0 for API specifications
- Implement proper error handling (RFC 7807 Problem Details)
- Add request validation with class-validator
- Implement authentication/authorization
- Use DTOs for request/response serialization
- Add API versioning strategy

### Database Development Best Practices

- Always create reversible migrations
- Use transactions for multi-step operations
- Add proper indexes for query performance
- Follow naming conventions for entities and columns
- Include data seeding for development
- Test migrations on sample data
- Document schema changes

### Testing Best Practices

- Aim for >80% test coverage
- Write unit tests for services
- Create integration tests for API endpoints
- Use Supertest for HTTP testing
- Test error scenarios and edge cases
- Validate authentication/authorization
- Performance test critical endpoints
- Use Postman MCP for automated API testing

### Documentation Best Practices

- Generate OpenAPI specs from code decorators
- Keep Postman collections up to date
- Document authentication requirements
- Include request/response examples
- Maintain API changelog
- Add inline code comments for complex logic
- Update README with setup instructions

## MCP Server Integration

This command leverages bundled MCP servers:

- **Postman MCP**: Automated API testing, collection management, contract validation
- **Context7 MCP**: Access to NestJS, Express, TypeORM documentation and best practices
- **Serena MCP**: Analyze existing codebase patterns for consistency

Skills automatically use these MCP servers when invoked, providing comprehensive backend development workflow automation.
