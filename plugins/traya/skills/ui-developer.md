---
name: ui-developer
description: Comprehensive UI development workflow for Next.js applications. Use this skill when building new pages or components from Figma designs. The skill implements an iterative design-matching process using Figma MCP to extract design specifications, Serena MCP to analyze existing codebase patterns, Context7 MCP for library documentation, and Chrome DevTools MCP for visual verification and console error checking. Supports SSR, CSR, and SSG page types with automatic pattern detection.
---

# UI Developer

## Overview

This skill provides a complete UI development workflow that bridges Figma designs to production-ready Next.js code. The workflow uses an iterative design-matching loop: extract design specifications from Figma, analyze existing codebase patterns, implement code following best practices, verify visual accuracy in Chrome, check for console errors, and refine until the implementation matches the design perfectly.

## Core Workflow

Follow this sequential workflow for all UI development tasks:

### Phase 1: Design Analysis & Planning

**1. Extract Design Specifications**

Use Figma MCP to analyze the design:
- Identify all components, layouts, and interactive elements
- Extract colors, typography, spacing, and responsive breakpoints
- Document component hierarchy and relationships
- Note any animations, transitions, or micro-interactions
- Capture design tokens (colors, fonts, shadows, borders)

**2. Analyze Existing Codebase**

Use Serena MCP to understand current patterns:
```
mcp__serena__search_for_pattern - Search for similar components or patterns
mcp__serena__get_symbols_overview - Get overview of relevant files
mcp__serena__find_symbol - Find specific components for reusability
```

Focus on:
- Existing component structures and naming conventions
- Context usage patterns (cart-store, questions-store, CustomerDataContext, AnalyticsContext)
- Tailwind utility patterns and custom classes
- Form validation patterns
- API integration patterns using fetchRequest helper
- Error handling conventions

**3. Gather Library Documentation**

Use Context7 MCP to fetch current documentation:
```
mcp__context7__resolve-library-id - Resolve library names
mcp__context7__get-library-docs - Get latest documentation
```

Priority libraries:
- Next.js (App Router, SSR/CSR/SSG patterns)
- React (hooks, context, server components)
- Tailwind CSS (utility classes, custom configuration)
- Any specific libraries used in the component (forms, animations, etc.)

**4. Determine Rendering Strategy**

Choose the appropriate rendering approach:

**SSR (Server-Side Rendering)** - DEFAULT for most pages
- Use when: Dynamic content, SEO important, personalized data
- Implementation: Server Components (default in App Router)
- Fetch data in server components or with async/await
- Example: Product pages, user dashboards, form pages

**CSR (Client-Side Rendering)** - Use sparingly
- Use when: Highly interactive, real-time updates, client-only features
- Implementation: 'use client' directive + useEffect for data fetching
- Example: Interactive games, real-time chat, complex animations

**SSG (Static Site Generation)** - For static content
- Use when: Content rarely changes, no personalization needed
- Implementation: generateStaticParams() for dynamic routes
- Example: Marketing pages, blog posts, documentation

### Phase 2: Implementation

**5. Create Component Structure**

Follow Next.js 13.5 App Router conventions:
- Place pages in `app/` directory with proper routing
- Place reusable components in `components/` directory
- Use TypeScript for type safety
- Follow existing naming conventions from codebase

**6. Implement with Best Practices**

Code quality standards:
- **Component Structure**: Keep components focused and single-responsibility
- **Type Safety**: Use TypeScript interfaces for props and data structures
- **State Management**: Use Context API for global state, useState/useReducer for local
- **Styling**: Use Tailwind utilities, reference custom theme configuration
- **Accessibility**: Include proper ARIA labels, semantic HTML, keyboard navigation
- **Performance**: Lazy load images, code split heavy components, memoize expensive computations
- **Error Boundaries**: Wrap components with error handling

**7. Integrate with Existing Systems**

Ensure proper integration:
- Wire up context providers if needed (cart, questions, analytics)
- Use fetchRequest helper for API calls with proper error handling
- Integrate MoEngage, Clarity, or GTM tracking as appropriate
- Follow environment configuration patterns from next.config.js
- Use constants from `constants/urls.js` for API endpoints

