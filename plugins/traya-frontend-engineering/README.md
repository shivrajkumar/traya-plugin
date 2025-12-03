# Traya Frontend Engineering Plugin

AI-powered frontend development workflow with compounding engineering principles. This plugin provides specialized agents, skills, and commands for building high-quality React and Next.js web applications that get smarter with every use.

## Overview

The Traya Frontend Engineering plugin brings comprehensive frontend development capabilities to Claude Code. It includes 16 specialized AI agents, 4 workflow skills, and 7 commands that leverage 5 bundled MCP servers to provide end-to-end support for React and Next.js development.

**Philosophy: Compounding Engineering**
Each unit of engineering work should make subsequent units of work easier—not harder.

## Components

### 16 Specialized Agents

**Core Development (4 agents):**
- `frontend-developer` - React and Next.js component development with modern patterns
- `typescript-reviewer` - TypeScript code review with web-specific type safety
- `architecture-strategist` - Web application architecture and design decisions
- `best-practices-researcher` - Research React/Next.js community best practices

**Specialized Development (4 agents):**
- `ui-ux-designer` - UI/UX design and user experience optimization
- `pattern-recognition-specialist` - Identify design patterns and anti-patterns
- `repo-research-analyst` - Repository analysis and codebase research
- `framework-docs-researcher` - React, Next.js, and library documentation research

**Quality & Testing (3 agents):**
- `performance-oracle` - Web performance optimization and analysis
- `test-automator` - Automated testing setup and implementation
- `security-sentinel` - Web security auditing and vulnerability assessment

**Developer Experience (3 agents):**
- `code-simplicity-reviewer` - Code simplicity and maintainability review
- `pr-comment-resolver` - Pull request comment resolution and code improvements
- `git-history-analyzer` - Git history analysis and code evolution tracking

**Workflow & Knowledge (2 agents):**
- `feedback-codifier` - Code review feedback capture and improvement
- `traya-style-editor` - Traya-specific style and content editing

### 4 Workflow Skills

1. **ui-developer** - Complete UI development workflow
   - Figma design extraction and analysis
   - Codebase pattern analysis with Serena
   - Component implementation with React/Next.js
   - Visual verification with Chrome DevTools
   - Iterative refinement until pixel-perfect

2. **api-integrator** - Comprehensive API integration
   - Postman API testing and validation
   - API service layer implementation
   - Data fetching and state management
   - Error handling and loading states

3. **ui-tester** - End-to-end UI testing workflow
   - Browser automation with Chrome DevTools
   - Visual regression testing
   - Accessibility testing
   - Performance testing

4. **code-reviewer** - Dual-layer code review
   - Task completion verification
   - Technical quality assessment
   - Best practices validation
   - Security and performance review

### 7 Commands

**Workflow Commands:**
- `plan` - Create structured development plans from feature descriptions
- `work` - Execute development work with automatic skill invocation
- `test` - Generate comprehensive test plans and execute automated browser testing
- `review` - Comprehensive multi-agent code review

**Utility Commands:**
- `triage` - Prioritize and organize development tasks
- `resolve_todo_parallel` - Resolve TODO items in parallel
- `generate_command` - Generate custom commands for specific workflows

### 5 Bundled MCP Servers

1. **Figma** - Design extraction and code generation from Figma designs
2. **Chrome DevTools** - Browser automation and testing capabilities
3. **Context7** - Library documentation access and research
4. **Serena** - Semantic code analysis and project indexing
5. **Postman** - API testing and validation

## Quick Start

### 1. Install the Plugin

From Claude Code:
```bash
/plugin marketplace add git@github.com:trayalabs1/traya-plugin.git
/plugin install traya-frontend-engineering
```

### 2. Setup Requirements

- Node.js 18+
- React or Next.js project
- TypeScript (recommended)
- Chrome browser for DevTools integration

### 3. (Optional) Index Your Project for Serena

```bash
uvx --from git+https://github.com/oraios/serena serena project index
```

### 4. Start Building

```bash
# Plan a new feature
/traya-frontend-engineering:plan "User dashboard with analytics charts"

# Execute with automatic skill invocation
/traya-frontend-engineering:work plan-dashboard.md

# Multi-agent code review before merging
/traya-frontend-engineering:review
```

## Development Workflow

### Planning Phase
Use the `plan` command to transform feature ideas into structured plans:
- Break down complex features into manageable tasks
- Identify required components and dependencies
- Consider performance and security implications

### Development Phase
Use the `work` command to execute plans with automatic skill invocation:
- **UI Development**: `ui-developer` skill extracts Figma designs, analyzes patterns, implements components
- **API Integration**: `api-integrator` skill handles service layers and data fetching
- **Testing**: `ui-tester` skill ensures quality through automated testing

### Review Phase
Use the `review` command for comprehensive quality assurance:
- Multiple agents analyze code from different perspectives
- Security, performance, and architecture reviews
- Best practices and maintainability validation

## Example Workflows

### E-commerce Product Page
```bash
# Plan the feature
/traya-frontend-engineering:plan "Product page with image gallery, reviews, and add to cart"

# Execute development
/traya-frontend-engineering:work plan-product-page.md

# Review before merging
/traya-frontend-engineering:review
```

### Analytics Dashboard
```bash
# Plan complex dashboard
/traya-frontend-engineering:plan "Analytics dashboard with charts, filters, and real-time data"

# Automatic development workflow
/traya-frontend-engineering:work plan-analytics-dashboard.md

# Comprehensive review
/traya-frontend-engineering:review
```

## Agent Specializations

### Performance Optimization
- **Performance Oracle**: Bundle size optimization, lazy loading, code splitting
- **Chrome DevTools Integration**: Real-time performance monitoring
- **Best Practices**: Core Web Vitals optimization

### Security Assurance
- **Security Sentinel**: OWASP compliance, XSS/CSRF protection
- **Dependency Scanning**: Vulnerability assessment
- **Secure Coding**: Authentication and authorization patterns

### Code Quality
- **TypeScript Reviewer**: Type safety and best practices
- **Pattern Recognition**: Code smell detection
- **Simplicity Review**: Maintainability and readability

## Integration with Modern Tools

### Figma Integration
- Design extraction with precise measurements
- Component generation with Tailwind CSS
- Style system implementation
- Responsive design patterns

### Testing Frameworks
- Jest and React Testing Library setup
- Cypress for E2E testing
- Visual regression testing
- Accessibility testing automation

### Development Tools
- VS Code integration
- ESLint and Prettier configuration
- Git hooks and CI/CD pipeline
- Performance monitoring

## Best Practices

### Component Development
- Atomic design principles
- Reusable component patterns
- TypeScript interfaces
- Storybook documentation

### Performance
- Code splitting and lazy loading
- Image optimization
- Bundle analysis
- Core Web Vitals

### Security
- Input validation and sanitization
- Authentication patterns
- API security
- Dependency updates

## Support

For issues or questions:
- GitHub Issues: https://github.com/trayalabs1/traya-plugin/issues
- Documentation: https://github.com/trayalabs1/traya-plugin
- Claude Code Documentation: https://docs.claude.com/en/docs/claude-code/plugins

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request
5. Use the `review` command for self-review before submission

## License

See repository root for license information.