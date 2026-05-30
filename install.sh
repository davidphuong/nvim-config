#!/usr/bin/env bash
# =============================================================================
# install.sh — Neovim setup bootstrap
# =============================================================================
# Run this on any fresh Ubuntu machine to install Neovim and your config.
# Safe to run multiple times — skips steps already done, upgrades if version
# has changed.
#
# Usage:
#   chmod +x install.sh
#   ./install.sh
#
# What it does:
#   1. Installs Neovim (pinned version, via AppImage) — upgrades if outdated
#   2. Installs xclip for clipboard support (WSL2 only)
#   3. Installs ripgrep and fd (required by Telescope)
#   4. Installs Node.js LTS (required by LSP servers: bashls, yamlls, dockerls)
#   5. Installs pip (required by LSP servers: ansiblels)
#   6. Installs shellcheck (required by bashls for bash linting)
#   7. Clones your config repo into ~/.config/nvim — pulls if already cloned
#
# =============================================================================

set -euo pipefail
# set -e  → exit immediately if any command fails
# set -u  → treat unset variables as errors
# set -o pipefail → catch failures inside pipes (e.g. curl | grep)

# -----------------------------------------------------------------------------
# Config — edit these before running
# -----------------------------------------------------------------------------
NVIM_VERSION="v0.12.2"
REPO_URL="https://github.com/davidphuong/nvim-config.git"

# -----------------------------------------------------------------------------
# Helpers
# -----------------------------------------------------------------------------
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # no colour

info()  { echo -e "${GREEN}[INFO]${NC}  $*"; }
skip()  { echo -e "${YELLOW}[SKIP]${NC}  $*"; }
error() { echo -e "${RED}[ERROR]${NC} $*"; exit 1; }

# -----------------------------------------------------------------------------
# Step 1 — Neovim
# -----------------------------------------------------------------------------
NVIM_DEST="/usr/local/bin/nvim"
NVIM_URL="https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/nvim-linux-x86_64.appimage"

CURRENT_VERSION=""
if command -v nvim &>/dev/null; then
  # `nvim --version` outputs e.g. "NVIM v0.12.2" — extract just the tag
  CURRENT_VERSION=$(nvim --version | head -n1 | grep -oE 'v[0-9]+\.[0-9]+\.[0-9]+')
fi

if [[ "${CURRENT_VERSION}" == "${NVIM_VERSION}" ]]; then
  skip "Neovim ${NVIM_VERSION} already installed — skipping"
else
  if [[ -n "${CURRENT_VERSION}" ]]; then
    info "Upgrading Neovim ${CURRENT_VERSION} → ${NVIM_VERSION}..."
  else
    info "Installing Neovim ${NVIM_VERSION}..."
  fi

  curl -sSLo /tmp/nvim.appimage "${NVIM_URL}"
  chmod u+x /tmp/nvim.appimage
  sudo mv /tmp/nvim.appimage "${NVIM_DEST}"

  if ! command -v nvim &>/dev/null; then
    error "Neovim install failed — 'nvim' not found in PATH"
  fi

  info "Neovim ${NVIM_VERSION} installed"
fi

# -----------------------------------------------------------------------------
# Step 2 — Clipboard (WSL2 only)
# -----------------------------------------------------------------------------
# xclip bridges Neovim's clipboard with the Windows clipboard via WSLg.
# WSLg is a built-in display server available on WSL2 with Windows 11.
# Detected by checking /proc/version for "microsoft" or "wsl".
if grep -qEi "microsoft|wsl" /proc/version 2>/dev/null; then
  if command -v xclip &>/dev/null; then
    skip "xclip already installed — skipping"
  else
    info "WSL2 detected — installing xclip for clipboard support..."
    sudo apt-get install -y -qq xclip
    info "xclip installed"
  fi
else
  skip "Not WSL2 — skipping xclip install"
fi

# -----------------------------------------------------------------------------
# Step 3 — Telescope dependencies (ripgrep and fd)
# -----------------------------------------------------------------------------
# ripgrep (rg) — used by Telescope for live grep (searching text inside files)
# fd (fdfind)  — faster file finder, used by Telescope for file finding
if command -v rg &>/dev/null; then
  skip "ripgrep already installed — skipping"
else
  info "Installing ripgrep..."
  sudo apt-get install -y -qq ripgrep
  info "ripgrep installed"
fi

if command -v fdfind &>/dev/null; then
  skip "fd already installed — skipping"
else
  info "Installing fd..."
  sudo apt-get install -y -qq fd-find
  info "fd installed"
fi

# -----------------------------------------------------------------------------
# Step 4 — Node.js LTS (required by LSP servers: bashls, yamlls, dockerls)
# -----------------------------------------------------------------------------
# Installed via NodeSource to get the current LTS — the apt version is outdated.
if command -v node &>/dev/null; then
  skip "Node.js already installed ($(node --version)) — skipping"
else
  info "Installing Node.js LTS..."
  curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
  sudo apt-get install -y -qq nodejs
  info "Node.js $(node --version) installed"
fi

# -----------------------------------------------------------------------------
# Step 5 — pip (required by LSP servers: ansiblels)
# -----------------------------------------------------------------------------
if command -v pip3 &>/dev/null; then
  skip "pip already installed — skipping"
else
  info "Installing pip..."
  sudo apt-get install -y -qq python3-pip
  info "pip installed"
fi

# -----------------------------------------------------------------------------
# Step 6 — shellcheck (required by bashls for bash linting)
# -----------------------------------------------------------------------------
if command -v shellcheck &>/dev/null; then
  skip "shellcheck already installed — skipping"
else
  info "Installing shellcheck..."
  sudo apt-get install -y -qq shellcheck
  info "shellcheck installed"
fi

# -----------------------------------------------------------------------------
# Step 7 — Config repo
# -----------------------------------------------------------------------------
NVIM_CONFIG_DIR="${HOME}/.config/nvim"

if [[ -d "${NVIM_CONFIG_DIR}/.git" ]]; then
  # Already a git repo — just pull latest
  info "Config repo already exists — pulling latest changes..."
  git -C "${NVIM_CONFIG_DIR}" pull --ff-only
  info "Config up to date"
elif [[ -d "${NVIM_CONFIG_DIR}" ]]; then
  # Directory exists but isn't a git repo — don't touch it
  error "${NVIM_CONFIG_DIR} exists but is not a git repo. Remove it manually if you want a clean install:
  rm -rf ${NVIM_CONFIG_DIR}"
else
  # Fresh install — clone
  info "Cloning config from ${REPO_URL}..."
  git clone "${REPO_URL}" "${NVIM_CONFIG_DIR}"
  info "Config cloned to ${NVIM_CONFIG_DIR}"
fi

# -----------------------------------------------------------------------------
# Done
# -----------------------------------------------------------------------------
echo ""
info "All done. Run 'nvim' to launch."
info "lazy.nvim will bootstrap itself on first launch."
echo ""
