# Traya React Native Plugin

AI-powered React Native development workflow with compounding engineering principles. This plugin provides specialized agents, skills, and commands for building high-quality iOS and Android applications.

## Overview

The Traya React Native plugin brings comprehensive React Native development capabilities to Claude Code. It includes 16 specialized AI agents, 4 workflow skills, and 6 commands that leverage 6 bundled MCP servers to provide end-to-end support for mobile app development.

**Philosophy: Compounding Engineering**
Each unit of engineering work should make subsequent units of work easier—not harder.

## Components

### 16 Specialized Agents

**Core Development (4 agents):**
- `rn-developer` - React Native component development with best practices
- `rn-typescript-reviewer` - TypeScript code review with RN-specific type safety
- `rn-architecture-strategist` - React Native architecture and design decisions
- `rn-best-practices-researcher` - Research RN community best practices

**Specialized Development (5 agents):**
- `rn-navigation-specialist` - React Navigation implementation
- `rn-state-management-expert` - State management (Redux, Zustand, Context)
- `rn-native-module-specialist` - Native iOS/Android module integration
- `rn-styling-expert` - StyleSheet optimization and responsive design
- `rn-animation-specialist` - Reanimated and Animated API implementation

**Quality & Testing (4 agents):**
- `rn-performance-analyzer` - FPS, bundle size, memory optimization
- `rn-testing-specialist` - Jest, Testing Library, Detox E2E tests
- `rn-accessibility-auditor` - VoiceOver/TalkBack compliance
- `rn-security-auditor` - Secure storage, API security, permissions

**Platform Operations (3 agents):**
- `ios-simulator-specialist` - iOS Simulator automation via MCP
- `android-device-specialist` - Android device/emulator automation via MCP
- `rn-pattern-recognition` - Identify patterns and anti-patterns

### 4 Workflow Skills

1. **rn-ui-developer** - Complete UI development workflow
   - Figma design extraction
   - Codebase pattern analysis with Serena
   - Component implementation
   - Visual verification on iOS Simulator and Android devices
   - Iterative refinement until pixel-perfect

2. **rn-api-integrator** - Comprehensive API integration
   - Postman API testing
   - Service layer implementation
   - React Native integration with React Query/SWR
   - End-to-end data flow verification
   - Offline support implementation

3. **rn-app-tester** - Thorough testing and validation
   - Functional testing on both platforms
   - Visual regression testing
   - Performance analysis (FPS, memory, startup time)
   - Accessibility auditing (VoiceOver, TalkBack)
   - Network condition testing

4. **rn-code-reviewer** - Dual-layer code review
   - Task completion verification
   - Technical quality assessment
   - React Native best practices validation
   - Security audit
   - Documentation review

### 6 Commands

- `/plan` - Create structured GitHub issues for React Native features
- `/work` - Execute work plans with automatic skill invocation
- `/review` - Comprehensive code review
- `/triage` - Issue triage and prioritization
- `/resolve_todo_parallel` - Parallel TODO resolution
- `/generate_command` - Create custom commands

## Bundled MCP Servers

The plugin automatically configures 6 MCP servers:

1. **iOS Simulator MCP** - iOS app testing and automation
2. **Mobile Device MCP** - Android device/emulator testing
3. **Figma MCP** - Design extraction from Figma
4. **Postman MCP** - API testing and validation
5. **Context7 MCP** - React Native library documentation
6. **Serena MCP** - Codebase pattern analysis

## Installation

### 1. Install the Plugin

From Claude Code:
```bash
claude /plugin marketplace add https://github.com/trayahealth/traya-plugin
claude /plugin install traya-react-native
```

### 2. Setup Requirements

**iOS Simulator MCP (for iOS testing):**
- macOS with Xcode installed
- iOS Simulator configured

**Mobile Device MCP (for Android testing):**
- Android device connected or emulator running
- ADB configured

**Figma MCP (for design extraction):**
- Figma Desktop App installed
- Designs prepared in Figma

**Postman MCP (for API testing):**
- APIs documented or Postman collections available

**Context7 MCP:**
- Automatically configured (no setup required)

**Serena MCP:**
- Automatically configured
- Optionally index your project:
  ```bash
  uvx --from git+https://github.com/oraios/serena serena project index
  ```

## Usage

### Quick Start Workflow

1. **Plan** your React Native feature:
   ```bash
   claude /plan "Create user profile screen with avatar upload"
   ```

2. **Execute** the plan:
   ```bash
   claude /work path/to/plan.md
   ```

   The `/work` command automatically:
   - Detects task type (UI development, API integration)
   - Invokes appropriate skills (rn-ui-developer → rn-api-integrator → rn-app-tester → rn-code-reviewer)
   - Tests on both iOS and Android
   - Provides iterative refinement until complete

3. **Review** the implementation:
   ```bash
   claude /review
   ```

### Using Individual Agents

Invoke agents directly for specific tasks:

