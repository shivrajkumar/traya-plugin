# TrayaHealth Marketplace - Claude Code Plugin Marketplace

This repository is a Claude Code plugin marketplace that distributes TrayaHealth plugins to developers. It currently features two production-ready plugins: `traya-compounding-engineering` for React and Next.js web development, and `traya-react-native` for iOS and Android mobile development.

## Repository Structure

```
traya-plugin/
├── .claude-plugin/
│   └── marketplace.json                    # Marketplace catalog (lists both plugins)
└── plugins/
    ├── traya-compounding-engineering/      # Web development plugin (React/Next.js)
    │   ├── .claude-plugin/
    │   │   └── plugin.json                 # Plugin metadata
    │   ├── agents/                         # 16 specialized AI agents
    │   ├── commands/                       # 6 slash commands
    │   ├── skills/                         # 4 specialized skills
    │   ├── .mcp.json                       # 5 bundled MCP servers
    │   └── README.md                       # Plugin documentation
    └── traya-react-native/                 # Mobile development plugin (iOS/Android)
        ├── .claude-plugin/
        │   └── plugin.json                 # Plugin metadata
        ├── agents/                         # 16 specialized AI agents
        ├── commands/                       # 6 slash commands
        ├── skills/                         # 4 specialized skills
        ├── .mcp.json                       # 6 bundled MCP servers
        └── README.md                       # Plugin documentation
```

## Philosophy: Compounding Engineering

**Each unit of engineering work should make subsequent units of work easier—not harder.**

When working on this repository, follow the compounding engineering process:

1. **Plan** → Understand the change needed and its impact
2. **Delegate** → Use AI tools to help with implementation
3. **Assess** → Verify changes work as expected
4. **Codify** → Update this CLAUDE.md with learnings

## Working with This Repository

### Adding a New Plugin

1. Create plugin directory: `plugins/new-plugin-name/`
2. Add plugin structure:
   ```
   plugins/new-plugin-name/
   ├── .claude-plugin/plugin.json
   ├── agents/
   ├── commands/
   └── README.md
   ```
3. Update `.claude-plugin/marketplace.json` to include the new plugin
4. Test locally before committing

### Updating a Plugin

When agents or commands are added/removed in either plugin, follow these steps:

1. **Scan for actual files:**

   ```bash
   # For traya-compounding-engineering
   ls plugins/traya-compounding-engineering/agents/*.md | wc -l
   ls plugins/traya-compounding-engineering/commands/*.md | wc -l

   # For traya-react-native
   ls plugins/traya-react-native/agents/*.md | wc -l
   ls plugins/traya-react-native/commands/*.md | wc -l
   ```

2. **Update plugin.json** at `plugins/{plugin-name}/.claude-plugin/plugin.json`:

   - Update `components.agents` count
   - Update `components.commands` count
   - Update `agents` object to reflect which agents exist
   - Update `commands` object to reflect which commands exist

3. **Update plugin README** at `plugins/{plugin-name}/README.md`:

   - Update agent/command counts in the intro
   - Update the agent/command lists to match what exists

4. **Update marketplace.json** at `.claude-plugin/marketplace.json`:
   - Usually doesn't need changes unless changing plugin description/tags
   - Only update if modifying plugin-level metadata (description, version, tags)

### Marketplace.json Structure

The marketplace.json follows the official Claude Code spec:

```json
{
  "name": "marketplace-identifier",
  "owner": {
    "name": "Owner Name",
    "url": "https://github.com/owner"
  },
  "metadata": {
    "description": "Marketplace description",
    "version": "1.0.0"
  },
  "plugins": [
    {
      "name": "plugin-name",
      "description": "Plugin description",
      "version": "1.0.0",
      "author": { ... },
      "homepage": "https://...",
      "tags": ["tag1", "tag2"],
      "source": "./plugins/plugin-name"
    }
  ]
}
```

**Only include fields that are in the official spec.** Do not add custom fields like:

- `downloads`, `stars`, `rating` (display-only)
- `categories`, `featured_plugins`, `trending` (not in spec)
- `type`, `verified`, `featured` (not in spec)

### Plugin.json Structure

Each plugin has its own plugin.json with detailed metadata:

