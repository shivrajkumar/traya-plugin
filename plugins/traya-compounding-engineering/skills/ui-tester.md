---
name: ui-tester
description: Comprehensive UI testing and debugging skill for Next.js applications. Use this skill after UI development is complete to perform thorough testing and issue detection. Utilizes Chrome DevTools MCP for functional testing, console error detection, network monitoring, accessibility validation, performance analysis, and responsive testing. Automatically identifies and fixes issues through systematic verification across multiple dimensions.
---

# UI Tester

## Overview

This skill provides comprehensive testing and debugging capabilities for UI components and pages. It performs systematic verification across functional, visual, performance, accessibility, and error dimensions. The skill uses Chrome DevTools MCP extensively to detect issues, analyze root causes, and validate fixes, ensuring production-ready quality.

## Core Testing Workflow

Follow this sequential workflow for all UI testing tasks:

### Phase 1: Initial Setup & Assessment

**1. Verify Development Environment**

Ensure the application is running:
```bash
# Check if dev server is running, start if needed
npm run dev
```

Confirm the page/component to test:
- Get the exact URL or route
- Understand the expected functionality
- Review any specific test requirements

**2. Initial Health Check**

Use Chrome DevTools MCP to perform initial assessment:
```
mcp__chrome-devtools__navigate_page - Navigate to the component/page
mcp__chrome-devtools__list_console_messages - Check for immediate errors
mcp__chrome-devtools__list_network_requests - Verify resource loading
```

Document initial state:
- Any console errors or warnings
- Failed network requests
- Visual rendering issues
- Performance red flags

### Phase 2: Functional Testing

**3. Interactive Element Testing**

Test all interactive elements systematically:

**Buttons & Links:**
```
mcp__chrome-devtools__take_snapshot - Get element references
mcp__chrome-devtools__click - Test click interactions
mcp__chrome-devtools__hover - Verify hover states
```

For each button/link verify:
- Click triggers expected action
- Hover state displays correctly
- Active/focus states work
- Loading states appear when appropriate
- Disabled states prevent interaction

**Form Elements:**
```
mcp__chrome-devtools__fill_form - Test form inputs
mcp__chrome-devtools__click - Submit forms
```

For each form field verify:
- Input accepts valid values
- Validation triggers on invalid values
- Error messages display correctly
- Form submission works
- Success/failure states handled
- Clear/reset functionality works

**Navigation & Routing:**
```
mcp__chrome-devtools__click - Test navigation links
mcp__chrome-devtools__navigate_back - Test back navigation
```

Verify:
- Links navigate to correct routes
- Browser back/forward works
- Active navigation states update
- Deep links work correctly

**Dynamic Content:**
```
mcp__chrome-devtools__evaluate_script - Test JavaScript interactions
mcp__chrome-devtools__wait_for - Wait for async operations
```

Verify:
- Modals open and close correctly
- Dropdowns expand and collapse
- Tabs switch properly
- Accordions work as expected
- Dynamic content loads correctly
- Infinite scroll or pagination works

**4. State Management Testing**

Test component state changes:
- Test initial state rendering
- Test state updates after user actions
- Verify state persistence if needed
- Test state reset functionality
- Verify context updates propagate correctly

For Traya Health codebase, specifically test:
- Cart state updates (cart-store context)
- Question flow state (questions-store context)
- Customer data updates (CustomerDataContext)
- Analytics events fire correctly (AnalyticsContext)

### Phase 3: Error Detection & Analysis

**5. Console Error Analysis**

Comprehensively check console for issues:
```
mcp__chrome-devtools__list_console_messages - Get all console messages
```

Categorize and prioritize:

**Critical Errors (Fix Immediately):**
- JavaScript runtime errors
- Unhandled promise rejections
- React errors (component crashes)
- Missing required data errors
- Type errors

**Warnings (Fix Before Production):**
- React warnings (key props, deprecated APIs)
- Performance warnings
- Accessibility warnings
- Deprecated feature warnings

**Info/Debug Messages (Review):**
- Excessive logging (clean up for production)
- Debug statements left in code
- Development-only messages

