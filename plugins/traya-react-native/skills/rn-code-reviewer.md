---
name: rn-code-reviewer
description: Dual-layer code review workflow for React Native applications. Use this skill after all development and testing are complete to perform comprehensive code review including task completion verification, technical quality assessment, React Native best practices validation, performance optimization review, security audit, and documentation verification using Serena MCP for codebase analysis.
---

# RN Code Reviewer

## Overview

This skill provides comprehensive dual-layer code review for React Native applications. The review process verifies task completion against requirements, evaluates technical quality, ensures React Native best practices, validates TypeScript usage, checks performance optimization, audits security, and verifies documentation completeness.

## Core Workflow

### Layer 1: Task Completion Verification

**1. Review Requirements**

Verify all requirements met:
- Original task/issue requirements
- Acceptance criteria fulfilled
- User stories completed
- Design specifications matched
- API integration requirements
- Performance targets met

**2. Functional Verification**

Confirm functionality:
- Feature works as described
- All user flows complete
- Edge cases handled
- Error states implemented
- Loading states present
- Empty states designed

**3. Platform Parity**

Verify both platforms:
- Feature works on iOS
- Feature works on Android
- Platform differences intentional
- Both platforms tested
- Screenshots captured
- Visual consistency verified

### Layer 2: Technical Quality Assessment

**4. Code Structure Review**

Use Serena MCP to analyze:
```
mcp__serena__find_symbol - Find components/functions
mcp__serena__find_referencing_symbols - Check usage
mcp__serena__search_for_pattern - Find anti-patterns
```

Evaluate:
- Component structure (functional, single-responsibility)
- File organization (feature-based)
- Import organization
- Code duplication
- Separation of concerns
- Component composition

**5. TypeScript Review**

Check type safety:
- No `any` types
- Complete prop interfaces
- Explicit return types
- Type guards used appropriately
- Generic types properly constrained
- Navigation types configured
- Hook types complete

**6. React Native Best Practices**

Verify adherence:
- Functional components with hooks
- FlatList for lists (not ScrollView + map)
- StyleSheet.create used
- Platform.select for platform differences
- Proper memoization (React.memo, useMemo, useCallback)
- Effect cleanup
- SafeAreaView/useSafeAreaInsets
- Accessibility props

**7. Performance Review**

Check optimization:
- FlatList with getItemLayout
- Image optimization
- Memoization applied
- No inline functions in renders
- No unnecessary re-renders
- Bundle size impact
- Memory usage
- Startup time impact

**8. State Management Review**

Evaluate state handling:
- Appropriate state solution used
- State at correct level
- State updates immutable
- Context not overused
- React Query/SWR for server state
- Offline support implemented

**9. API Integration Review**

Verify integration quality:
- Type-safe API calls
- Error handling comprehensive
- Loading states managed
- Request interceptors configured
- Token management secure
- Offline behavior handled
- Network error recovery

**10. Navigation Review**

Check navigation implementation:
- Type-safe navigation
- Navigation param lists complete
- Deep linking configured
- Navigation guards implemented
- Stack navigation correct
- Tab navigation appropriate
- Modal presentation correct

### Layer 3: Security Audit

**11. Sensitive Data Handling**

Verify security:
- No hardcoded secrets/keys
- Tokens stored in Keychain
- No sensitive data in AsyncStorage
- No sensitive data in logs
- Input validation implemented
- API requests use HTTPS
- Certificate pinning (if required)

**12. Code Security**

Check for vulnerabilities:
- No SQL injection risks
- No XSS vulnerabilities
- Deep links validated
- Permissions handled correctly
- Dependencies up to date
- No known security issues

### Layer 4: Testing & Documentation

**13. Test Coverage Review**

Verify testing:
- Unit tests present
- Component tests complete
- Integration tests for critical flows
- Test coverage > 80%
- Edge cases tested
- Error scenarios tested

**14. Documentation Review**

Check documentation:
- Component props documented
- Complex logic explained
- README updated
- API integration documented
- Platform differences noted
- Known issues documented

### Layer 5: Code Quality Metrics

**15. Code Complexity**

