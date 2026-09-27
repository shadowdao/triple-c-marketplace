# Triple-C Marketplace

A marketplace of Claude Code agents, skills, commands, hooks and plugins for
[Triple-C](https://repo.anhonesthost.net/CyberCoveLLC/Triple-C). Add this repo in
Triple-C under **Settings → Marketplace → Open Marketplace → Add**, then install
items for all projects or for individual projects.

The `plugins/` folder is also a standard Claude Code marketplace, so it works
without Triple-C:

```
/plugin marketplace add shadowdao/triple-c-marketplace/plugins
```

## Layout

```
agents/<name>.md                    Claude Code agent (front matter: name, description)
skills/<name>/SKILL.md (+ files)    Claude Code skill folder
commands/<name>.md                  Claude Code slash command
hooks/<name>/hook.json (+ scripts)  Triple-C hook manifest
plugins/.claude-plugin/marketplace.json
plugins/<plugin>/…                  Claude Code plugins
```

Every folder is optional.

## Item rules

- **Names** (file stem, folder name, plugin name) must match
  `^[A-Za-z0-9][A-Za-z0-9._-]{0,63}$`.
- **No symlinks** anywhere in an item.
- **Limits:** 2 MiB and 200 files per item.
- **Agents** are installed to `~/.claude/agents/<name>.md`. `name` and
  `description` come from the YAML front matter.
- **Skills** are installed to `~/.claude/skills/<name>/`. The folder must contain `SKILL.md`.
- **Commands** are installed to `~/.claude/commands/<name>.md`. The description
  comes from front matter `description`, or the first non-empty line.
- **Hooks** are a folder with a `hook.json`:

  ```json
  {
    "name": "notify-on-stop",
    "description": "Rings the terminal bell when Claude finishes",
    "hooks": {
      "Stop": [{ "hooks": [{ "type": "command", "command": "${HOOK_DIR}/notify.sh" }] }]
    }
  }
  ```

  `hooks` uses Claude Code's `settings.json` hooks format verbatim.
  `${HOOK_DIR}` is replaced with the folder the hook is installed to
  (`~/.claude/triple-c/hooks/<name>`). The whole folder is copied, and files keep
  their executable bit. Triple-C shows every command a hook runs before it is installed.
- **Plugins** are the entries of `plugins/.claude-plugin/marketplace.json`.
  Each `source` must be a relative path inside `plugins/` (for example
  `"./example-plugin"`). Remote sources are not installable through Triple-C,
  because they would bypass pinning.

## Versioning

Triple-C pins every install to the commit it was installed from. Pushing to this
repo never changes a container by itself: Triple-C shows **update available**
for the items whose files changed, and the user reviews a diff before accepting.