### Phase 3: Visual Verification Loop

**8. Start Development Server**

```bash
npm run dev
```

**9. Visual Verification with Chrome DevTools**

Use Chrome DevTools MCP to verify implementation:

**Initial Load & Navigation:**
```
mcp__chrome-devtools__navigate_page - Navigate to the component
mcp__chrome-devtools__take_screenshot - Capture current state
mcp__chrome-devtools__take_snapshot - Get accessibility tree
```

**Visual Comparison Process:**
1. Compare screenshot against Figma design side-by-side
2. Check for differences in:
   - Layout and spacing (margins, padding, gaps)
   - Colors and backgrounds
   - Typography (font family, size, weight, line-height)
   - Borders and shadows
   - Component alignment and positioning
   - Responsive behavior at different breakpoints

**Console & Error Checking:**
```
mcp__chrome-devtools__list_console_messages - Check for console errors/warnings
mcp__chrome-devtools__list_network_requests - Verify API calls are working
```

Look for:
- JavaScript errors or warnings
- Failed network requests
- Missing resources (images, fonts, stylesheets)
- Performance warnings
- Accessibility violations

**10. Responsive Testing**

Test at key breakpoints:
```
mcp__chrome-devtools__resize_page - Test different viewport sizes
```

Standard breakpoints (from Tailwind config):
- Mobile: 375px, 428px
- Tablet: 768px, 834px
- Desktop: 1024px, 1280px, 1440px, 1920px

**11. Interactive Element Testing**

Test all interactive elements:
```
mcp__chrome-devtools__click - Test buttons, links, form elements
mcp__chrome-devtools__hover - Verify hover states
mcp__chrome-devtools__fill_form - Test form inputs
mcp__chrome-devtools__evaluate_script - Test JavaScript interactions
```

Verify:
- Button hover and active states
- Form validation and error messages
- Loading states and transitions
- Modal open/close behavior
- Dropdown and navigation interactions

### Phase 4: Iteration & Refinement

**12. Identify Discrepancies**

Document all differences between implementation and design:
- Visual differences (use screenshot comparisons)
- Functionality gaps
- Performance issues
- Console errors or warnings
- Accessibility issues

**13. Fix Issues Iteratively**

For each discrepancy:
1. Determine root cause
2. Implement fix in code
3. Verify fix in Chrome DevTools
4. Confirm no new issues introduced
5. Re-check console for errors

**14. Repeat Until Perfect Match**

Continue the verification loop (steps 9-13) until:
- Visual implementation matches Figma design pixel-perfectly
- All interactive elements work as designed
- No console errors or warnings
- All API calls succeed
- Responsive behavior is correct at all breakpoints
- Performance is acceptable (check Core Web Vitals if needed)

### Phase 5: Final Validation

**15. Comprehensive Testing Checklist**

Before completing, verify:
- [ ] Visual match with Figma at all breakpoints
- [ ] No console errors or warnings
- [ ] All network requests successful
- [ ] Forms validate and submit correctly
- [ ] Context providers integrated properly
- [ ] Analytics tracking implemented
- [ ] Loading states and error states handled
- [ ] Accessibility requirements met (ARIA, keyboard nav)
- [ ] Performance acceptable (no blocking operations)
- [ ] Code follows project conventions and best practices

**16. Documentation**

Document:
- Component purpose and usage
- Props interface and descriptions
- Any special considerations or gotchas
- Integration points (contexts, APIs, etc.)

## MCP Server Usage Patterns

### Figma MCP
- Extract design specifications, colors, typography, spacing
- Get component hierarchies and relationships
- Identify responsive breakpoints and behavior

### Serena MCP
Primary tool for codebase analysis:
- `search_for_pattern` - Find similar implementations
- `get_symbols_overview` - Understand file structure
- `find_symbol` - Locate specific components or utilities
- `find_referencing_symbols` - Understand component usage

### Context7 MCP
Fetch current documentation:
- Resolve library names with `resolve-library-id`
- Get latest docs with `get-library-docs`
- Focus on Next.js, React, Tailwind, and specific libraries

