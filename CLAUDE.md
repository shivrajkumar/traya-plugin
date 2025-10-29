# TrayaHealth Marketplace - Claude Code Plugin Marketplace

This repository is a Claude Code plugin marketplace that distributes the `traya` plugin to developers building React and Next.js applications with AI-powered tools.

## Repository Structure

```
traya-marketplace/
├── .claude-plugin/
│   └── marketplace.json          # Marketplace catalog (lists available plugins)
└── plugins/
    └── traya/   # The actual plugin
        ├── .claude-plugin/
        │   └── plugin.json        # Plugin metadata
        ├── agents/                # 16 specialized AI agents
        ├── commands/              # 6 slash commands
        ├── skills/                # 3 specialized skills
        ├── .mcp.json              # 5 bundled MCP servers
        └── README.md              # Plugin documentation
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

### Updating the Traya Plugin

When agents or commands are added/removed:

1. **Scan for actual files:**

   ```bash
   # Count agents
   ls plugins/traya/agents/*.md | wc -l

   # Count commands
   ls plugins/traya/commands/*.md | wc -l
   ```

2. **Update plugin.json** at `plugins/traya/.claude-plugin/plugin.json`:

   - Update `components.agents` count
   - Update `components.commands` count
   - Update `agents` object to reflect which agents exist
   - Update `commands` object to reflect which commands exist

3. **Update plugin README** at `plugins/traya/README.md`:

   - Update agent/command counts in the intro
   - Update the agent/command lists to match what exists

4. **Update marketplace.json** at `.claude-plugin/marketplace.json`:
   - Usually doesn't need changes unless changing plugin description/tags

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
    "skills": 3
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
   claude /plugin marketplace add /Users/yourusername/traya-marketplace
   ```

2. Install the plugin:

   ```bash
   claude /plugin install traya
   ```

3. Bundled MCP servers start automatically

4. (Optional) Index your project for Serena:
   ```bash
   uvx --from git+https://github.com/oraios/serena serena project index
   ```

5. Test agents and commands:
   ```bash
   claude /traya:review
   claude agent typescript-reviewer "test message"
   ```

### Validate JSON

Before committing, ensure JSON files are valid:

```bash
cat .claude-plugin/marketplace.json | jq .
cat plugins/traya/.claude-plugin/plugin.json | jq .
cat plugins/traya/.mcp.json | jq .
```

## Common Tasks

### Adding a New Agent

1. Create `plugins/traya/agents/new-agent.md`
2. Update plugin.json agent count and agent list
3. Update README.md agent list
4. Test with `claude agent new-agent "test"`

### Adding a New Command

1. Create `plugins/traya/commands/new-command.md`
2. Update plugin.json command count and command list
3. Update README.md command list
4. Test with `claude /new-command`

### Adding a New Skill

1. Create `plugins/traya/skills/new-skill.md`
2. Update plugin.json skill count
3. Update README.md skill list
4. Test with `claude /skill new-skill`

### Updating Tags/Keywords

Tags should reflect the compounding engineering philosophy and target technologies:

- Use: `ai-powered`, `traya`, `react`, `nextjs`, `typescript`, `workflow-automation`, `knowledge-management`
- Framework-specific tags are encouraged since this plugin is optimized for React/Next.js

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
