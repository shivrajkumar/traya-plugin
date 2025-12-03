# Feature Testing Command

## Introduction

This command generates comprehensive test plans from work documents, executes automated browser testing using Chrome DevTools MCP, and provides detailed validation results. It transforms feature specifications into executable test cases, runs them in a real browser environment, and reports findings with actionable recommendations.

**Automated Quality Assurance**: The command creates structured test documents (TESTING.md) covering functional, visual, performance, accessibility, and error handling scenarios. After user confirmation, it executes all tests systematically using Chrome DevTools MCP, captures results, and cleans up the test document to keep the repository tidy.

## Prerequisites

- Existing work document (created by `/plan` command or any structured feature document)
- Development server running (`npm run dev` or equivalent)
- Chrome DevTools MCP configured (automatically bundled with plugin)
- Feature implemented and accessible in browser
- **Bundled MCP servers** (automatically configured with plugin):
  - Chrome DevTools MCP (for browser automation and testing)
  - Serena MCP (for code analysis if issues found)
  - Context7 MCP (for best practices documentation)

## Main Tasks

### 1. Analyze Work Document
- Read the work document specified in $ARGUMENTS
- Extract feature description, requirements, and acceptance criteria
- Identify URLs/routes to test
- Determine test scope (components, pages, interactions)

### 2. Generate Testing Document
- Create TESTING.md with comprehensive test cases
- Organize tests by category (Functional, Visual, Performance, Accessibility, Error Handling)
- Include specific test steps and expected results
- Reference Chrome DevTools MCP methods to use

### 3. User Confirmation
- Present TESTING.md to user for review
- Allow modifications before execution
- Get explicit approval to proceed with testing

### 4. Execute Automated Tests
- Start browser automation via Chrome DevTools MCP
- Execute each test case systematically
- Capture results, screenshots, console errors
- Document pass/fail for each test

### 5. Report and Cleanup
- Present comprehensive test results
- Document issues found with severity levels
- Delete TESTING.md after user confirmation

## Execution Workflow

### Phase 1: Work Document Analysis

1. **Read and Parse Work Document**

   ```markdown
   Read the work document from $ARGUMENTS path:
   - Use Read tool to examine the document
   - Look for:
     - Feature name/title
     - Description and purpose
     - User stories or use cases
     - Acceptance criteria
     - Routes/URLs mentioned
     - Components to implement
     - API endpoints involved
     - Expected behavior
     - Edge cases or error scenarios
   ```

2. **Extract Testing Requirements**

   Identify what needs to be tested:

   **From Feature Description:**
   - "User can [action]" → Create functional test for that action
   - "System displays [content]" → Create visual test for content rendering
   - "Form validates [input]" → Create validation test

   **From Acceptance Criteria:**
   - Each criterion becomes a test case
   - "Given X, When Y, Then Z" → Structured test steps

   **From Routes/URLs:**
   - Test route accessibility
   - Test navigation flows
   - Test deep linking

   **From Components:**
   - Test component rendering
   - Test component interactions
   - Test component states

3. **Determine Application URL**

   - Check work document for development URL
   - Default to http://localhost:3000 for Next.js apps
   - Ask user if URL not clear:
     ```
     AskUserQuestion: "What is the development URL to test?"
     Options:
     - http://localhost:3000 (default Next.js)
     - http://localhost:3001
     - http://localhost:5173 (Vite)
     - Other (specify)
     ```

4. **Scope the Testing**

   Categorize tests to generate:
   - **Functional Tests**: Core feature functionality (high priority)
   - **Visual/Responsive Tests**: Layout at different breakpoints (medium priority)
   - **Error Handling Tests**: Error states and edge cases (high priority)
   - **Performance Tests**: Load times and interaction speed (medium priority)
   - **Accessibility Tests**: Keyboard navigation, screen reader support (high priority)

### Phase 2: Generate Testing Document