### Chrome DevTools MCP
Visual verification and debugging:
- Navigate and take screenshots for comparison
- List console messages to find errors
- Check network requests for API issues
- Test responsive behavior with resize
- Verify interactive elements with click/hover/fill
- Use snapshots for accessibility tree analysis

## Best Practices

### Code Quality
- Write clean, readable, maintainable code
- Use meaningful variable and function names
- Keep components small and focused
- Extract reusable logic into custom hooks
- Add JSDoc comments for complex functions
- Use TypeScript for type safety

### Performance
- Lazy load images with Next.js Image component
- Code split large components with dynamic imports
- Memoize expensive computations with useMemo
- Debounce/throttle frequent operations
- Minimize bundle size and eliminate unused code

### Accessibility
- Use semantic HTML elements
- Include ARIA labels and roles where needed
- Ensure keyboard navigation works
- Maintain proper heading hierarchy
- Provide alternative text for images
- Ensure sufficient color contrast

### Maintainability
- Follow existing project patterns and conventions
- Keep business logic separate from UI components
- Use composition over inheritance
- Write self-documenting code
- Keep dependencies up to date

## Project-Specific Conventions

For Traya Health codebase:

### File Organization
- Pages: `app/[route]/page.tsx`
- Components: `components/[component-name]/index.tsx`
- Contexts: `context/[context-name].js`
- Helpers: `helpers/[helper-name].js`
- Constants: `constants/[constant-type].js`

### Styling
- Use Tailwind utilities first
- Reference custom theme (male/female color palettes)
- Follow responsive design patterns
- Use custom animations and gradients from config

### State Management
- Use Context API for global state
- Available contexts: cart-store, questions-store, CustomerDataContext, AnalyticsContext
- Follow existing context patterns

### API Integration
- Use `fetchRequest` helper for all API calls
- Reference URLs from `constants/urls.js`
- Handle errors consistently
- Include loading states

### Forms
- Follow questionnaire system patterns
- Include validation
- Handle image uploads properly
- Integrate with analytics tracking

## Common Scenarios

### Creating a New Page
1. Analyze Figma design for the page
2. Check existing page patterns in `app/` directory
3. Determine SSR/CSR/SSG based on data requirements
4. Create page file with proper routing
5. Implement with verification loop
6. Test navigation and integration

### Creating a Reusable Component
1. Extract design specs from Figma
2. Check for similar components in `components/`
3. Identify reusability patterns
4. Create component with proper props interface
5. Test in isolation and in context
6. Document usage

### Implementing a Form
1. Review form flow requirements
2. Check existing form patterns in codebase
3. Integrate with questions-store context
4. Implement validation
5. Wire up API submission
6. Add analytics tracking
7. Test complete flow with Chrome DevTools

### Adding Responsive Behavior
1. Extract responsive specs from Figma
2. Identify breakpoints from Tailwind config
3. Implement mobile-first approach
4. Test at all breakpoints with Chrome DevTools
5. Verify touch interactions on mobile viewports

## Troubleshooting

### Visual Differences from Design
- Use screenshot comparison to identify exact differences
- Check Tailwind config for custom values
- Verify fonts are loaded correctly
- Check for CSS conflicts or specificity issues

### Console Errors
- Use Chrome DevTools to list and analyze errors
- Check network requests for failed API calls
- Verify environment variables are set
- Check for missing dependencies

### Performance Issues
- Check bundle size with `ANALYZE=true npm run build`
- Look for unnecessary re-renders with React DevTools
- Verify images are optimized
- Check for blocking operations

### Context Integration Issues
- Verify provider wraps component properly
- Check context is imported correctly
- Ensure context values are accessed properly
- Test with and without context data

## Completion Criteria

The UI development task is complete when:
1. Implementation visually matches Figma design pixel-perfectly at all breakpoints
2. All interactive elements function as designed
3. No console errors or warnings present
4. All network requests succeed
5. Code follows project best practices and conventions
6. Component is properly integrated with existing systems
7. Documentation is complete
8. Ready for code review and testing skills
