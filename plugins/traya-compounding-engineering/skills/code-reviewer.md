---
name: code-reviewer
description: Comprehensive code review skill for Next.js applications. Use this skill after UI development and testing are complete to perform dual-layer code review - task completion verification and technical quality assessment. Utilizes Serena MCP for codebase analysis, Context7 MCP for best practices validation, and Chrome DevTools MCP for runtime verification. Reviews code against requirements, best practices, performance, security, maintainability, and project conventions.
---

# Code Reviewer

## Overview

This skill provides comprehensive code review capabilities with a dual-layer approach: first verifying that the implementation meets the task requirements, then assessing technical quality and best practices. The review process ensures code is correct, maintainable, performant, secure, and follows project conventions before being marked complete.

## Dual-Layer Review Approach

### Layer 1: Task Completion Review
Verify the implementation fulfills the original requirements and specifications.

### Layer 2: Technical Quality Review
Assess code quality, best practices, performance, security, and maintainability.

## Core Review Workflow

Follow this sequential workflow for all code review tasks:

### Phase 1: Context Gathering

**1. Understand the Task Requirements**

Gather context about what was supposed to be implemented:
- Review the original task description or requirements
- Understand the expected functionality
- Note any specific constraints or specifications
- Identify success criteria

**2. Identify Changed Files**

Use Serena MCP to locate all modified code:
```
mcp__serena__list_dir - List relevant directories
mcp__serena__find_file - Find specific files
mcp__serena__get_symbols_overview - Get overview of changes
```

Or use git to see what changed:
```bash
git status
git diff
```

**3. Understand the Implementation**

Use Serena MCP to analyze the implementation:
```
mcp__serena__find_symbol - Locate implemented components/functions
mcp__serena__find_referencing_symbols - Understand how code is used
```

Read the changed code to understand:
- Overall architecture and approach
- Key components and their responsibilities
- Data flow and state management
- Integration points
- Dependencies

### Phase 2: Task Completion Review

**4. Requirements Verification**

Check each requirement against the implementation:

**Functional Requirements:**
- [ ] All required features implemented
- [ ] Features work as specified
- [ ] Edge cases handled
- [ ] Error scenarios covered
- [ ] Success scenarios work correctly

**UI/UX Requirements (if applicable):**
- [ ] Design matches specifications (Figma/mockup)
- [ ] Responsive behavior as specified
- [ ] Interactions work as expected
- [ ] Loading states implemented
- [ ] Error states displayed correctly

**Integration Requirements:**
- [ ] API integrations working
- [ ] Context providers used correctly
- [ ] Analytics tracking implemented
- [ ] Third-party services integrated
- [ ] Environment configuration correct

**Data Requirements:**
- [ ] Data fetched correctly
- [ ] Data transformed properly
- [ ] Data persisted as needed
- [ ] Data validation implemented
- [ ] Data types correct

**5. Scope Verification**

Check for scope issues:

**Under-Implementation:**
- Missing required functionality
- Incomplete features
- Skipped edge cases
- Missing error handling
- Incomplete integration

**Over-Implementation:**
- Features not requested
- Unnecessary complexity
- Premature optimization
- Unused code or abstractions

**6. Testing Verification**

Confirm adequate testing (if UI Tester skill was run):
- [ ] All interactive elements tested
- [ ] No console errors
- [ ] Network requests successful
- [ ] Responsive behavior verified
- [ ] Accessibility validated
- [ ] Performance acceptable

If not tested, note that testing should be performed before final approval.

### Phase 3: Technical Quality Review

**7. Code Structure & Organization**

Assess code organization:

**File Organization:**
- Files in correct directories
- Proper naming conventions followed
- Logical component breakdown
- Clear separation of concerns

For Traya Health project:
- Pages in `app/` directory
- Components in `components/` directory
- Contexts in `context/` directory
- Helpers in `helpers/` directory
- Constants in `constants/` directory

**Component Structure:**
- Components are focused and single-responsibility
- Proper component composition
- Reasonable component size (<300 lines ideally)
- Clear component hierarchy
- Appropriate abstraction level

**Code Organization:**
- Logical code flow
- Related code grouped together
- Clear function/method organization
- Proper imports organization
- Exports are clear and intentional

**8. Code Quality Standards**

Assess fundamental code quality:

**Readability:**
- Clear, descriptive names for variables/functions/components
- Consistent naming conventions (camelCase, PascalCase)
- Self-documenting code
- Minimal complexity
- Clear logic flow