For each error/warning:
1. Note exact error message and stack trace
2. Identify which component/file is the source
3. Determine root cause
4. Prioritize severity
5. Document for fixing

**6. Network Request Analysis**

Monitor all network activity:
```
mcp__chrome-devtools__list_network_requests - Get all requests
mcp__chrome-devtools__get_network_request - Get detailed request info
```

Check for issues:

**Failed Requests:**
- 4xx errors (client errors)
- 5xx errors (server errors)
- Network timeouts
- Aborted requests

**Performance Issues:**
- Slow requests (>3s)
- Large payload sizes
- Unnecessary requests
- Duplicate requests
- Missing caching headers

**Security Concerns:**
- Requests over HTTP (should be HTTPS)
- Exposed sensitive data in URLs
- Missing authentication headers
- CORS issues

For Traya Health API integration:
- Verify fetchRequest helper is used
- Check URLs match constants/urls.js
- Verify security tokens are included
- Check error handling for failed requests

### Phase 4: Responsive & Visual Testing

**7. Responsive Behavior Testing**

Test at all key breakpoints:
```
mcp__chrome-devtools__resize_page - Change viewport size
mcp__chrome-devtools__take_screenshot - Capture each breakpoint
```

Standard breakpoints (from Tailwind config):
- **Mobile:** 375px, 428px
- **Tablet:** 768px, 834px
- **Desktop:** 1024px, 1280px, 1440px, 1920px

At each breakpoint verify:
- Layout doesn't break
- Content is readable
- Navigation is accessible
- Images scale properly
- No horizontal scrolling
- Touch targets are adequate (mobile)
- Hover states work appropriately (desktop)

**8. Visual Regression Testing**

Capture screenshots for comparison:
```
mcp__chrome-devtools__take_screenshot - Capture current state
```

Check for visual issues:
- Overlapping elements
- Clipped or hidden content
- Incorrect spacing or alignment
- Wrong colors or typography
- Missing images or icons
- Broken layouts
- Z-index stacking issues

**9. Browser Dialog Testing**

Test any dialogs or modals:
```
mcp__chrome-devtools__handle_dialog - Handle browser dialogs
```

Verify:
- Confirm/alert dialogs work
- Cancel actions work correctly
- Dialog content is clear
- Keyboard navigation works (ESC to close)

### Phase 5: Accessibility Testing

**10. Accessibility Validation**

Use accessibility tree analysis:
```
mcp__chrome-devtools__take_snapshot - Get accessibility tree
```

Check for accessibility issues:

**Semantic HTML:**
- Proper heading hierarchy (h1, h2, h3...)
- Semantic elements used (nav, main, article, etc.)
- Form labels associated with inputs
- Button vs link usage appropriate

**ARIA Attributes:**
- ARIA labels on interactive elements
- ARIA roles where needed
- ARIA states (expanded, selected, etc.)
- ARIA live regions for dynamic content

**Keyboard Navigation:**
```
mcp__chrome-devtools__press_key - Test keyboard interactions
```

Test keyboard accessibility:
- Tab through all interactive elements
- Tab order is logical
- Focus indicators visible
- Enter/Space activate buttons
- ESC closes modals/dropdowns
- Arrow keys work in custom controls

**Screen Reader Compatibility:**
- Alt text on images
- Descriptive link text (not "click here")
- Form errors announced
- Loading states announced
- Success/failure messages announced

**Color Contrast:**
- Text has sufficient contrast (4.5:1 for normal, 3:1 for large)
- Interactive elements visible
- Focus indicators have sufficient contrast

### Phase 6: Performance Testing

**11. Performance Analysis**

Check for performance issues:

**Initial Load Performance:**
```
mcp__chrome-devtools__list_network_requests - Check resource sizes
```

Analyze:
- Total page weight
- Number of requests
- Time to first paint
- Time to interactive
- Blocking resources

**Runtime Performance:**
```
mcp__chrome-devtools__evaluate_script - Test performance metrics
```

Check for:
- Excessive re-renders
- Memory leaks
- Unoptimized animations
- Heavy computations blocking UI
- Unthrottled scroll/resize handlers