1. **Create TESTING.md Structure**

   Generate comprehensive test document:

   ```markdown
   # Testing Document: [Feature Name from Work Doc]

   ## Overview
   - **Feature**: [Feature name]
   - **Test Date**: [Current date]
   - **Routes**: [URLs/routes to test]
   - **Work Document**: [Path to work doc]
   - **Tester**: Automated via Chrome DevTools MCP

   ## Test Environment
   - **Application URL**: [Determined URL]
   - **Browser**: Chrome (via Chrome DevTools MCP)
   - **Testing Framework**: Automated browser testing

   ## Test Summary
   - **Total Test Cases**: [X]
     - Functional: [Y]
     - Visual/Responsive: [Z]
     - Error Handling: [A]
     - Performance: [B]
     - Accessibility: [C]

   ## Test Cases

   ### Functional Tests
   [Generated functional test cases]

   ### Visual/Responsive Tests
   [Generated visual test cases]

   ### Error Handling Tests
   [Generated error handling test cases]

   ### Performance Tests
   [Generated performance test cases]

   ### Accessibility Tests
   [Generated accessibility test cases]
   ```

2. **Generate Functional Test Cases**

   Format for each functional test:
   ```markdown
   #### TC-F-001: [Descriptive Test Name]
   - **Description**: [What this test validates]
   - **Prerequisites**: [What needs to be set up first]
   - **Steps**:
     1. Navigate to [URL]
     2. [Action 1: click, type, etc.]
     3. [Action 2]
     4. Verify [expected result]
   - **Expected Result**: [Detailed expected outcome]
   - **MCP Methods**: [Comma-separated list: navigate_page, click, fill_form, etc.]
   - **Priority**: P1/P2/P3
   ```

   **Example generation logic:**
   - If work doc says "User can log in" → Create login test
   - If work doc says "Form validates email" → Create email validation test
   - If work doc mentions "Submit button" → Create submission test

3. **Generate Visual/Responsive Test Cases**

   Test at standard breakpoints:
   ```markdown
   #### TC-V-001: Mobile Layout (375px wide)
   - **Description**: Verify responsive layout on mobile viewport
   - **Steps**:
     1. Navigate to [URL]
     2. Resize browser to 375x667 (iPhone SE)
     3. Verify layout is single column
     4. Verify buttons are full width
     5. Verify no horizontal scroll
     6. Take screenshot for visual verification
   - **Expected Result**: Layout adapts to mobile, all elements visible
   - **MCP Methods**: navigate_page, resize_page, take_screenshot
   - **Priority**: P2

   #### TC-V-002: Tablet Layout (768px wide)
   [Similar structure for tablet]

   #### TC-V-003: Desktop Layout (1920px wide)
   [Similar structure for desktop]
   ```

4. **Generate Error Handling Test Cases**

   ```markdown
   #### TC-E-001: Console Error Check
   - **Description**: Verify no console errors on page load
   - **Steps**:
     1. Navigate to [URL]
     2. Check console for errors
     3. Verify no JavaScript errors present
   - **Expected Result**: Clean console, no errors or warnings
   - **MCP Methods**: navigate_page, list_console_messages
   - **Priority**: P1

   #### TC-E-002: Network Request Validation
   - **Description**: Verify all API requests succeed
   - **Steps**:
     1. Navigate to [URL]
     2. Monitor network requests
     3. Verify all requests return 200-299 status
     4. Verify no failed requests
   - **Expected Result**: All network requests successful
   - **MCP Methods**: navigate_page, list_network_requests
   - **Priority**: P1

   #### TC-E-003: [Feature-Specific Error Test]
   [Generate based on work doc error scenarios]
   ```

5. **Generate Performance Test Cases**

   ```markdown
   #### TC-P-001: Initial Page Load Time
   - **Description**: Measure time to interactive on first load
   - **Steps**:
     1. Clear browser cache
     2. Navigate to [URL]
     3. Measure time to interactive
     4. Record load time
   - **Expected Result**: Page loads in < 3 seconds
   - **MCP Methods**: navigate_page, performance_measure
   - **Priority**: P2

   #### TC-P-002: [Feature Interaction Performance]
   - **Description**: Measure [specific interaction] response time
   - **Steps**:
     1. Navigate to [URL]
     2. Create performance mark
     3. Trigger [interaction]
     4. Measure completion time
   - **Expected Result**: Interaction completes in < 500ms
   - **MCP Methods**: performance_mark, performance_measure
   - **Priority**: P2
   ```