```bash
# Component development
claude agent rn-developer "Create a reusable Button component"

# TypeScript review
claude agent rn-typescript-reviewer "Review ProfileScreen.tsx"

# Performance analysis
claude agent rn-performance-analyzer "Analyze FlatList performance"

# iOS testing
claude agent ios-simulator-specialist "Test login flow on iOS"

# Android testing
claude agent android-device-specialist "Test on Android device"
```

### Using Skills

Skills are automatically invoked by `/work`, but can be used directly:

```bash
# UI development from Figma
claude /skill rn-ui-developer

# API integration
claude /skill rn-api-integrator

# Comprehensive testing
claude /skill rn-app-tester

# Code review
claude /skill rn-code-reviewer
```

## Development Workflow

### Typical Feature Implementation

```bash
# 1. Plan the feature
claude /plan "User authentication with biometric support"

# 2. Execute the plan (automatic skill invocation)
claude /work plan-file.md
# Automatically runs:
# - rn-ui-developer (builds UI, tests on iOS & Android)
# - rn-api-integrator (connects to auth API)
# - rn-app-tester (comprehensive testing)
# - rn-code-reviewer (final validation)

# 3. Review and commit
claude /review
git add .
git commit -m "Add biometric authentication"
```

### Manual Workflow

```bash
# 1. Build UI from Figma
claude agent rn-developer "Create login screen from Figma design node-id: 123:456"

# 2. Integrate API
claude agent rn-api-integrator "Connect login form to /auth/login endpoint"

# 3. Test on iOS
claude agent ios-simulator-specialist "Test login flow on iOS Simulator"

# 4. Test on Android
claude agent android-device-specialist "Test login flow on Android"

# 5. Performance check
claude agent rn-performance-analyzer "Check app performance metrics"

# 6. Accessibility audit
claude agent rn-accessibility-auditor "Audit screen reader support"

# 7. Final review
claude agent rn-code-reviewer "Review all changes"
```

## Key Features

### Automatic Platform Testing
- Every UI component tested on both iOS Simulator and Android devices
- Platform-specific implementations verified
- Visual parity confirmed with screenshots

### Iterative Design Matching
- Extract design from Figma
- Implement React Native components
- Verify visually on both platforms
- Refine until pixel-perfect match

### Comprehensive API Integration
- Test API with Postman first
- Implement type-safe service layer
- Integrate with React Query/SWR
- Verify data flow on both platforms
- Handle offline scenarios

### Quality Assurance
- Automated testing (Jest, Testing Library)
- Performance profiling (FPS, memory, bundle size)
- Accessibility compliance (VoiceOver, TalkBack)
- Security auditing (token storage, permissions)
- Code review with best practices

### Compounding Engineering
- Each skill builds on previous work
- Knowledge captured in codebase patterns
- Quality gates prevent technical debt
- Documentation ensures maintainability

## Best Practices

1. **Start with /plan** - Structure your work before executing
2. **Use /work for automation** - Let skills handle the workflow
3. **Test on Both Platforms** - iOS and Android verification required
4. **Profile Performance** - Ensure 60 FPS and fast startup
5. **Audit Accessibility** - VoiceOver and TalkBack compliance
6. **Review Security** - Proper token storage and permissions
7. **Document Changes** - Update README and component docs
8. **Follow Patterns** - Use Serena to identify existing conventions

## Troubleshooting

### iOS Simulator Issues
```bash
# Check simulator is running
claude agent ios-simulator-specialist "Get booted simulator ID"

# Open simulator
claude agent ios-simulator-specialist "Open iOS Simulator"
```

### Android Device Issues
```bash
# List available devices
claude agent android-device-specialist "List all available Android devices"

# Check device connection
adb devices
```

### MCP Server Issues
```bash
# Check MCP server status
claude /mcp list

# Restart servers if needed
# (MCP servers restart automatically)
```

## Examples

### Example 1: Build Profile Screen

```bash
claude /plan "Create user profile screen with:
- Avatar image with camera upload
- Editable name and email fields
- Settings button
- Logout button
Figma node: 123:456"

claude /work plan-profile-screen.md
```

Result: Complete profile screen with:
- ✅ Pixel-perfect UI matching Figma
- ✅ Camera integration for avatar
- ✅ Form validation
- ✅ API integration
- ✅ Tested on iOS and Android
- ✅ Accessibility compliant
- ✅ Performance optimized

### Example 2: Add Search Feature

```bash
claude agent rn-developer "Add search bar to product list screen with debouncing"
claude agent rn-performance-analyzer "Optimize search performance"
claude agent ios-simulator-specialist "Test search on iOS"
claude agent android-device-specialist "Test search on Android"
```

## Support

For issues or questions:
- GitHub Issues: https://github.com/trayahealth/traya-plugin/issues
- Documentation: https://docs.claude.com/en/docs/claude-code/plugins

## Contributing

Contributions welcome! Follow the compounding engineering principles:
1. Plan → Create clear issue describing the change
2. Delegate → Use AI tools to help implementation
3. Assess → Test on both iOS and Android
4. Codify → Update this README with learnings

## License

MIT License - see LICENSE file for details.

---

**Built with compounding engineering principles by TrayaHealth**

Each unit of engineering work should make subsequent units of work easier—not harder.