**Image Optimization:**
- Images use Next.js Image component
- Appropriate image formats (WebP when possible)
- Images are sized correctly
- Lazy loading implemented

For deeper performance analysis:
```
mcp__chrome-devtools__performance_start_trace - Start performance recording
mcp__chrome-devtools__performance_stop_trace - Stop and analyze
mcp__chrome-devtools__performance_analyze_insight - Get specific insights
```

**12. Throttling Tests**

Test under constrained conditions:
```
mcp__chrome-devtools__emulate_network - Simulate slow network
mcp__chrome-devtools__emulate_cpu - Simulate slow CPU
```

Test scenarios:
- Slow 3G network
- Fast 3G network
- 4x CPU slowdown

Verify:
- Loading states appear appropriately
- App remains usable
- No timeouts occur
- Proper error handling for slow loads

### Phase 7: Issue Documentation & Fixing

**13. Issue Prioritization**

Categorize all found issues:

**P0 (Critical - Block Release):**
- App crashes or is unusable
- Data loss or corruption
- Security vulnerabilities
- Critical functionality broken

**P1 (High - Fix Before Release):**
- Major functionality broken
- Console errors affecting UX
- Failed API calls
- Accessibility blockers
- Performance severely degraded

**P2 (Medium - Should Fix):**
- Minor functionality issues
- Console warnings
- Suboptimal performance
- Accessibility improvements
- Visual inconsistencies

**P3 (Low - Nice to Have):**
- Code cleanup
- Minor optimizations
- Documentation improvements

**14. Systematic Issue Resolution**

For each issue, follow this process:

**1. Reproduce:**
- Document exact steps to reproduce
- Note which scenarios trigger the issue
- Identify if it's environment-specific

**2. Diagnose:**
- Use Serena MCP to analyze relevant code:
  ```
  mcp__serena__find_symbol - Locate problematic component
  mcp__serena__find_referencing_symbols - Find related code
  ```
- Check Context7 MCP for library documentation if needed
- Identify root cause

**3. Fix:**
- Implement fix in code
- Ensure fix doesn't introduce new issues
- Follow project best practices
- Add error handling if missing

**4. Verify:**
- Re-test the specific issue
- Run full test suite again
- Check console for new errors
- Verify fix at all breakpoints
- Test edge cases

**5. Document:**
- Note what was fixed and how
- Document any gotchas or considerations
- Update component documentation if needed

### Phase 8: Final Validation

**15. Comprehensive Retest**

After all fixes, run complete test suite again:

1. Repeat functional testing (Phase 2)
2. Verify no console errors (Phase 3)
3. Retest responsive behavior (Phase 4)
4. Validate accessibility (Phase 5)
5. Confirm performance acceptable (Phase 6)

**16. Cross-Browser Testing Checklist**

While Chrome DevTools is primary, note any browser-specific issues to test manually:
- [ ] Chrome (tested via MCP)
- [ ] Safari (test manually if available)
- [ ] Firefox (test manually if available)
- [ ] Mobile browsers (test on real devices if possible)

**17. Final Sign-Off Checklist**

Before marking testing complete, verify:
- [ ] All P0 and P1 issues resolved
- [ ] No console errors or warnings
- [ ] All network requests succeed
- [ ] Forms submit successfully
- [ ] Navigation works correctly
- [ ] Responsive at all breakpoints
- [ ] Accessibility requirements met
- [ ] Performance acceptable
- [ ] Loading states implemented
- [ ] Error states handled gracefully
- [ ] Analytics events firing (if applicable)
- [ ] Context integration working (if applicable)

## Testing Patterns for Common Scenarios

### Testing a Form Page
1. Test all form inputs (text, select, radio, checkbox)
2. Test validation (required fields, format validation)
3. Test error message display
4. Test form submission
5. Test loading state during submission
6. Test success state
7. Test failure state and error handling
8. Verify analytics events fire

### Testing a Dashboard/Data Page
1. Test initial data load
2. Test loading states
3. Test empty states (no data)
4. Test error states (failed load)
5. Test data refresh functionality
6. Test filters or search
7. Test pagination or infinite scroll
8. Verify API calls are efficient