Analyze complexity:
- Functions < 50 lines
- Components < 200 lines
- Cyclomatic complexity reasonable
- Nesting depth < 4 levels
- No overly complex logic

**16. Code Consistency**

Verify consistency:
- Naming conventions followed
- File structure matches project
- Import order consistent
- Code style uniform
- Comments style consistent

## Review Checklist

### Task Completion
- [ ] All requirements met
- [ ] Acceptance criteria fulfilled
- [ ] Feature works as described
- [ ] Tested on iOS
- [ ] Tested on Android
- [ ] Edge cases handled

### Code Structure
- [ ] Components well-structured
- [ ] Files properly organized
- [ ] No code duplication
- [ ] Separation of concerns clear
- [ ] Reusable components extracted

### TypeScript
- [ ] No `any` types
- [ ] Prop interfaces complete
- [ ] Return types explicit
- [ ] Navigation types configured
- [ ] No type errors

### React Native Best Practices
- [ ] Functional components used
- [ ] FlatList for lists
- [ ] StyleSheet.create used
- [ ] Memoization applied
- [ ] Effects cleaned up
- [ ] Accessibility props present

### Performance
- [ ] 60 FPS maintained
- [ ] Images optimized
- [ ] No unnecessary re-renders
- [ ] Bundle size acceptable
- [ ] Memory usage reasonable
- [ ] Startup time good

### State Management
- [ ] Appropriate solution used
- [ ] State at correct level
- [ ] Updates immutable
- [ ] Server state handled
- [ ] Offline support implemented

### API Integration
- [ ] Type-safe calls
- [ ] Error handling complete
- [ ] Loading states managed
- [ ] Tokens secured
- [ ] Network errors handled

### Navigation
- [ ] Type-safe navigation
- [ ] Deep linking works
- [ ] Navigation correct
- [ ] Guards implemented

### Security
- [ ] No hardcoded secrets
- [ ] Tokens in Keychain
- [ ] HTTPS used
- [ ] Input validated
- [ ] Dependencies secure

### Testing
- [ ] Unit tests present
- [ ] Component tests complete
- [ ] Coverage > 80%
- [ ] Edge cases tested

### Documentation
- [ ] Components documented
- [ ] README updated
- [ ] API integration documented
- [ ] Known issues noted

## Common Issues to Flag

### Critical Issues (Block Merge)
- Security vulnerabilities
- Hardcoded secrets/tokens
- Type safety violations (any types)
- Performance issues (< 60 FPS)
- Accessibility violations
- Platform-specific bugs

### Major Issues (Fix Before Merge)
- Missing error handling
- No loading states
- Poor TypeScript usage
- Unnecessary re-renders
- Large components (> 200 lines)
- No tests for critical functionality

### Minor Issues (Can Address Later)
- Missing documentation
- Inconsistent naming
- Code complexity
- Minor style violations
- Opportunities for refactoring

## Review Process

1. **Analyze Codebase with Serena**
   - Find all modified files
   - Review component structure
   - Check for anti-patterns
   - Identify code duplication

2. **Run Automated Checks**
   - TypeScript compilation
   - Test suite
   - Linter
   - Code coverage

3. **Manual Code Review**
   - Read through all changes
   - Verify best practices
   - Check for edge cases
   - Assess code quality

4. **Test Verification**
   - Run app on iOS
   - Run app on Android
   - Verify functionality
   - Check performance

5. **Security Audit**
   - Check for secrets
   - Verify secure storage
   - Review permissions
   - Check dependencies

6. **Documentation Check**
   - Verify completeness
   - Check accuracy
   - Ensure clarity

7. **Provide Feedback**
   - List critical issues
   - Note major issues
   - Suggest improvements
   - Highlight good practices

## Completion Criteria

Code review is complete when:

1. ✅ All requirements verified as met
2. ✅ Code follows React Native best practices
3. ✅ TypeScript usage is correct
4. ✅ Performance is optimized
5. ✅ Security issues resolved
6. ✅ Tests are comprehensive
7. ✅ Documentation is complete
8. ✅ No critical or major issues
9. ✅ Platform parity verified
10. ✅ Feedback provided to developer

Success is achieved when the code is production-ready, maintainable, performant, secure, and provides excellent user experience on both iOS and Android.
