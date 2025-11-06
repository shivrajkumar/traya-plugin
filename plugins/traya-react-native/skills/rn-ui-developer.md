---
name: rn-ui-developer
description: Comprehensive UI development workflow for React Native applications. Use this skill when building new screens or components from Figma designs. The skill implements an iterative design-matching process using Figma MCP to extract design specifications, Serena MCP to analyze existing codebase patterns, Context7 MCP for library documentation, and iOS Simulator/Mobile Device MCPs for visual verification on both platforms.
---

# RN UI Developer

## Overview

This skill provides a complete UI development workflow that bridges Figma designs to production-ready React Native code. The workflow uses an iterative design-matching loop: extract design specifications from Figma, analyze existing codebase patterns, implement code following React Native best practices, verify visual accuracy on iOS Simulator and Android devices, and refine until the implementation matches the design perfectly on both platforms.

## Core Workflow

Follow this sequential workflow for all React Native UI development tasks:

### Phase 1: Design Analysis & Planning

**1. Extract Design Specifications**

Use Figma MCP to analyze the design:
```
mcp__figma-dev-mode-mcp-server__get_design_context
mcp__figma-dev-mode-mcp-server__get_variable_defs
mcp__figma-dev-mode-mcp-server__get_screenshot
```

Focus on:
- Component structure and hierarchy
- Colors, typography, spacing
- Platform-specific designs (iOS vs Android)
- Interactive states (pressed, disabled, focused)
- Responsive behavior for different screen sizes
- Animations and transitions
- Design tokens and variables

**2. Analyze Existing Codebase**

Use Serena MCP to understand current patterns:
```
mcp__serena__search_for_pattern - Search for similar components
mcp__serena__get_symbols_overview - Get overview of relevant files
mcp__serena__find_symbol - Find reusable components
mcp__serena__find_referencing_symbols - Understand component usage
```

Focus on:
- Existing component structures and naming conventions
- StyleSheet patterns and theme usage
- Navigation patterns (React Navigation)
- State management patterns (Context, Redux, Zustand)
- Form handling patterns (React Hook Form)
- API integration patterns
- Platform-specific implementations

**3. Gather Library Documentation**

Use Context7 MCP to fetch current documentation:
```
mcp__context7__resolve-library-id - Resolve library names
mcp__context7__get-library-docs - Get latest React Native documentation
```

Priority libraries:
- React Native (core components, APIs)
- React (hooks, context, performance)
- React Navigation (navigation patterns)
- State management library (Redux, Zustand, etc.)
- Form libraries (React Hook Form, Formik)
- Animation libraries (Reanimated, Animated API)

**4. Determine Component Architecture**

Choose the appropriate structure:

**Functional Components with Hooks** - DEFAULT
- Use for all components
- useState for local state
- useEffect for side effects
- useContext for global state
- Custom hooks for reusable logic

**Platform-Specific Components**
- Use Platform.select for conditional styling
- Create .ios.tsx and .android.tsx for platform-specific implementations
- Handle safe area insets properly

### Phase 2: Implementation

**5. Create Component Structure**

Follow React Native conventions:
- Place screens in `screens/` or `features/[feature]/screens/`
- Place reusable components in `components/` or `features/[feature]/components/`
- Use TypeScript for type safety
- Follow existing naming conventions from codebase

**6. Implement with Best Practices**

Code quality standards:
- **Component Structure**: Functional components with hooks
- **Type Safety**: TypeScript interfaces for all props
- **State Management**: Appropriate state solution for complexity
- **Styling**: StyleSheet.create for performance
- **Navigation**: Type-safe React Navigation
- **Accessibility**: Proper accessibility props
- **Performance**: FlatList for lists, memoization where needed
- **Platform Support**: Test on both iOS and Android

**7. Integrate with Existing Systems**

Connect to app infrastructure:
- Navigation: Integrate with React Navigation stack/tabs
- State: Connect to global state if needed
- API: Use existing API service patterns
- Theme: Use app theme and design tokens
- Analytics: Add analytics tracking
- Error Handling: Use app error boundaries

### Phase 3: Visual Verification

**8. Test on iOS Simulator**

Use iOS Simulator MCP for verification:
```
mcp__ios-simulator__open_simulator
mcp__ios-simulator__launch_app
mcp__ios-simulator__take_screenshot
mcp__ios-simulator__ui_describe_all
mcp__ios-simulator__ui_tap
```