6. **Generate Accessibility Test Cases**

   ```markdown
   #### TC-A-001: Keyboard Navigation
   - **Description**: Verify full keyboard accessibility
   - **Steps**:
     1. Navigate to [URL]
     2. Tab through all interactive elements
     3. Verify each element receives focus
     4. Verify focus indicators visible
     5. Activate elements with Enter/Space
   - **Expected Result**: All interactive elements keyboard accessible
   - **MCP Methods**: navigate_page, press_key, take_snapshot
   - **Priority**: P1

   #### TC-A-002: Focus Management
   - **Description**: Verify focus moves correctly after interactions
   - **Steps**:
     1. Navigate to [URL]
     2. Click button/trigger modal
     3. Verify focus moves to modal
     4. Close modal
     5. Verify focus returns to trigger
   - **Expected Result**: Focus managed appropriately throughout interactions
   - **MCP Methods**: navigate_page, click, press_key, take_snapshot
   - **Priority**: P1
   ```

7. **Write TESTING.md File**

   ```markdown
   Use Write tool to create TESTING.md with all generated content
   - Include all test cases in organized categories
   - Add summary statistics at top
   - Ensure proper markdown formatting
   - Include links back to work document
   ```

8. **Present Test Plan to User**

   ```markdown
   Display summary message:
   "Generated TESTING.md with [X] test cases across [Y] categories:
   - Functional Tests: [count]
   - Visual/Responsive Tests: [count]
   - Error Handling Tests: [count]
   - Performance Tests: [count]
   - Accessibility Tests: [count]

   Please review TESTING.md before I proceed with automated testing."
   ```

### Phase 3: User Review and Confirmation

1. **Get User Approval**

   Use AskUserQuestion tool:
   ```
   Question: "How would you like to proceed with testing?"
   Options:
   1. "Proceed with automated testing"
      - Description: "Execute all test cases now using Chrome DevTools MCP"
   2. "Let me review/modify TESTING.md first"
      - Description: "I'll make changes to the test plan before execution"
   3. "Cancel testing"
      - Description: "Don't run tests, delete TESTING.md"
   ```

2. **Handle User Response**

   **If "Proceed with automated testing":**
   - Continue to Phase 4 immediately
   - Display: "Starting automated test execution..."

   **If "Let me review/modify TESTING.md first":**
   - Display: "Please review and modify TESTING.md as needed"
   - Display: "Run `/traya-frontend-engineering:test --execute` when ready to test"
   - Exit command (user will restart with --execute flag)

   **If "Cancel testing":**
   - Delete TESTING.md using Bash: `rm TESTING.md`
   - Display: "Testing cancelled, TESTING.md deleted"
   - Exit command

3. **Handle --execute Flag**

   If $ARGUMENTS contains "--execute":
   - Skip Phase 1 and Phase 2
   - Read existing TESTING.md
   - Proceed directly to Phase 4

### Phase 4: Automated Test Execution

1. **Setup Browser Environment**

   ```markdown
   Initialize Chrome DevTools MCP:
   - Use browser_navigate to go to application URL
   - Clear console messages
   - Check initial page state
   - Verify page loads successfully
   ```

   ```
   mcp__chrome-devtools__browser_navigate(url: "[Application URL from TESTING.md]")
   mcp__chrome-devtools__browser_console_messages(onlyErrors: false)
   ```

   Verify setup successful:
   - If navigation fails → Report error and exit
   - If console has critical errors → Report and ask user to fix

2. **Execute Functional Tests**

   For each functional test in TESTING.md:

   ```markdown
   a. Read test case details from TESTING.md

   b. Execute test steps:
      - Parse steps from test case
      - For each step:
        - If "Navigate to": browser_navigate
        - If "Click": browser_snapshot → browser_click
        - If "Fill form": browser_fill_form
        - If "Verify": browser_snapshot + comparison
        - If "Type": browser_type
        - If "Wait": browser_wait_for

   c. Capture results:
      - Actual outcome vs expected result
      - Any errors encountered
      - Screenshots if visual verification needed
      - Console errors during test

   d. Determine PASS/FAIL:
      - PASS: Actual matches expected, no errors
      - FAIL: Actual doesn't match or errors occurred

   e. Record result:
      {
        test_id: "TC-F-001",
        name: "Test name",
        status: "PASS" or "FAIL",
        actual_result: "Description of what happened",
        errors: ["Array of errors if any"],
        screenshots: ["Paths if taken"],
        execution_time: "Duration in ms"
      }
   ```

   **Example execution:**
   ```
   Test: TC-F-001: Submit form with valid data

   Step 1: Navigate to http://localhost:3000/form
   → browser_navigate(url: "http://localhost:3000/form")

   Step 2: Fill email field
   → browser_snapshot() to find email input
   → browser_fill_form(fields: [{name: "email", value: "test@example.com", ...}])

   Step 3: Click submit button
   → browser_snapshot() to find submit button
   → browser_click(element: "Submit button", ref: "...")

   Step 4: Verify success message
   → browser_wait_for(text: "Success", time: 5000)
   → browser_snapshot() to verify message present

   Result: PASS (success message appeared)
   ```

