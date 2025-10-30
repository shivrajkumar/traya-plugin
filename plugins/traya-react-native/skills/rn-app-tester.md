---
name: rn-app-tester
description: Comprehensive testing and validation workflow for React Native applications. Use this skill after UI development and API integration are complete to perform functional testing, visual regression testing, performance analysis, accessibility auditing, and platform-specific behavior validation on both iOS and Android using iOS Simulator and Mobile Device MCPs.
---

# RN App Tester

## Overview

This skill provides comprehensive testing and validation for React Native applications. The workflow includes functional testing, visual verification, performance analysis, accessibility auditing, network condition testing, and platform-specific behavior validation on both iOS Simulator and Android devices.

## Core Workflow

### Phase 1: Functional Testing

**1. Test User Flows on iOS**

Use iOS Simulator MCP for functional testing:
```
mcp__ios-simulator__launch_app
mcp__ios-simulator__ui_describe_all
mcp__ios-simulator__ui_tap
mcp__ios-simulator__ui_type
mcp__ios-simulator__ui_swipe
```

Test scenarios:
- Login/logout flow
- Navigation between screens
- Form submissions
- Data CRUD operations
- Search functionality
- Filter and sort operations
- Pull-to-refresh

**2. Test User Flows on Android**

Use Mobile Device MCP for functional testing:
```
mcp__mobile-device__mobile_launch_app
mcp__mobile-device__mobile_list_elements_on_screen
mcp__mobile-device__mobile_click_on_screen_at_coordinates
mcp__mobile-device__mobile_type_keys
mcp__mobile-device__mobile_swipe_on_screen
mcp__mobile-device__mobile_press_button
```

Test same scenarios as iOS plus:
- Back button behavior
- Hardware button interactions
- Deep link handling

**3. Cross-Platform Parity Check**

Verify functional consistency:
- Same features work on both platforms
- Navigation patterns are consistent
- Data persistence works identically
- Error handling is uniform
- Performance is comparable

### Phase 2: Visual Regression Testing

**4. Capture Screenshots**

iOS Simulator:
```
mcp__ios-simulator__take_screenshot
```

Android Device:
```
mcp__mobile-device__mobile_take_screenshot
```

Capture:
- All key screens
- Different states (empty, loading, error, success)
- Different data scenarios
- Modal dialogs
- Form validation states

**5. Compare with Design**

Visual verification:
- Compare screenshots with Figma designs
- Check spacing, colors, typography
- Verify platform-specific designs
- Check responsive behavior
- Verify safe area handling

**6. Test Different Screen Sizes**

iOS devices:
- iPhone SE (small)
- iPhone 14 (standard)
- iPhone 14 Pro Max (large)
- iPad (tablet)