Verify:
- Visual accuracy matches Figma design
- Safe area insets handled correctly
- iOS-specific shadows and blur effects
- Navigation transitions work smoothly
- Touch targets are adequate (44x44 minimum)
- Text scales properly
- Animations run at 60 FPS

**9. Test on Android Device**

Use Mobile Device MCP for verification:
```
mcp__mobile-device__mobile_list_available_devices
mcp__mobile-device__mobile_launch_app
mcp__mobile-device__mobile_take_screenshot
mcp__mobile-device__mobile_list_elements_on_screen
mcp__mobile-device__mobile_click_on_screen_at_coordinates
```

Verify:
- Visual accuracy matches Figma design
- Android-specific elevation and ripple effects
- Material Design guidelines followed where appropriate
- Back button behavior correct
- Touch targets are adequate (48x48 minimum)
- Text scales properly
- Animations run smoothly

**10. Cross-Platform Consistency Check**

Compare iOS and Android:
- Screenshots from both platforms side-by-side
- Identify intentional platform differences
- Ensure functional parity
- Verify navigation behavior on both
- Test orientation changes
- Test different device sizes

### Phase 4: Refinement & Iteration

**11. Refine Implementation**

Iteratively improve based on findings:
- Adjust spacing, colors, typography to match design exactly
- Fix platform-specific issues
- Optimize performance (FPS, memory, bundle size)
- Improve accessibility
- Enhance error handling
- Add loading and empty states

**12. Code Quality Review**

Review code against standards:
- TypeScript types complete and correct
- No unnecessary re-renders
- FlatList used for lists
- Platform-specific code properly structured
- Memoization applied where beneficial
- Error boundaries in place
- Accessibility props complete

**13. Performance Optimization**

Ensure smooth performance:
- Profile with React DevTools Profiler
- Check FPS during interactions
- Minimize bridge calls to native
- Optimize images with proper sizing
- Lazy load heavy components
- Use getItemLayout for FlatList with fixed heights

### Phase 5: Documentation & Handoff

**14. Document Component**

Create comprehensive documentation:
- Component purpose and usage
- Props interface with descriptions
- Example usage
- Platform-specific notes
- Known issues or limitations
- Screenshots from both platforms

**15. Integration Testing**

Verify integration:
- Component works in app context
- Navigation flows correctly
- State management integrates properly
- API calls work as expected
- Error states display correctly
- Loading states work properly

## MCP Server Usage Patterns

### Figma MCP
```typescript
// Extract design specifications
mcp__figma-dev-mode-mcp-server__get_design_context({ nodeId: "123:456" })

// Get design variables (colors, spacing, etc.)
mcp__figma-dev-mode-mcp-server__get_variable_defs({ nodeId: "123:456" })

// Get screenshot for reference
mcp__figma-dev-mode-mcp-server__get_screenshot({ nodeId: "123:456" })
```

### Serena MCP
```typescript
// Search for similar components
mcp__serena__search_for_pattern({
  substring_pattern: "Button|Pressable",
  restrict_search_to_code_files: true
})

// Get component overview
mcp__serena__get_symbols_overview({
  relative_path: "components/Button.tsx"
})

// Find component definition
mcp__serena__find_symbol({
  name_path: "Button",
  relative_path: "components/Button.tsx",
  include_body: true
})
```

### iOS Simulator MCP
```typescript
// Launch app
mcp__ios-simulator__launch_app({
  bundle_id: "com.myapp",
  terminate_running: true
})

// Take screenshot
mcp__ios-simulator__take_screenshot()

// Interact with UI
mcp__ios-simulator__ui_tap({ x: 100, y: 200 })
```

### Mobile Device MCP
```typescript
// List devices
mcp__mobile-device__mobile_list_available_devices()

// Launch app
mcp__mobile-device__mobile_launch_app({
  device: "emulator-5554",
  packageName: "com.myapp"
})

// Take screenshot
mcp__mobile-device__mobile_take_screenshot({ device: "emulator-5554" })
```

### Context7 MCP
```typescript
// Resolve library ID
mcp__context7__resolve-library-id({ libraryName: "react-native" })

// Get documentation
mcp__context7__get-library-docs({
  context7CompatibleLibraryID: "/facebook/react-native",
  topic: "components"
})
```

## Best Practices

