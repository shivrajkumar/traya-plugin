---
name: ui-developer
description: Complete UI development workflow skill for building Next.js pages from Figma designs with automated validation
enabled: true
---

# UI Developer Skill

Comprehensive UI development workflow for transforming Figma designs into production-ready Next.js components with automated validation using Chrome DevTools.

## When to Use

Use this skill when:
- Building new pages from Figma designs
- Converting Figma components to Next.js/React
- Creating pixel-perfect UI implementations
- Need automated visual validation against designs

## Required MCP Servers

- **Figma MCP**: Extract designs and design tokens
- **Chrome DevTools MCP**: Visual validation and testing
- **Context7**: Latest Next.js/React/Tailwind patterns
- **Serena**: Discover reusable components in codebase

## Workflow Steps

### 1. Design Analysis (Planning Phase)

First, analyze the Figma design and plan the implementation:

```markdown
**Step 1: Design Analysis**

I'll analyze the Figma design and plan the implementation.

Coordinating with ui-ux-designer to:
1. Analyze design structure and component breakdown
2. Identify reusable patterns
3. Plan responsive breakpoints
4. Check accessibility requirements

Using Figma MCP to:
- Extract design specifications
- Get design tokens (colors, typography, spacing)
- Identify component mappings

Using Serena to:
- Find existing components we can reuse
- Understand project patterns
```

**Ask the user**:
- Figma design (link or selected in Figma Desktop)
- Target file location (e.g., `app/dashboard/page.tsx`)
- Page context and navigation
- Any elements to exclude

### 2. Code Generation

Generate Next.js code following project patterns:

```markdown
**Step 2: Code Generation**

Using Context7 for:
- Next.js 14 App Router patterns
- Tailwind CSS best practices
- React Server Components usage

Coordinating with frontend-developer for:
- Component implementation
- TypeScript types
- Tailwind styling
- State management (if needed)

Implementation approach:
1. Create page/component structure
2. Extract and apply design tokens
3. Reuse existing components (from Serena)
4. Implement responsive design
5. Add proper TypeScript types
6. Follow project conventions
```

**Generate**:
- Page/component file with TypeScript
- Design tokens file (if needed)
- Import existing reusable components

### 3. Chrome DevTools Validation

Validate implementation against Figma design:

```markdown
**Step 3: Validation with Chrome DevTools**

Please ensure dev server is running at [URL].

Using Chrome DevTools MCP to:
1. Navigate to the page
2. Capture screenshot
3. Compare with Figma design
4. Check console for errors
5. Validate responsive behavior (375px, 768px, 1440px)
6. Run Lighthouse audit
7. Check accessibility

Generating validation report...
```

**Validation Checklist**:
- [ ] Visual match with Figma (colors, typography, spacing)
- [ ] Zero console errors
- [ ] Responsive at all breakpoints
- [ ] Lighthouse score > 90
- [ ] No accessibility violations

### 4. Iterative Fixes

Fix any issues found:

```markdown
**Step 4: Fixing Issues**

Based on validation report:

Critical Issues (must fix):
- [List critical issues]

Important Issues (should fix):
- [List important issues]

Nice to Have:
- [List minor issues]

Fixing each issue and re-validating...
```

**Fix Process**:
1. Identify specific issue
2. Coordinate with appropriate agent (frontend-developer, ui-ux-designer, performance-engineer)
3. Implement fix
4. Re-validate with Chrome DevTools
5. Repeat until all critical issues resolved

### 5. Completion

Final validation and documentation:

```markdown
**Step 5: UI Completion**

Running final validation checklist...

✅ Visual Design
   - Colors match Figma
   - Typography correct
   - Spacing matches design
   - Icons and images optimized

✅ Technical
   - Zero console errors
   - All interactions work
   - Hover/focus states implemented

✅ Performance
   - Lighthouse score: [SCORE]
   - LCP: [TIME]
   - FID: [TIME]
   - CLS: [SCORE]

✅ Responsive
   - Mobile (375px): Perfect
   - Tablet (768px): Perfect
   - Desktop (1440px): Perfect

✅ Accessibility
   - WCAG 2.1 AA compliant
   - Keyboard navigation works
   - Screen reader friendly

**UI is complete and ready for API integration!**

Next steps: Run `/api-workflow` to integrate backend APIs.
```

## Agent Coordination

### Always Coordinate With

- **ui-ux-designer**: Design validation, accessibility, responsive design
- **frontend-developer**: Implementation, code quality
- **performance-engineer**: Performance optimization
- **code-reviewer**: Code quality review before completion

### Optional Coordination

- **backend-architect**: If API integration points need planning
- **security-auditor**: If authentication UI or sensitive data display

## Success Criteria

The skill is successful when:
- ✅ Visual design matches Figma perfectly
- ✅ Zero console errors
- ✅ Lighthouse score > 90
- ✅ Core Web Vitals meet targets (LCP < 2.5s, FID < 100ms, CLS < 0.1)
- ✅ Responsive on all breakpoints
- ✅ WCAG 2.1 AA accessibility compliance
- ✅ Code follows project conventions
- ✅ Ready for API integration

## Common Issues and Solutions

### Issue: Visual doesn't match Figma
**Solution**:
1. Use Chrome DevTools inspect to compare exact measurements
2. Verify design tokens were extracted correctly
3. Check for inherited styles interfering
4. Coordinate with ui-ux-designer for adjustments

### Issue: Console errors
**Solution**:
1. Read full error stack trace
2. Fix immediately (missing imports, undefined variables, etc.)
3. Re-validate after each fix

### Issue: Poor performance
**Solution**:
1. Coordinate with performance-engineer
2. Optimize images (use next/image)
3. Implement code splitting for heavy components
4. Add proper loading states

### Issue: Responsive breaks
**Solution**:
1. Test each breakpoint systematically
2. Use mobile-first Tailwind approach
3. Coordinate with ui-ux-designer for responsive adjustments

## Example Usage

```
User: "I have a dashboard layout selected in Figma. Create the page."