Android devices:
- Small phone (5.5")
- Standard phone (6.1")
- Large phone (6.7")
- Tablet (10")

### Phase 3: Performance Testing

**7. Monitor Frame Rate**

Check 60 FPS performance:
- List scrolling smoothness
- Animation performance
- Screen transitions
- Touch responsiveness
- Heavy operations (image loading, data processing)

**8. Memory Usage**

Monitor memory consumption:
- Baseline memory usage
- Memory during navigation
- Memory after data fetching
- Memory leak detection
- Background memory usage

**9. Bundle Size & Startup Time**

Measure app performance:
- Bundle size (iOS/Android)
- Cold start time
- Warm start time
- Time to interactive
- Screen load times

### Phase 4: Accessibility Testing

**10. Screen Reader Testing**

Test with VoiceOver (iOS):
```
// Enable VoiceOver on iOS Simulator
mcp__ios-simulator__ui_describe_all - Check accessibility labels
```

Test with TalkBack (Android):
```
// Enable TalkBack on Android device
mcp__mobile-device__mobile_list_elements_on_screen - Check accessibility
```

Verify:
- All interactive elements have labels
- Labels are descriptive
- Navigation is logical
- Forms are properly labeled
- Errors are announced
- Dynamic content updates are announced

**11. Touch Target Sizes**

Verify minimum touch targets:
- iOS: 44x44 points minimum
- Android: 48x48 dp minimum
- Check all buttons, links, inputs
- Test with finger (not precise taps)

**12. Color Contrast**

Check WCAG AA compliance:
- Text contrast (4.5:1 minimum)
- UI elements contrast
- Test with color blindness simulators
- Verify UI doesn't rely solely on color

### Phase 5: Network Condition Testing

**13. Offline Behavior**

Test without network:
- App launches offline
- Cached data displays
- Offline indicators shown
- Queue mutations for later
- Sync when online returns

**14. Slow Network**

Test with poor connectivity:
- Loading states display
- Timeouts handled gracefully
- Retry mechanisms work
- User feedback provided
- No hanging states

**15. Network Transitions**

Test connectivity changes:
- Online → Offline transition
- Offline → Online transition
- Queued requests execute
- UI updates correctly
- No data loss

### Phase 6: Platform-Specific Testing

**16. iOS-Specific Behaviors**

Test iOS features:
```
mcp__ios-simulator__ui_swipe - Test gestures
```

Verify:
- Safe area insets (notch, home indicator)
- iOS shadows and blur effects
- Swipe-back gesture
- Pull-to-refresh
- Keyboard behavior
- Modal presentation styles

**17. Android-Specific Behaviors**

Test Android features:
```
mcp__mobile-device__mobile_press_button - Test hardware buttons
mcp__mobile-device__mobile_set_orientation - Test rotation
```

Verify:
- Back button behavior
- Material Design elevation
- Ripple effects
- Navigation drawer (if applicable)
- Keyboard behavior
- Deep link handling
- Rotation behavior

### Phase 7: Edge Cases & Error Handling

**18. Empty States**

Test with no data:
- Empty lists
- No search results
- No network
- First-time user experience

**19. Error States**

Test error handling:
- API failures (4xx, 5xx)
- Network errors
- Invalid data
- Form validation errors
- Permission denied errors

**20. Boundary Conditions**

Test edge cases:
- Maximum data scenarios (1000+ items)
- Long text strings
- Special characters
- Different languages/locales
- Date/time edge cases
- Timezone differences

### Phase 8: Regression Testing

**21. Automated Test Suite**

Run automated tests:
- Unit tests (Jest)
- Integration tests
- Component tests (Testing Library)
- E2E tests (Detox if setup)

**22. Manual Smoke Testing**

Quick manual verification:
- App launches
- Login works
- Main features functional
- No console errors
- No visual regressions

## Testing Checklist

### Functional
- [ ] All user flows work on iOS
- [ ] All user flows work on Android
- [ ] Navigation is consistent
- [ ] Forms validate correctly
- [ ] Data persists properly
- [ ] Search/filter/sort works

### Visual
- [ ] Matches Figma designs
- [ ] Responsive on all screen sizes
- [ ] Safe areas handled correctly
- [ ] Platform-specific designs correct
- [ ] No visual glitches
- [ ] Animations smooth (60 FPS)

### Performance
- [ ] Smooth scrolling (60 FPS)
- [ ] Fast startup (< 2s)
- [ ] No memory leaks
- [ ] Bundle size optimized
- [ ] Images optimized
- [ ] No lag during interactions

### Accessibility
- [ ] Screen readers work
- [ ] Touch targets adequate
- [ ] Color contrast sufficient
- [ ] Keyboard navigation works
- [ ] Forms are accessible
- [ ] Errors are announced

### Network
- [ ] Works offline
- [ ] Handles slow network
- [ ] Recovers from errors
- [ ] Shows loading states
- [ ] Provides user feedback

### Platform-Specific
- [ ] iOS gestures work
- [ ] Android back button works
- [ ] Safe areas correct (iOS)
- [ ] Elevation correct (Android)
- [ ] Rotation handled
- [ ] Deep links work

### Edge Cases
- [ ] Empty states handled
- [ ] Error states display
- [ ] Long text truncates
- [ ] Maximum data scenarios
- [ ] Special characters work
- [ ] Different locales supported

## Best Practices

1. **Test on Real Devices**: Use both simulator and physical devices
2. **Test Both Platforms**: iOS and Android verification required
3. **Automate What You Can**: Unit and integration tests
4. **Manual Test Critical Flows**: Login, checkout, core features
5. **Test Network Conditions**: Offline, slow, transitions
6. **Check Accessibility**: VoiceOver, TalkBack, touch targets
7. **Monitor Performance**: FPS, memory, startup time
8. **Test Edge Cases**: Empty, error, boundary conditions
9. **Regression Test**: Verify no existing features broken
10. **Document Issues**: Clear reproduction steps

## Completion Criteria

Testing is complete when:

1. ✅ All functional tests pass on iOS and Android
2. ✅ Visual design matches on both platforms
3. ✅ Performance meets targets (60 FPS, < 2s startup)
4. ✅ Accessibility requirements met
5. ✅ Offline behavior works correctly
6. ✅ Platform-specific features verified
7. ✅ Edge cases handled gracefully
8. ✅ No regressions detected
9. ✅ Automated tests pass
10. ✅ Documentation updated with known issues

Success is achieved when the app provides a reliable, performant, and accessible experience on both iOS and Android, with graceful handling of edge cases and network conditions.