### Testing a Modal/Dialog
1. Test open trigger
2. Test close via X button
3. Test close via ESC key
4. Test close via backdrop click
5. Test focus trap (tab stays in modal)
6. Test content scrolling if needed
7. Test responsive behavior
8. Verify backdrop prevents background interaction

### Testing Navigation
1. Test all navigation links
2. Test active state updates
3. Test mobile navigation (hamburger menu)
4. Test dropdown menus
5. Test breadcrumbs if present
6. Test browser back/forward
7. Test deep linking

### Testing Image Upload
1. Test file selection
2. Test drag and drop
3. Test file size validation
4. Test file type validation
5. Test upload progress indicator
6. Test upload success state
7. Test upload failure handling
8. Test image preview
9. Test image removal/replacement

## MCP Server Usage

### Chrome DevTools MCP (Primary Tool)
Use extensively for all testing:
- `navigate_page` - Load pages for testing
- `take_snapshot` - Get element structure for testing
- `take_screenshot` - Visual verification
- `click`, `hover`, `fill_form` - Interaction testing
- `list_console_messages` - Error detection
- `list_network_requests` - API monitoring
- `resize_page` - Responsive testing
- `press_key` - Keyboard navigation testing
- `evaluate_script` - Custom test scripts
- `wait_for` - Handle async operations
- `emulate_network`, `emulate_cpu` - Throttling tests
- `performance_*` - Performance analysis

### Serena MCP (Code Analysis)
Use for diagnosing issues:
- Locate components causing issues
- Find related code for context
- Understand implementation patterns
- Identify fix locations

### Context7 MCP (Documentation)
Use when fixing issues requires library knowledge:
- Fetch current documentation for libraries
- Understand correct API usage
- Find solutions to common problems

## Best Practices

### Systematic Testing
- Test one thing at a time
- Document findings as you go
- Prioritize issues by severity
- Retest after each fix

### Error Detection
- Check console frequently
- Monitor network tab continuously
- Look for patterns in errors
- Test edge cases and error scenarios

### Accessibility
- Use keyboard-only navigation
- Review accessibility tree
- Check for proper ARIA labels
- Ensure all functionality accessible

### Performance
- Test on slower connections
- Monitor resource usage
- Check for memory leaks
- Optimize images and assets

### Responsive Testing
- Test all breakpoints systematically
- Verify touch targets on mobile
- Check orientation changes
- Test on actual devices when possible

## Issue Fixing Guidelines

### When Fixing Issues

**Don't:**
- Make assumptions without verification
- Fix multiple issues in one change
- Skip retesting after fixes
- Ignore warnings or minor issues

**Do:**
- Understand root cause before fixing
- Make minimal, targeted changes
- Test thoroughly after each fix
- Document what was fixed and why
- Follow project conventions
- Add error handling and validation
- Consider edge cases

### Common Issue Patterns

**Console Errors:**
- Often related to missing null checks
- Can be async timing issues
- Check prop types and data structure
- Verify API response format

**Network Issues:**
- Check URL construction
- Verify authentication tokens
- Check request/response format
- Add proper error handling

**Visual Issues:**
- Check CSS specificity
- Verify Tailwind classes
- Check responsive utilities
- Review z-index stacking

**Performance Issues:**
- Add memoization where needed
- Implement code splitting
- Optimize images
- Throttle/debounce events

## Integration with Other Skills

### After UI Development Skill
This skill runs immediately after UI development is complete. The developer skill creates the implementation, this skill validates it.

### Before Code Review Skill
This skill ensures functional correctness and error-free operation. After testing passes, the code review skill checks code quality and best practices.

### Workflow Integration
1. UI Developer Skill → Implements component
2. **UI Tester Skill** → Tests and fixes issues
3. Code Review Skill → Reviews code quality

## Completion Criteria

Testing is complete when:
1. All P0 and P1 issues are resolved
2. No console errors or warnings present
3. All network requests succeed
4. All interactive elements function correctly
5. Responsive behavior works at all breakpoints
6. Accessibility requirements met
7. Performance is acceptable
8. Loading and error states handled
9. Component is production-ready
10. Ready for code review
