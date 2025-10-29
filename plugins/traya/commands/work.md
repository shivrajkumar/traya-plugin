# Work Plan Execution Command

## Introduction

This command helps you analyze a work document (plan, Markdown file, specification, or any structured document), create a comprehensive todo list using the TodoWrite tool, and then systematically execute each task until the entire plan is completed. It combines deep analysis with practical execution to transform plans into reality.

**Skill-Based Execution**: The command automatically detects task types (UI development, API integration) and invokes appropriate skills (ui-developer, api-integrator, ui-tester, code-reviewer) for comprehensive, iterative workflows with built-in quality assurance. This leverages all bundled MCP servers (Figma, Postman, Chrome DevTools, Context7, Serena) to ensure production-ready results.

## Prerequisites

- A work document to analyze (plan file, specification, or any structured document)
- Clear understanding of project context and goals
- Access to necessary tools and permissions for implementation
- Ability to test and validate completed work
- Git repository with main branch
- **Bundled MCP servers** (automatically configured with plugin):
  - Figma MCP (for ui-developer skill - requires Figma Desktop App)
  - Postman MCP (for api-integrator skill)
  - Chrome DevTools MCP (for ui-developer, api-integrator, ui-tester skills)
  - Context7 MCP (for documentation and best practices)
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

1. **Update Main Branch**

   ```bash
   git checkout main
   git pull origin main
   ```

2. **Create Feature Branch and Worktree**

   - Determine appropriate branch name from document
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
   git worktree add -b feature-branch-name "$git_root/.worktrees/feature-branch-name" main
   ```

   - Change to the new worktree directory:

   ```bash
   cd "$git_root/.worktrees/feature-branch-name"
   ```

3. **Verify Environment**
   - Confirm in correct worktree directory
   - Install dependencies if needed
   - Run initial tests to ensure clean state

### Phase 2: Document Analysis and Planning

1. **Read Input Document**

   - Use Read tool to examine the work document
   - Identify all deliverables and requirements
   - Note any constraints or dependencies
   - Extract success criteria

2. **Create Task Breakdown**

   - Convert requirements into specific tasks
   - Add implementation details for each task
   - Include testing and validation steps
   - Consider edge cases and error handling

3. **Build Todo List**
   - Use TodoWrite to create comprehensive list
   - Set priorities based on dependencies
   - Include all subtasks and checkpoints
   - Add documentation and review tasks

### Phase 3: Systematic Execution

1. **Detect Task Type and Invoke Skills**

   Analyze the work document and todo list to determine the task type, then automatically invoke appropriate skills for comprehensive execution:

   **A. For UI Development Tasks**

   If the work involves building UI components from Figma designs or creating new pages/components:

   ```
   1. Invoke ui-developer skill
      - Extract design specifications from Figma (Figma MCP)
      - Analyze existing codebase patterns (Serena MCP)
      - Fetch library documentation (Context7 MCP)
      - Implement component with TypeScript + Tailwind
      - Visual verification loop with Chrome DevTools
      - Iterate until pixel-perfect match

   2. If backend APIs needed → Invoke api-integrator skill
      - Test APIs with Postman (Postman MCP)
      - Set up API client with interceptors
      - Implement authentication integration
      - Connect APIs to UI components
      - Add loading and error states
      - Integration testing with Chrome DevTools
      - Security audit

   3. Invoke ui-tester skill
      - Functional testing (all interactive elements)
      - Error detection and analysis
      - Responsive and visual testing
      - Accessibility validation (WCAG compliance)
      - Performance testing (Core Web Vitals)
      - Issue documentation and fixing
      - Final validation

   4. Invoke code-reviewer skill
      - Task completion verification
      - Technical quality review
      - Best practices validation (Context7 MCP)
      - Code structure and organization review
      - Performance, security, accessibility checks
      - Project conventions compliance
   ```

   **B. For API Integration Tasks**

   If the work focuses primarily on connecting backend APIs:

   ```
   1. Invoke api-integrator skill
      - API discovery and planning (Serena MCP for patterns)
      - Comprehensive API testing with Postman MCP
      - Frontend integration (authentication, data fetching)
      - Integration testing with Chrome DevTools MCP
      - Performance optimization
      - Security audit
      - Documentation

   2. Invoke ui-tester skill
      - Test complete data flow from API to UI
      - Network monitoring and validation
      - Error scenario testing
      - Performance validation

   3. Invoke code-reviewer skill
      - Integration quality review
      - Security validation
      - Performance check
      - Best practices compliance
   ```

   **C. For Other Tasks**

   If the work doesn't fit UI development or API integration patterns, fall back to manual execution with the task loop below.

2. **Task Execution Loop** (Fallback for non-UI/API tasks)

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

   - Run tests after each task (lint, typecheck, unit tests)
   - Execute lint and typecheck commands
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

### Phase 4: Completion and Submission

1. **Final Validation**

   - Verify all tasks completed
   - Run comprehensive test suite
   - Execute final lint and typecheck
   - Check all deliverables present
   - Ensure documentation updated

2. **Prepare for Submission**

   - Stage and commit all changes
   - Write commit messages
   - Push feature branch to remote
   - Create detailed pull request

3. **Create Pull Request**
   ```bash
   git push -u origin feature-branch-name
   gh pr create --title "Feature: [Description]" --body "[Detailed description]"
   ```