```json
{
  "name": "plugin-name",
  "version": "1.0.0",
  "description": "Plugin description",
  "author": { ... },
  "keywords": ["keyword1", "keyword2"],
  "components": {
    "agents": 16,
    "commands": 6,
    "skills": 4
  },
  "agents": {
    "category": [
      {
        "name": "agent-name",
        "description": "Agent description",
        "use_cases": ["use-case-1", "use-case-2"]
      }
    ]
  },
  "commands": {
    "category": ["command1", "command2"]
  }
}
```

## Bundled MCP Servers

The Traya plugin bundles 5 MCP servers in `.mcp.json` that start automatically when the plugin is enabled:

1. **Figma** - Design extraction and code generation from Figma designs
2. **Chrome DevTools** - Browser automation and testing
3. **Context7** - Library documentation access
4. **Serena** - Semantic code analysis
5. **Postman** - API testing and validation

### MCP Configuration File

The `.mcp.json` file at the plugin root follows the standard MCP server format:

```json
{
  "mcpServers": {
    "figma": {
      "command": "curl",
      "args": ["-X", "POST", "http://127.0.0.1:3845/mcp"],
      "env": {},
      "disabled": false
    },
    "chrome-devtools": {
      "command": "npx",
      "args": ["@executeautomation/chrome-devtools-mcp"],
      "env": {}
    },
    "context7": {
      "command": "npx",
      "args": ["-y", "@upstash/context7-mcp"],
      "env": {}
    },
    "serena": {
      "command": "uvx",
      "args": [
        "--from", "git+https://github.com/oraios/serena",
        "serena", "start-mcp-server",
        "--context", "ide-assistant",
        "--project", "."
      ],
      "env": {}
    },
    "postman": {
      "command": "npx",
      "args": ["@postman/mcp-server"],
      "env": {}
    }
  }
}
```

### Adding New MCP Servers

To add a new MCP server to the plugin:

1. Edit `plugins/traya/.mcp.json`
2. Add new server to the `mcpServers` object:
   ```json
   "server-name": {
     "command": "npx",
     "args": ["package-name"],
     "env": {
       "ENV_VAR": "value"
     }
   }
   ```
3. Use `${CLAUDE_PLUGIN_ROOT}` for plugin-relative paths
4. Update README.md with server documentation
5. Test the server integration

### How Bundled MCP Servers Work

- **Automatic startup**: Servers start when the plugin is enabled
- **Standard integration**: Servers appear as standard MCP tools in Claude's toolkit
- **No manual installation**: Users don't need to run separate install commands
- **Plugin isolation**: Server configs are scoped to the plugin

## Testing Changes

### Test Locally

1. Install the marketplace locally:

   ```bash
   claude /plugin marketplace add /Users/yourusername/traya-plugin
   ```

2. Install the plugin you want to test:

   ```bash
   # For web plugin
   claude /plugin install traya-compounding-engineering

   # For mobile plugin
   claude /plugin install traya-react-native
   ```

3. Bundled MCP servers start automatically

4. (Optional) Index your project for Serena:
   ```bash
   uvx --from git+https://github.com/oraios/serena serena project index
   ```

5. Test agents and commands:

   **For traya-compounding-engineering:**
   ```bash
   claude /traya-compounding-engineering:review
   claude agent typescript-reviewer "test message"
   ```

   **For traya-react-native:**
   ```bash
   claude /plan "test feature"
   claude agent rn-developer "test message"
   ```

### Validate JSON

Before committing, ensure JSON files are valid:

```bash
# Marketplace catalog
cat .claude-plugin/marketplace.json | jq .

# Web plugin
cat plugins/traya-compounding-engineering/.claude-plugin/plugin.json | jq .
cat plugins/traya-compounding-engineering/.mcp.json | jq .

# Mobile plugin
cat plugins/traya-react-native/.claude-plugin/plugin.json | jq .
cat plugins/traya-react-native/.mcp.json | jq .
```

## Common Tasks

### Adding a New Agent

1. Create `plugins/{plugin-name}/agents/new-agent.md`
2. Update `plugins/{plugin-name}/.claude-plugin/plugin.json` agent count and agent list
3. Update `plugins/{plugin-name}/README.md` agent list
4. Test with `claude agent new-agent "test"`

**Example for traya-compounding-engineering:**
```bash
# Create agent file
touch plugins/traya-compounding-engineering/agents/new-agent.md
# Update counts and test
claude agent typescript-reviewer "test"
```

