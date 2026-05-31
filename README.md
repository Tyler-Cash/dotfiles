# dotfiles

Personal dotfiles managed by [chezmoi](https://chezmoi.io). Works across macOS (work and home) and WSL (home).

## What's included

**Shell:** zsh with Starship prompt  
**Plugins:** autosuggestions, syntax highlighting, history substring search, fzf integration, forgit (interactive git), you-should-use (alias reminders)  
**Version managers:** fnm (Node, auto-switches on `cd`), sdkman (Java/JVM, auto-switches on `cd`)  
**Tools:** eza, bat, ripgrep, fd, fzf, zoxide, jq, kubectl, kubectx, helm, gh (home) / glab (work)

## Prerequisites

1. A [Nerd Font](https://www.nerdfonts.com/) installed and set in your terminal (e.g. JetBrainsMono Nerd Font) — Starship uses its glyphs
2. On macOS: [Homebrew](https://brew.sh)
3. Secret manager CLI authenticated:
   - **Work:** [1Password CLI](https://developer.1password.com/docs/cli/) — `eval $(op signin)`
   - **Home:** [Bitwarden CLI](https://bitwarden.com/help/cli/) — `bw login`, then `export BW_SESSION=$(bw unlock --raw)`

## Bootstrap a new machine

```bash
# 1. Install Homebrew (macOS only — WSL uses apt automatically)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 2. Authenticate your secret manager (see Prerequisites above)

# 3. Install chezmoi + clone + apply in one command
#    You'll be prompted once: "Machine type (work/home)"
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply github.com/Tyler-Cash/dotfiles
```

The install script runs automatically on first apply and installs all Homebrew packages, sdkman, and configures everything.

## Secrets

Secrets are injected into `~/.zshrc` at `chezmoi apply` time and never stored in git. If your secret manager isn't authenticated, secrets are skipped — re-run `chezmoi apply` after authenticating to pick them up.

**Adding a secret:**

Edit `dot_zshrc.tmpl` and add inside the existing secrets block:

```
{{- if eq .machine "work" }}
export MY_TOKEN={{ onepasswordRead "op://VaultName/ItemName/FieldName" | quote }}
{{- else }}
export MY_TOKEN={{ (bitwarden "item" "item-name").login.password | quote }}
{{- end }}
```

Then run `chezmoi apply` to re-render.

**AWS Secrets Manager** (work only): use the `awssecret` function to fetch on demand rather than baking into the environment:

```bash
awssecret my/secret/name
```

## Updating dotfiles

```bash
# Edit a file directly via chezmoi (opens in $EDITOR, applies on save)
cze ~/.zshrc

# Or edit the source directly, then apply
chezmoi apply          # or: cza
```

To pull and apply changes from GitHub on an existing machine:

```bash
chezmoi update
```

## Key aliases

| Alias | Command |
|-------|---------|
| `k` | `kubectl` |
| `kctx` | `kubectx` |
| `kns` | `kubens` |
| `tf` | `terraform` |
| `tfi/tfp/tfa/tfd` | terraform init/plan/apply/destroy |
| `ll` | `eza -la --icons --git` |
| `cat` | `bat` |
| `copy` / `paste` | clipboard (pbcopy/clip.exe per OS) |
| `cza` | `chezmoi apply` |
| `gl` | `glab` (work only) |

## Machine identity

On first bootstrap, chezmoi prompts for machine type and writes `~/.config/chezmoi/chezmoi.toml`:

```toml
[data]
  machine = "work"   # or "home"
  isWSL = false
```

This file is local-only and never committed. To change machine type: edit it directly and re-run `chezmoi apply`.
