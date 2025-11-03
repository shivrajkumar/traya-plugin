# TrayaHealth Claude Code Plugin Marketplace

The official Traya Health Claude Code plugin marketplace where engineers from Traya Health share their workflows. Features three production-ready plugins for full-stack development: web (React/Next.js), mobile (iOS/Android), and backend (Node.js/NestJS) - all implementing compounding engineering principles.

## Available Plugins

This marketplace provides three specialized plugins for full-stack development:

### 🌐 traya-compounding-engineering
**For React and Next.js web development**

AI-powered development tools that make each unit of engineering work easier than the last. Transform feature ideas into structured plans, execute them systematically, and ensure quality with multi-agent code reviews.

**Key Features:**
- **Figma to Code:** Extract designs and generate React/Next.js components with Tailwind CSS
- **Multi-Agent Review:** 12+ specialized agents for security, performance, and architecture analysis
- **Automated Testing:** Chrome DevTools integration for visual testing and console debugging
- **Quality Compound:** Each feature improves code patterns for future work
- **Component Count:** 16 agents, 6 commands, 4 skills, 5 MCP servers

**Example Workflow:**
```bash
# Plan feature from description
/traya-compounding-engineering:plan "User dashboard with analytics charts"

# Execute with automatic skill invocation
/traya-compounding-engineering:work plan-dashboard.md

# Multi-agent code review before merging
/traya-compounding-engineering:review
```

**Tech Stack:** React, Next.js, TypeScript, Tailwind CSS, Figma, Chrome DevTools

**Best for:** Web applications, SPAs, server-side rendered apps, static sites

### 📱 traya-react-native
**For iOS and Android mobile development**

Comprehensive React Native development workflow with end-to-end support for building high-quality mobile apps. Automated testing on both iOS Simulator and Android devices ensures platform parity.

**Key Features:**
- **Cross-Platform Testing:** Automatic verification on iOS Simulator AND Android devices
- **Figma to React Native:** Extract designs and generate StyleSheet-based components
- **Platform Specialists:** Dedicated agents for iOS, Android, navigation, state management, and animations
- **Performance Profiling:** FPS monitoring, memory analysis, and startup time optimization
- **Component Count:** 16 agents, 6 commands, 4 skills, 6 MCP servers

**Example Workflow:**
```bash
# Plan mobile feature
/plan "Profile screen with camera upload and form validation"

# Execute with automatic iOS & Android testing
/work plan-profile.md

# Comprehensive review
/review
```

**Tech Stack:** React Native, TypeScript, React Navigation, Reanimated, iOS Simulator MCP, Mobile Device MCP

**Best for:** React Native mobile apps, cross-platform iOS/Android development

### 🔧 traya-backend-engineering
**For Node.js and NestJS backend development**

Build scalable REST and GraphQL APIs with PostgreSQL, MongoDB, and Redis. Comprehensive workflow from API design to deployment with automated testing, security audits, and OpenAPI documentation.

**Key Features:**
- **Automated API Docs:** Generate OpenAPI 3.0/Swagger UI and Postman collections automatically
- **Database Integration:** TypeORM entities, migrations, query optimization, and indexing strategies
- **Security First:** JWT/OAuth2 auth, RBAC, OWASP compliance, and vulnerability scanning
- **Redis Caching:** Cache-aside patterns, session management, and rate limiting
- **Component Count:** 12 agents, 6 commands, 5 skills, 3 MCP servers

**Example Workflow:**
```bash
# Plan API feature
/traya-backend-engineering:plan "User authentication with JWT and RBAC"

# Execute with automatic testing & docs
/traya-backend-engineering:work plan-auth.md

# Security & performance review
/traya-backend-engineering:review
```

**Tech Stack:** NestJS, Express, TypeScript, PostgreSQL, MongoDB, Redis, TypeORM, OpenAPI, Postman

**Best for:** REST APIs, GraphQL APIs, microservices, backend services

---

## Quick Start

### Standard Installation

**Step 1:** Add the marketplace to Claude:

```bash
/plugin marketplace add https://github.com/shivrajkumar/traya-plugin
```

**Step 2:** Install the plugin you need:

```bash
# For web development (React/Next.js)
/plugin install traya-compounding-engineering

# For mobile development (React Native)
/plugin install traya-react-native

# For backend development (Node.js/NestJS)
/plugin install traya-backend-engineering
```

### One-Command Installation
Use the [Claude Plugins CLI](https://claude-plugins.dev) to skip the marketplace setup:

```bash
# For web development
npx claude-plugins install @shivrajkumar/traya-plugin/traya-compounding-engineering

# For mobile development
npx claude-plugins install @shivrajkumar/traya-plugin/traya-react-native

# For backend development
npx claude-plugins install @shivrajkumar/traya-plugin/traya-backend-engineering
```

This automatically adds the marketplace and installs the plugin in a single step.

---

## Choosing the Right Plugin

Not sure which plugin to use? Here's a quick guide:

| Your Project | Recommended Plugin | Why Choose This |
|-------------|-------------------|-----------------|
| **Web application** (React/Next.js SPA, SSR, SSG) | 🌐 `traya-compounding-engineering` | Figma-to-code workflow, Chrome DevTools testing, web-specific optimization, React/Next.js best practices |
| **Mobile app** (iOS + Android cross-platform) | 📱 `traya-react-native` | Automatic testing on iOS Simulator AND Android devices, platform-specific agents, performance profiling (FPS, memory), accessibility auditing |
| **REST/GraphQL API** (Backend services) | 🔧 `traya-backend-engineering` | OpenAPI/Swagger auto-generation, database integration (PostgreSQL/MongoDB/TypeORM), Redis caching, JWT/RBAC security |
| **E-commerce site** (Frontend + API) | 🌐 Web + 🔧 Backend | Web plugin for storefront, Backend plugin for product/order APIs |
| **Full-stack SaaS** (Dashboard + Mobile + API) | 🌐 Web + 📱 Mobile + 🔧 Backend | Complete workflow: Web dashboard, mobile apps for iOS/Android, backend API with database |

**Quick Decision Tree:**
- Building UI? → Is it web or mobile? → Web (🌐) or Mobile (📱)
- Building API? → Backend (🔧)
- Full-stack? → Combine plugins as needed

---

## Plugin Documentation

📚 **Complete documentation for each plugin:**

- **[Web Plugin (React/Next.js)](./plugins/traya-compounding-engineering/README.md)**
  - 16 agents, 6 commands, 4 skills, 5 MCP servers
  - Figma integration, Chrome DevTools, multi-agent code review

- **[Mobile Plugin (iOS/Android)](./plugins/traya-react-native/README.md)**
  - 16 agents, 6 commands, 4 skills, 6 MCP servers
  - iOS Simulator MCP, Mobile Device MCP, cross-platform testing

- **[Backend Plugin (Node.js/NestJS)](./plugins/traya-backend-engineering/README.md)**
  - 12 agents, 6 commands, 5 skills, 3 MCP servers
  - OpenAPI docs, database integration, security-first development

---

## Learn More

- **Compounding engineering philosophy:** [Read Full Story](https://every.to/source-code/my-ai-had-already-fixed-the-code-before-i-saw-it)