**Example for traya-react-native:**
```bash
# Create agent file
touch plugins/traya-react-native/agents/rn-new-agent.md
# Update counts and test
claude agent rn-developer "test"
```

### Adding a New Command

1. Create `plugins/{plugin-name}/commands/new-command.md`
2. Update `plugins/{plugin-name}/.claude-plugin/plugin.json` command count and command list
3. Update `plugins/{plugin-name}/README.md` command list
4. Test with `claude /{plugin-namespace}:new-command`

**The process is the same for both plugins**, just use the appropriate plugin directory.

### Adding a New Skill

1. Create `plugins/{plugin-name}/skills/new-skill.md`
2. Update `plugins/{plugin-name}/.claude-plugin/plugin.json` skill count
3. Update `plugins/{plugin-name}/README.md` skill list
4. Consider integrating into the `/work` command if it fits the workflow
5. Test with `claude /skill new-skill` or through `/work` integration

**The process is the same for both plugins**, just use the appropriate plugin directory.

### How Skill Integration Works

Both plugins use the same pattern: Skills are automatically invoked by the `/work` command based on task detection.

**Architecture (same for both plugins):**
```
/{plugin}:work command
    ↓
Analyzes work document
    ↓
Detects task type (UI development, API integration, other)
    ↓
Invokes appropriate skills automatically:
    - UI tasks: *-ui-developer → *-api-integrator → *-app-tester → *-code-reviewer
    - API tasks: *-api-integrator → *-app-tester → *-code-reviewer
    - Other: Manual execution loop
```

**Implementation Location:**
- Skills are defined in `plugins/{plugin-name}/skills/*.md`
- Integration logic is in `plugins/{plugin-name}/commands/work.md` Phase 3
- Skills leverage bundled MCP servers automatically

**Examples:**

*traya-compounding-engineering (web):*
- `/traya-compounding-engineering:plan` → `/traya-compounding-engineering:work` → `/traya-compounding-engineering:review`
- Skills: ui-developer → api-integrator → ui-tester → code-reviewer

*traya-react-native (mobile):*
- `/plan` → `/work` → `/review`
- Skills: rn-ui-developer → rn-api-integrator → rn-app-tester → rn-code-reviewer
- Includes automatic iOS Simulator and Android device testing

**Key Benefit:**
Users only run three commands for complete workflow. Skills are invoked automatically based on context, providing comprehensive quality assurance with iterative workflows.

### Updating Tags/Keywords

Tags should reflect the compounding engineering philosophy and target technologies for each plugin:

**For traya-compounding-engineering (web):**
- Core tags: `ai-powered`, `compounding-engineering`, `react`, `nextjs`, `typescript`, `workflow-automation`, `knowledge-management`
- Additional: `code-review`, `quality`, `figma`, `testing`, `ui-development`

**For traya-react-native (mobile):**
- Core tags: `ai-powered`, `compounding-engineering`, `react-native`, `ios`, `android`, `mobile`, `typescript`
- Additional: `workflow-automation`, `testing`, `figma`, `performance`, `accessibility`

Framework-specific tags are encouraged since each plugin is optimized for specific platforms.

## Commit Conventions

Follow these patterns for commit messages:

- `Add [agent/command name]` - Adding new functionality
- `Remove [agent/command name]` - Removing functionality
- `Update [file] to [what changed]` - Updating existing files
- `Fix [issue]` - Bug fixes
- `Simplify [component] to [improvement]` - Refactoring

Include the Claude Code footer:

```
🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>
```

## Resources to search for when needing more information

- [Claude Code Plugin Documentation](https://docs.claude.com/en/docs/claude-code/plugins)
- [Plugin Marketplace Documentation](https://docs.claude.com/en/docs/claude-code/plugin-marketplaces)
- [Plugin Reference](https://docs.claude.com/en/docs/claude-code/plugins-reference)

## Key Learnings

_This section captures important learnings as we work on this repository._

### 2025-10-09: Simplified marketplace.json to match official spec

The initial marketplace.json included many custom fields (downloads, stars, rating, categories, trending) that aren't part of the Claude Code specification. We simplified to only include:

- Required: `name`, `owner`, `plugins`
- Optional: `metadata` (with description and version)
- Plugin entries: `name`, `description`, `version`, `author`, `homepage`, `tags`, `source`

**Learning:** Stick to the official spec. Custom fields may confuse users or break compatibility with future versions.
