# nvim-config

Personal Neovim configuration. Built from scratch — every line is intentional.

- **Neovim:** v0.12.2
- **Plugin manager:** lazy.nvim
- **Platform:** Ubuntu 24.04 (WSL2)

## Quick install

```bash
curl -sSL https://raw.githubusercontent.com/davidphuong/nvim-config/master/install.sh | bash
```

This installs Neovim and clones the config into `~/.config/nvim`. Safe to re-run
— skips steps already done, upgrades Neovim if the pinned version has changed.

## What the install script does

1. Installs Neovim v0.12.2 via AppImage into `/usr/local/bin/nvim`
2. Installs xclip for clipboard support (WSL2 only)
3. Installs ripgrep and fd (required by Telescope)
4. Installs Node.js LTS (required by LSP servers: bashls, yamlls, dockerls)
5. Installs pip (required by LSP servers: ansiblels)
6. Installs shellcheck (required by bashls for bash linting)
7. Clones this repo into `~/.config/nvim` (or pulls if already cloned)

## First launch

```bash
nvim
```

`lazy.nvim` will bootstrap itself and install all plugins on first launch.
Mason will automatically install all LSP servers on first launch too.

## Structure

```
~/.config/nvim/
├── install.sh              # Bootstrap script
├── README.md
├── init.lua                # Entry point — loads core modules + bootstraps lazy.nvim
└── lua/
    ├── core/
    │   ├── options.lua     # Vim options (tabs, numbers, search, clipboard, diagnostics)
    │   ├── keymaps.lua     # Keybindings
    │   └── autocmds.lua    # Automatic behaviours (trim whitespace, restore cursor, etc.)
    └── plugins/
        ├── auto-session.lua  # Session management
        ├── catppuccin.lua    # Colorscheme (latte)
        ├── flash.lua         # Quick cursor jumping
        ├── gitsigns.lua      # Git diff indicators and hunk operations
        ├── lsp.lua           # LSP + Mason (bashls, yamlls, dockerls, ansiblels)
        ├── lualine.lua       # Statusline
        ├── neo-tree.lua      # File tree
        ├── telescope.lua     # Fuzzy finder
        └── which-key.lua     # Keybinding popup
```

## Adding plugins

1. Create `lua/plugins/<plugin-name>.lua` and return a lazy.nvim spec from it
2. Restart Neovim — lazy.nvim installs it automatically

## Clipboard (WSL2)

Clipboard sync is handled via `xclip`, installed automatically by `install.sh` on WSL2.
It works through WSLg — the built-in display server on WSL2 with Windows 11.

If clipboard isn't working, verify xclip is installed and `$DISPLAY` is set:

```bash
echo $DISPLAY      # should print :0
which xclip        # should print a path
```

If `$DISPLAY` is empty, WSLg may not be running — try restarting WSL2:

```powershell
# In Windows PowerShell
wsl --shutdown
```

Then reopen your WSL2 terminal.

## Key mappings

Leader key: `Space`

### Core

| Key                    | Mode          | Action                            |
|------------------------|---------------|-----------------------------------|
| `<leader>w`            | Normal        | Save file                         |
| `<leader>q`            | Normal        | Quit                              |
| `<Esc>`                | Normal        | Clear search highlights           |
| `<C-d>` / `<C-u>`      | Normal        | Scroll half page (centred)        |
| `n` / `N`              | Normal        | Next/prev search result (centred) |
| `<` / `>`              | Visual        | Indent (keep selection)           |
| `p`                    | Visual        | Paste without clobbering register |
| `<C-h/j/k/l>`          | Normal        | Navigate splits                   |
| `<C-Arrows>`           | Normal        | Resize splits                     |
| `<S-h>` / `<S-l>`      | Normal        | Previous/next buffer              |
| `<leader>bd`           | Normal        | Close buffer                      |
| `<leader>tt`           | Normal        | Open terminal (horizontal split)  |
| `[d` / `]d`            | Normal        | Previous/next diagnostic (LSP)    |
| `<leader>cd`           | Normal        | Show diagnostic detail            |
| `<leader>sl`           | Normal        | Diagnostics to location list      |

### Telescope

| Key          | Mode    | Action                              |
|--------------|---------|-------------------------------------|
| `<leader>ff` | Normal  | Find files by name                  |
| `<leader>fg` | Normal  | Live grep                           |
| `<leader>fb` | Normal  | List open buffers                   |
| `<C-v>`      | Inside  | Open in vertical split              |
| `<C-s>`      | Inside  | Open in horizontal split            |
| `<C-j>` / `<C-k>` | Inside | Move down/up results          |
| `<C-x>`      | Inside  | Delete buffer (buffers picker only) |

### Flash

| Key | Mode   | Action           |
|-----|--------|------------------|
| `s` | Normal | Jump to any word |

### Neo-tree

| Key           | Mode    | Action                   |
|---------------|---------|--------------------------|
| `<leader>e`   | Normal  | Toggle file tree         |
| `<CR>` / `o`  | In tree | Open file                |
| `<C-v>`       | In tree | Open in vertical split   |
| `<C-s>`       | In tree | Open in horizontal split |
| `a`           | In tree | Create file/directory    |
| `d`           | In tree | Delete                   |
| `r`           | In tree | Rename                   |
| `q`           | In tree | Close tree               |
| `H`           | In tree | Toggle hidden files      |

### Gitsigns

| Key           | Mode   | Action                  |
|---------------|--------|-------------------------|
| `]h`          | Normal | Next hunk               |
| `[h`          | Normal | Previous hunk           |
| `<leader>gb`  | Normal | Toggle inline git blame |
| `<leader>gp`  | Normal | Preview hunk            |
| `<leader>gs`  | Normal | Stage hunk              |
| `<leader>gr`  | Normal | Reset hunk              |

### LSP (active when LSP attaches to buffer)

| Key           | Mode   | Action              |
|---------------|--------|---------------------|
| `gd`          | Normal | Go to definition    |
| `gr`          | Normal | Go to references    |
| `K`           | Normal | Hover documentation |
| `<leader>rn`  | Normal | Rename symbol       |
| `<leader>ca`  | Normal | Code action         |
