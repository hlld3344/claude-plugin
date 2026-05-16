# Claude Plugin Marketplace

This repository demonstrates a **Claude Code Plugin Marketplace** using Git branches to manage different environments (production vs. staging).

## Repository Structure

```
.claude-plugin/
└── marketplace.json          # Marketplace metadata and plugin index
plugins/
└── skills/
    └── hello-world/
        └── SKILL.md
```

## Branches

| Branch | Environment | Plugin Version | Status |
|--------|-------------|----------------|--------|
| `master` | Production | hello-world v1.0.0 | Stable |
| `staging` | Staging/Beta | hello-world v2.0.0-beta | Development |

## Adding This Marketplace to Claude Code

### Via `/plugin` Command (Recommended)

In Claude Code's input box, use the `/plugin` command:

```
/plugin add https://github.com/hlld3344/claude-plugin.git --branch master --manifest .claude-plugin/marketplace.json
```

Or for the staging environment:

```
/plugin add https://github.com/hlld3344/claude-plugin.git --branch staging --manifest .claude-plugin/marketplace.json
```

> **Key Feature**: The same repository can be registered multiple times with different branches, allowing Claude Code to switch between production and staging plugins.

### Via CLI

Alternatively, you can add the marketplace using the Claude Code CLI:

```bash
# Add production marketplace
claude plugin add https://github.com/hlld3344/claude-plugin.git --branch master --manifest .claude-plugin/marketplace.json

# Add staging marketplace
claude plugin add https://github.com/hlld3344/claude-plugin.git --branch staging --manifest .claude-plugin/marketplace.json
```

## Verification Checklist

After configuring, verify the following scenarios:

- [ ] Adding `master` marketplace successfully loads `hello-world v1.0.0`
- [ ] Adding `staging` marketplace successfully loads `hello-world v2.0.0-beta`
- [ ] Both marketplaces can coexist simultaneously
- [ ] Switching from staging to master correctly reverts plugin versions
- [ ] Marketplace metadata (`name`, `owner`, `version`) displays correctly

## Switching Between Branches

Use the provided PowerShell script to switch your local environment:

```powershell
# Switch to production
.\switch-marketplace.ps1 -Branch master

# Switch to staging
.\switch-marketplace.ps1 -Branch staging
```

## Environment Details

- **Repository**: https://github.com/hlld3344/claude-plugin.git
- **Marketplace Manifest**: `.claude-plugin/marketplace.json`
- **Last Updated**: 2024-01-15

## Troubleshooting

**Marketplace not found?**
- Verify `manifestPath` includes the `.claude-plugin/` directory prefix
- Confirm the file exists in the target branch: `git show branch:.claude-plugin/marketplace.json`

**Plugin version not updating?**
- Restart Claude Code or run `claude marketplace refresh` (if available)
- Check that the correct branch is specified in the configuration