1. **Start with Design Analysis**: Always extract complete design specifications before coding
2. **Follow Existing Patterns**: Use Serena to identify and follow codebase conventions
3. **Type Everything**: Complete TypeScript interfaces for all props and state
4. **Test on Both Platforms**: Verify on iOS Simulator AND Android device
5. **Iterate Visually**: Take screenshots, compare with design, refine
6. **Performance First**: Profile early, optimize list rendering
7. **Accessibility Always**: Include accessibility props from the start
8. **Document Platform Differences**: Note intentional iOS vs Android variations
9. **Use StyleSheet.create**: Never use inline styles
10. **Verify Safe Areas**: Test on devices with notches/home indicators

## Common Patterns

### Screen Component
```typescript
// screens/ProfileScreen.tsx
import React, { useState, useEffect } from 'react';
import { View, Text, StyleSheet, ScrollView } from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { useNavigation } from '@react-navigation/native';

import { Header } from '@/components/Header';
import { ProfileCard } from '@/components/ProfileCard';
import { useUser } from '@/hooks/useUser';

export const ProfileScreen = () => {
  const insets = useSafeAreaInsets();
  const navigation = useNavigation();
  const { user, loading } = useUser();

  if (loading) return <LoadingSpinner />;

  return (
    <View style={[styles.container, { paddingTop: insets.top }]}>
      <Header title="Profile" />
      <ScrollView style={styles.content}>
        <ProfileCard user={user} />
      </ScrollView>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#FFFFFF',
  },
  content: {
    flex: 1,
    padding: 16,
  },
});
```

### Reusable Component
```typescript
// components/Button.tsx
import React from 'react';
import { TouchableOpacity, Text, StyleSheet, ActivityIndicator, StyleProp, ViewStyle } from 'react-native';

interface ButtonProps {
  title: string;
  onPress: () => void;
  disabled?: boolean;
  loading?: boolean;
  variant?: 'primary' | 'secondary';
  style?: StyleProp<ViewStyle>;
}

export const Button: React.FC<ButtonProps> = ({
  title,
  onPress,
  disabled = false,
  loading = false,
  variant = 'primary',
  style,
}) => {
  return (
    <TouchableOpacity
      style={[
        styles.button,
        variant === 'primary' ? styles.primary : styles.secondary,
        (disabled || loading) && styles.disabled,
        style,
      ]}
      onPress={onPress}
      disabled={disabled || loading}
      accessibilityRole="button"
      accessibilityLabel={title}
      accessibilityState={{ disabled: disabled || loading, busy: loading }}
    >
      {loading ? (
        <ActivityIndicator color="#FFFFFF" />
      ) : (
        <Text style={styles.text}>{title}</Text>
      )}
    </TouchableOpacity>
  );
};

const styles = StyleSheet.create({
  button: {
    padding: 16,
    borderRadius: 8,
    alignItems: 'center',
    justifyContent: 'center',
    minHeight: 48,
  },
  primary: {
    backgroundColor: '#007AFF',
  },
  secondary: {
    backgroundColor: 'transparent',
    borderWidth: 1,
    borderColor: '#007AFF',
  },
  disabled: {
    opacity: 0.5,
  },
  text: {
    fontSize: 16,
    fontWeight: '600',
    color: '#FFFFFF',
  },
});
```

## Troubleshooting

### Design Doesn't Match
- Take screenshots on both platforms
- Compare with Figma pixel-by-pixel
- Adjust spacing, colors, typography
- Check for platform-specific differences

### Performance Issues
- Profile with React DevTools
- Check if using FlatList for lists
- Verify memoization is applied
- Minimize bridge calls

### Visual Inconsistencies
- Test on multiple device sizes
- Check safe area insets
- Verify platform-specific code
- Test in both orientations

## Completion Criteria

UI development is complete when:

1. ✅ Component visually matches Figma design on both iOS and Android
2. ✅ All interactive states work correctly (pressed, disabled, focused)
3. ✅ Navigation integration is complete and type-safe
4. ✅ TypeScript types are complete and correct
5. ✅ Accessibility props are implemented
6. ✅ Performance is optimized (60 FPS, minimal re-renders)
7. ✅ Platform-specific differences are intentional and documented
8. ✅ Error and loading states are handled
9. ✅ Component is tested on both platforms
10. ✅ Code follows existing codebase patterns

Success is achieved when the component provides an excellent user experience on both iOS and Android, matches the design vision, and integrates seamlessly with the existing application architecture.