3. **Execute Visual/Responsive Tests**

   For each visual test:

   ```markdown
   a. Resize browser to test width:
      browser_resize(width: 375, height: 667)

   b. Navigate to URL if not already there:
      browser_navigate(url: "[URL]")

   c. Take screenshot:
      browser_take_screenshot(filename: "tc-v-001-mobile.png")

   d. Verify layout elements:
      - Use browser_snapshot to check element positions
      - Verify elements visible within viewport
      - Check for horizontal scroll (shouldn't exist)

   e. Compare against expected result description

   f. Record PASS/FAIL with screenshot path
   ```

4. **Execute Error Handling Tests**

   For each error test:

   ```markdown
   a. Console Error Check:
      - Navigate to page
      - Get console messages: browser_console_messages(onlyErrors: true)
      - PASS if no errors, FAIL if errors present
      - Record all error messages

   b. Network Request Check:
      - Navigate to page
      - Get network requests: browser_network_requests()
      - Check all request status codes
      - PASS if all 200-299, FAIL if any failures
      - Record failed requests with details

   c. Feature-Specific Error Tests:
      - Trigger error condition per test steps
      - Verify error handling per expected result
      - Check console for unhandled errors
      - Record error handling behavior
   ```

5. **Execute Performance Tests**

   For each performance test:

   ```markdown
   a. Initial Page Load:
      - Clear cache (if possible via MCP)
      - Create performance mark: performance_mark("start")
      - Navigate to page
      - Wait for page interactive
      - Create end mark: performance_mark("end")
      - Measure: performance_measure("page-load", "start", "end")
      - Compare against threshold (< 3000ms)
      - Record actual time and PASS/FAIL

   b. Interaction Performance:
      - Navigate to page
      - Create mark before interaction
      - Execute interaction (click, type, etc.)
      - Create mark after completion
      - Measure duration
      - Compare against threshold (< 500ms)
      - Record result
   ```

6. **Execute Accessibility Tests**

   For each accessibility test:

   ```markdown
   a. Keyboard Navigation:
      - Navigate to page
      - Simulate Tab key: browser_press_key(key: "Tab")
      - Take snapshot after each tab
      - Verify focus moves to next interactive element
      - Verify focus indicators visible
      - Continue through all elements
      - Record PASS if all elements accessible

   b. Keyboard Activation:
      - Tab to element
      - Press Enter/Space: browser_press_key(key: "Enter")
      - Verify element activates correctly
      - Check for expected behavior
      - Record result

   c. Focus Management:
      - Trigger modal/dialog
      - Verify focus moves into modal
      - Close modal
      - Verify focus returns to trigger
      - Record focus management quality
   ```

7. **Track Test Progress**

   Display progress updates during execution:
   ```markdown
   "Executing functional tests... (3/10 completed)"
   "✓ TC-F-001: Login with valid credentials - PASSED"
   "✗ TC-F-002: Login with invalid credentials - FAILED"
   "  Error: Expected error message not displayed"

   "Executing visual tests... (2/3 completed)"
   "✓ TC-V-001: Mobile layout - PASSED"
   "✓ TC-V-002: Tablet layout - PASSED"

   [Continue for all test categories]
   ```