**Maintainability:**
- DRY principle followed (Don't Repeat Yourself)
- KISS principle (Keep It Simple, Stupid)
- YAGNI principle (You Aren't Gonna Need It)
- Single Responsibility Principle
- Functions/methods have single, clear purpose

**TypeScript Usage:**
- Proper type definitions
- No `any` types (unless absolutely necessary)
- Interfaces for props and data structures
- Type safety throughout
- Enums for constants where appropriate

**Error Handling:**
- Try-catch blocks where needed
- Proper error propagation
- User-friendly error messages
- Error logging for debugging
- Graceful degradation

**9. React & Next.js Best Practices**

Use Context7 MCP to verify against current best practices:
```
mcp__context7__resolve-library-id - Resolve Next.js/React
mcp__context7__get-library-docs - Get current best practices
```

**React Best Practices:**
- Proper hook usage (useState, useEffect, useContext, etc.)
- Custom hooks for reusable logic
- Proper dependency arrays in useEffect/useMemo/useCallback
- No unnecessary re-renders
- Proper key props in lists
- Refs used appropriately
- Memo/useMemo/useCallback used judiciously

**Next.js App Router:**
- Correct use of Server vs Client Components
- Server Components by default ('use client' only when needed)
- Proper data fetching patterns
- Correct use of async/await in Server Components
- Proper error boundaries (error.tsx)
- Loading states (loading.tsx) where appropriate
- Metadata properly defined

**Server vs Client Components:**
- Server Components for static content and data fetching
- Client Components only for interactivity
- 'use client' directive used correctly
- No unnecessary client components
- Props serializable when passing to Client Components

**10. State Management Review**

Assess state management approach:

**Local State:**
- useState used appropriately
- useReducer for complex state
- State not over-used
- State initialized correctly
- State updates are pure

**Context Usage:**
- Context used for truly global state
- Context providers at appropriate level
- No unnecessary context re-renders
- Context values memoized when needed

For Traya Health project, verify:
- cart-store used correctly for cart operations
- questions-store for form questionnaire state
- CustomerDataContext for customer information
- AnalyticsContext for tracking integration

**Derived State:**
- Computed values not stored in state
- useMemo for expensive computations
- Proper dependency tracking

**11. Performance Review**

Check for performance issues:

**Component Performance:**
- No unnecessary re-renders
- Proper memoization (React.memo, useMemo, useCallback)
- Large lists virtualized if needed
- Heavy computations optimized or deferred
- Proper code splitting

**Image Optimization:**
- Next.js Image component used
- Proper image sizing
- Lazy loading implemented
- Appropriate formats (WebP when possible)
- Alt text present

**Bundle Size:**
- No unnecessary dependencies
- Dynamic imports for large components
- Tree-shaking enabled
- Minimal third-party libraries

**Network Performance:**
- API calls optimized (no redundant calls)
- Proper caching strategy
- Loading states while fetching
- Error handling for failed requests

**12. Security Review**

Check for security issues:

**Input Validation:**
- User input validated
- XSS prevention (React handles most, but check dangerouslySetInnerHTML)
- SQL injection prevention (if applicable)
- Proper sanitization

**Authentication & Authorization:**
- Protected routes properly secured
- User permissions checked
- Tokens handled securely
- No sensitive data exposed

**Data Handling:**
- No sensitive data in URLs
- No sensitive data in console logs
- HTTPS for API calls
- Environment variables for secrets
- Proper error messages (no stack traces to users)

**Third-Party Integrations:**
- API keys stored in environment variables
- Proper CORS configuration
- Trusted libraries only
- Dependencies up to date

**13. Accessibility Review**

Verify accessibility standards:

**Semantic HTML:**
- Proper HTML elements used
- Heading hierarchy correct (h1, h2, h3...)
- Lists use ul/ol/li
- Forms use label, fieldset, legend
- Buttons vs links used appropriately

**ARIA:**
- ARIA labels on interactive elements
- ARIA roles where semantic HTML insufficient
- ARIA states (expanded, selected, etc.)
- ARIA live regions for dynamic content

**Keyboard Navigation:**
- All interactive elements keyboard accessible
- Tab order logical
- Focus indicators visible
- No keyboard traps
- Enter/Space activate controls

**Screen Readers:**
- Alt text on images
- Form labels associated
- Error messages accessible
- Loading states announced
- Success/failure announced

**14. Styling Review**

Assess styling implementation:

**Tailwind Usage:**
- Tailwind utilities used correctly
- Custom theme values referenced
- Responsive utilities used appropriately
- No inline styles (unless necessary)
- No CSS conflicts

For Traya Health project:
- Male/female color palettes used correctly
- Custom breakpoints followed
- Custom animations from config used
- Project gradient patterns followed

**Responsive Design:**
- Mobile-first approach
- Breakpoints match project standards
- Touch targets adequate (mobile)
- Layout doesn't break at any size

**Visual Quality:**
- Consistent spacing
- Proper alignment
- Appropriate typography
- Color contrast sufficient
- Visual hierarchy clear

**15. Testing & Debugging Aids**

Check for debugging code that should be removed:

**Remove Before Production:**
- Console.log statements
- Debugger statements
- Commented-out code (unless with explanation)
- Test data or mock responses
- Development-only features

**Keep for Maintainability:**
- Useful comments explaining "why"
- Error logging (to proper logger)
- Type definitions and interfaces
- JSDoc for complex functions

### Phase 4: Project-Specific Review

**16. Project Conventions**

For Traya Health codebase, verify:

**File Structure:**
- Follows established patterns
- Components in correct locations
- Proper naming conventions
- Exports match conventions

**API Integration:**
- Uses fetchRequest helper
- URLs from constants/urls.js
- Security tokens included
- Error handling consistent

**Analytics Integration:**
- MoEngage events tracked
- GTM integration correct
- Clarity tracking active
- Event data complete

**Context Usage:**
- Providers used correctly
- Context accessed properly
- Data flows correctly
- Updates propagate

**Form Patterns:**
- Questionnaire patterns followed
- Validation consistent
- Image upload handled correctly
- Submission flow correct

**17. Code Patterns & Conventions**

Use Serena MCP to compare against existing patterns:
```
mcp__serena__search_for_pattern - Find similar implementations
mcp__serena__find_symbol - Compare with existing code
```

Check:
- Similar components follow same patterns
- Utility functions used consistently
- Helper methods match conventions
- Error handling consistent
- Naming conventions maintained

### Phase 5: Runtime Verification

**18. Runtime Validation (Optional)**

If code review reveals concerns, verify at runtime using Chrome DevTools MCP:
```
mcp__chrome-devtools__navigate_page - Load the page
mcp__chrome-devtools__list_console_messages - Check for errors
mcp__chrome-devtools__evaluate_script - Test specific functionality
```

Use runtime verification to:
- Confirm functionality works as code suggests
- Verify no runtime errors
- Check performance characteristics
- Validate data flow
- Test edge cases

### Phase 6: Feedback & Recommendations

**19. Categorize Findings**

Organize review findings by severity:

**Critical (Must Fix):**
- Broken functionality
- Security vulnerabilities
- Data loss risks
- Performance blockers
- Accessibility blockers

**High (Should Fix):**
- Code quality issues
- Maintainability problems
- Missing error handling
- Performance concerns
- Accessibility improvements

**Medium (Consider Fixing):**
- Code style inconsistencies
- Minor optimizations
- Documentation gaps
- Refactoring opportunities

**Low (Nice to Have):**
- Code cleanup
- Minor style improvements
- Optional optimizations

**20. Provide Constructive Feedback**

For each issue:

**Describe the Problem:**
- What is wrong
- Where it occurs (file:line)
- Why it's an issue

**Explain the Impact:**
- How it affects users
- How it affects developers
- How it affects the codebase

**Suggest Solutions:**
- Specific code changes
- Alternative approaches
- Resources for learning
- Examples from codebase

**Example Feedback Format:**
```
❌ Issue: Missing error handling in data fetch

Location: app/products/page.tsx:42

Problem: The API call to fetch products doesn't handle errors, which will
crash the page if the API fails.

Impact: Users will see a blank page instead of an error message when the
API is down.

Solution: Add try-catch block and show user-friendly error:

try {
  const products = await fetchProducts();
  return <ProductList products={products} />;
} catch (error) {
  console.error('Failed to fetch products:', error);
  return <ErrorMessage message="Unable to load products. Please try again." />;
}

See app/appointments/page.tsx:35 for example of proper error handling.
```

**21. Highlight Positive Aspects**

Note what was done well:

- Good architectural decisions
- Clever solutions to problems
- Excellent code quality
- Proper testing coverage
- Great documentation
- Following best practices

**22. Provide Summary**

Create review summary:

**Task Completion:**
- Requirements met: X/Y
- All features implemented: Yes/No
- Edge cases handled: Yes/No
- Integration complete: Yes/No

**Technical Quality:**
- Code quality: Excellent/Good/Needs Improvement/Poor
- Performance: Excellent/Good/Acceptable/Needs Work
- Security: No issues/Minor issues/Needs attention
- Accessibility: Excellent/Good/Needs improvement
- Maintainability: Excellent/Good/Needs work

**Overall Assessment:**
- Ready for production: Yes/No
- Needs revisions: Yes/No
- Blocking issues: X issues
- Recommendations: Y suggestions

**23. Create Action Items**

List specific actions to take:

**Required Actions:**
1. Fix security issue in authentication
2. Add error handling to API calls
3. Remove console.log statements

**Recommended Actions:**
1. Extract repeated logic into custom hook
2. Add JSDoc comments to complex functions
3. Optimize image loading

**Optional Improvements:**
1. Consider using React.memo for ProductCard
2. Could extract validation logic to helper

## Review Checklists

### Quick Review Checklist

Use for rapid review:

- [ ] Requirements met
- [ ] No console errors
- [ ] Code is readable
- [ ] Types are correct
- [ ] Error handling present
- [ ] No security issues
- [ ] Accessibility basics covered
- [ ] Performance acceptable
- [ ] Follows project conventions

### Comprehensive Review Checklist

Use for thorough review:

**Task Completion:**
- [ ] All requirements implemented
- [ ] Edge cases handled
- [ ] Integrations working
- [ ] Data flow correct
- [ ] Testing completed

**Code Quality:**
- [ ] Clear naming conventions
- [ ] Single responsibility
- [ ] DRY principle
- [ ] KISS principle
- [ ] Proper abstraction

**React/Next.js:**
- [ ] Proper hook usage
- [ ] Server/Client components correct
- [ ] No unnecessary re-renders
- [ ] Proper error boundaries
- [ ] Loading states

**Performance:**
- [ ] No unnecessary re-renders
- [ ] Images optimized
- [ ] Code split appropriately
- [ ] API calls efficient

**Security:**
- [ ] Input validated
- [ ] No sensitive data exposed
- [ ] Authentication secure
- [ ] Dependencies safe

**Accessibility:**
- [ ] Semantic HTML
- [ ] ARIA labels
- [ ] Keyboard navigation
- [ ] Screen reader compatible

**Maintainability:**
- [ ] Clear code structure
- [ ] Reasonable file sizes
- [ ] Proper documentation
- [ ] Follows conventions

## MCP Server Usage

### Serena MCP (Primary Tool)
Essential for code analysis:
- `list_dir` - Understand directory structure
- `find_file` - Locate specific files
- `get_symbols_overview` - Get file overviews
- `find_symbol` - Analyze specific components
- `find_referencing_symbols` - Understand usage
- `search_for_pattern` - Find similar code patterns

### Context7 MCP (Best Practices)
Validate against current standards:
- Fetch Next.js best practices
- Get React documentation
- Verify library usage
- Check for deprecated patterns

### Chrome DevTools MCP (Runtime Verification)
Optional runtime validation:
- Navigate to pages for verification
- Check console for errors
- Test functionality
- Verify performance

## Best Practices for Code Review

### Be Constructive
- Focus on the code, not the person
- Explain the "why" behind suggestions
- Provide examples and alternatives
- Acknowledge good work

### Be Specific
- Reference exact file and line numbers
- Provide concrete examples
- Show before/after code
- Link to relevant documentation

### Be Thorough
- Check all changed files
- Consider edge cases
- Think about maintainability
- Consider future developers

### Be Consistent
- Apply same standards to all code
- Follow project conventions
- Use established patterns
- Reference existing examples

### Be Pragmatic
- Balance perfection with progress
- Prioritize critical issues
- Consider time constraints
- Focus on high-impact improvements

## Common Code Smells to Watch For

### React/Next.js Code Smells
- UseEffect with missing dependencies
- Inline object/function props causing re-renders
- Prop drilling (should use context)
- Overly large components (>300 lines)
- 'use client' when Server Component would work
- Fetching data in useEffect (should use Server Component)

### General Code Smells
- Deeply nested code (>3-4 levels)
- Long functions (>50 lines)
- Duplicate code
- Magic numbers (use constants)
- Unclear variable names
- Complex conditionals
- Large number of parameters (>5)

### Performance Code Smells
- Unnecessary state
- Missing memoization
- Unoptimized images
- Synchronous operations blocking UI
- Large bundle sizes
- Redundant API calls

## Integration with Other Skills

### After UI Development and Testing
This skill is the final validation step:

1. UI Developer Skill → Implements component
2. UI Tester Skill → Tests functionality
3. **Code Reviewer Skill** → Reviews implementation quality

### Workflow Integration
Code review ensures:
- Implementation meets requirements (Task Completion)
- Code quality meets standards (Technical Review)
- Code is production-ready
- Team standards maintained

## Completion Criteria

Code review is complete when:
1. All task requirements verified as met
2. Technical quality assessed across all dimensions
3. Findings categorized by severity
4. Constructive feedback provided
5. Specific action items created
6. Summary assessment completed
7. Developer has clear next steps (if revisions needed)
8. Code approved for production (if no blocking issues)

## Final Approval Criteria

Code can be approved when:
- All P0 (Critical) issues resolved
- All P1 (High) issues resolved or have plan
- Task requirements fully met
- Code quality acceptable
- Performance acceptable
- Security validated
- Accessibility requirements met
- Follows project conventions
- Properly tested (UI Tester skill run)
- Documentation adequate
