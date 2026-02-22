# LONA

## Why LONA?

The name came together from two ideas that felt right for this project.

**Lumen** — Latin for light. A robot keeping a space station alive, systems humming, 
air circulating, lights on — all for humans who never arrived. There's something quietly 
beautiful about that. A light left on for no one.

**Lonebot** — a rougher, more honest word. A bot, alone. Forgotten. Still doing its job anyway.

LONA is where those two ideas met. It sounds almost human, like a name someone might have 
given her before they left. It carries *lone* inside it, but also warmth. Not a serial number. 
Not a designation. A name for something that kept going when everything else stopped.

---

## Development Setup

### Prerequisites
- [Odin compiler](https://odin-lang.org/)
- [VS Code](https://code.visualstudio.com/)

### VS Code Integration

Build and run tasks are pre-configured via `.vscode/tasks.json`.

```json
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "Odin Build",
      "type": "shell",
      "command": "odin build .",
      "group": {
        "kind": "build",
        "isDefault": true
      },
      "presentation": {
        "reveal": "always",
        "panel": "shared"
      }
    },
    {
      "label": "Odin Run",
      "type": "shell",
      "command": "odin run .",
      "group": "test",
      "presentation": {
        "reveal": "always",
        "panel": "shared"
      }
    }
  ]
}
```


**Recommended keyboard shortcuts** — add these to your `keybindings.json`
(open with `Ctrl+Shift+P` → *"Open Keyboard Shortcuts (JSON)"*):
```json
[
  {
    "key": "ctrl+b",
    "command": "workbench.action.tasks.runTask",
    "args": "Odin Build"
  },
  {
    "key": "ctrl+r",
    "command": "workbench.action.tasks.runTask",
    "args": "Odin Run"
  }
]

**Note:**
> `Ctrl+B` overrides the default VS Code sidebar toggle.
> Use `Ctrl+Shift+B` instead if you want to keep that shortcut — it runs the default build task automatically.
```

## License

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](LICENSE)

This project is licensed under the GNU General Public License v3.0.  
See [LICENSE](LICENSE) for details.