8. **Aggregate Results**

   Collect all test results into structured report:
   ```
   {
     summary: {
       total: 25,
       passed: 22,
       failed: 3,
       execution_time: "2m 34s"
     },
     by_category: {
       functional: { total: 10, passed: 8, failed: 2 },
       visual: { total: 3, passed: 3, failed: 0 },
       error: { total: 5, passed: 5, failed: 0 },
       performance: { total: 3, passed: 2, failed: 1 },
       accessibility: { total: 4, passed: 4, failed: 0 }
     },
     failed_tests: [
       { id: "TC-F-002", name: "...", error: "...", screenshot: "..." },
       { id: "TC-F-005", name: "...", error: "...", screenshot: "..." },
       { id: "TC-P-002", name: "...", error: "...", actual: "650ms", expected: "< 500ms" }
     ]
   }
   ```

### Phase 5: Results and Cleanup

1. **Generate Test Report**

   Display comprehensive test execution report:

   ```markdown
   # Test Execution Report

   ## Summary
   - **Total Tests**: 25
   - **Passed**: ✅ 22 (88%)
   - **Failed**: ❌ 3 (12%)
   - **Execution Time**: 2 minutes 34 seconds
   - **Test Date**: [Timestamp]

   ## Results by Category

   ### Functional Tests (8/10 passed - 80%)
   - ✅ TC-F-001: Login with valid credentials - PASSED
   - ❌ TC-F-002: Login with invalid credentials - FAILED
     - **Error**: Expected error message "Invalid credentials" not displayed
     - **Actual**: Form submitted without validation
     - **Priority**: P1 (Critical)
   - ✅ TC-F-003: Submit form with valid data - PASSED
   - ✅ TC-F-004: Form field validation - PASSED
   - ❌ TC-F-005: Redirect after submission - FAILED
     - **Error**: Expected redirect to /dashboard, stayed on /form
     - **Actual**: Success message shown but no redirect
     - **Priority**: P1 (Critical)
   - ✅ TC-F-006: Cancel button behavior - PASSED
   - ✅ TC-F-007: Reset form functionality - PASSED
   - ✅ TC-F-008: Save draft feature - PASSED
   - ✅ TC-F-009: Load saved draft - PASSED
   - ✅ TC-F-010: Delete draft - PASSED

   ### Visual/Responsive Tests (3/3 passed - 100%)
   - ✅ TC-V-001: Mobile layout (375px) - PASSED
     - Screenshot: tc-v-001-mobile.png
   - ✅ TC-V-002: Tablet layout (768px) - PASSED
     - Screenshot: tc-v-002-tablet.png
   - ✅ TC-V-003: Desktop layout (1920px) - PASSED
     - Screenshot: tc-v-003-desktop.png

   ### Error Handling Tests (5/5 passed - 100%)
   - ✅ TC-E-001: Console error check - PASSED
     - No console errors detected
   - ✅ TC-E-002: Network request validation - PASSED
     - All 8 requests successful (200-299 status)
   - ✅ TC-E-003: Required field validation - PASSED
   - ✅ TC-E-004: Invalid email format - PASSED
   - ✅ TC-E-005: API error handling - PASSED

   ### Performance Tests (2/3 passed - 67%)
   - ✅ TC-P-001: Initial page load time - PASSED
     - **Result**: 2.1 seconds (< 3s threshold)
   - ❌ TC-P-002: Form submission performance - FAILED
     - **Result**: 650ms (threshold: < 500ms)
     - **Actual**: Form submission took longer than expected
     - **Priority**: P2 (High)
   - ✅ TC-P-003: Navigation performance - PASSED
     - **Result**: 180ms (< 500ms threshold)

   ### Accessibility Tests (4/4 passed - 100%)
   - ✅ TC-A-001: Keyboard navigation - PASSED
     - All 12 interactive elements keyboard accessible
   - ✅ TC-A-002: Focus management - PASSED
     - Focus indicators visible throughout
   - ✅ TC-A-003: Modal focus trap - PASSED
   - ✅ TC-A-004: Form label associations - PASSED

   ## Issues Found

   ### Critical Issues (P1) - 2 issues

   1. **Invalid Credentials Not Validated**
      - **Test**: TC-F-002
      - **Description**: Login form accepts invalid credentials without showing error
      - **Impact**: Users can't tell when login fails, poor UX, potential security issue
      - **Location**: /login page, form submission handler
      - **Fix Suggestion**: Add client-side validation to check response and display error message
      - **Code Path**: Likely missing error handling in form submit handler

   2. **Post-Submission Redirect Missing**
      - **Test**: TC-F-005
      - **Description**: Form shows success message but doesn't redirect to dashboard
      - **Impact**: Users stuck on form page after successful submission
      - **Location**: /form page, after successful POST request
      - **Fix Suggestion**: Add router.push('/dashboard') after successful form submission
      - **Code Path**: Form onSubmit success handler

   ### High Priority Issues (P2) - 1 issue

   1. **Form Submission Slow**
      - **Test**: TC-P-002
      - **Description**: Form submission takes 650ms, exceeds 500ms threshold
      - **Impact**: Slight delay in user feedback, impacts perceived performance
      - **Location**: /form page, form submission
      - **Fix Suggestion**: Optimize API call, add loading state, consider optimistic UI
      - **Measurement**: 650ms vs 500ms threshold (30% over)

   ## Recommendations

   1. **Fix Critical Issues First**
      - Priority: TC-F-002 (validation) and TC-F-005 (redirect)
      - Estimated effort: 1-2 hours
      - These significantly impact user experience

   2. **Performance Optimization**
      - Review form submission API call
      - Consider adding request caching or debouncing
      - Estimated effort: 2-3 hours

   3. **Retest After Fixes**
      - Run failed tests again to verify fixes
      - Consider adding these as regression tests

   4. **All Other Tests Passed**
      - Visual responsiveness working correctly across breakpoints
      - No console errors or network issues
      - Excellent accessibility compliance
      - Good overall performance

   ## Next Steps

   1. Review and fix the 3 failed tests
   2. Rerun testing with: `/traya-frontend-engineering:test --execute`
   3. Once all tests pass, feature is ready for production
   ```

2. **Confirm Cleanup**

   Use AskUserQuestion tool:
   ```
   Question: "Testing complete! Delete TESTING.md?"
   Description: "Test results are saved in this conversation. The TESTING.md file is no longer needed."
   Options:
   1. "Yes, delete it"
      - Description: "Remove TESTING.md to keep repository clean"
   2. "No, keep it for reference"
      - Description: "Keep TESTING.md file in the repository"
   ```

3. **Delete Testing Document**

   If user selects "Yes, delete it":
   ```bash
   rm TESTING.md
   ```

   Display confirmation:
   ```markdown
   "✓ TESTING.md deleted successfully

   Test results are preserved in this conversation.
   You can rerun tests anytime with: /traya-frontend-engineering:test path/to/WORK.md"
   ```

   If user selects "No, keep it for reference":
   ```markdown
   "TESTING.md preserved for reference.

   Note: Consider adding TESTING.md to .gitignore if you don't want it versioned."
   ```

4. **Provide Summary**

   Final message to user:
   ```markdown
   "Testing Summary:
   - ✅ 22 tests passed
   - ❌ 3 tests failed
   - 📊 88% success rate

   [If failures exist]
   Critical issues identified that need attention. Review the report above for details and fix recommendations.

   [If all passed]
   Excellent! All tests passed. Feature is production-ready.

   To test again: /traya-frontend-engineering:test path/to/WORK.md"
   ```

## Error Handling

Throughout execution, handle errors gracefully:

1. **Work Document Not Found**
   - Error message: "Work document not found at [path]. Please provide a valid path."
   - Exit command

2. **Invalid Work Document**
   - If document is empty or unreadable
   - Error message: "Could not parse work document. Ensure it's a valid markdown file."
   - Exit command

3. **Browser Navigation Fails**
   - Error message: "Could not navigate to [URL]. Ensure development server is running."
   - Provide troubleshooting steps
   - Exit command

4. **Chrome DevTools MCP Not Available**
   - Error message: "Chrome DevTools MCP not available. Ensure plugin is properly installed."
   - Provide setup instructions
   - Exit command

5. **Test Execution Fails**
   - Continue with remaining tests
   - Document the failure with full error details
   - Include in final report

## Usage Examples

**Basic usage:**
```bash
/traya-frontend-engineering:test path/to/WORK.md
```

**Resume testing after review:**
```bash
/traya-frontend-engineering:test --execute
```

**With custom URL:**
```bash
/traya-frontend-engineering:test path/to/WORK.md --url http://localhost:3001
```
