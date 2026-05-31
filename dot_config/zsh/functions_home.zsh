# macOS only — Bitwarden session management via Keychain (supports Touch ID)
# Session token is cached in Keychain; falls back to interactive unlock when expired.
if [[ "$OSTYPE" == darwin* ]]; then
  bwu() {
    # Try to restore a cached session (triggers Touch ID / Keychain prompt)
    local session
    session=$(security find-generic-password -a "$USER" -s "bitwarden-session" -w 2>/dev/null)

    if [[ -n "$session" ]]; then
      export BW_SESSION="$session"
      # Validate with a real operation — bw status only reports local state
      if bw list folders --nointeraction 2>/dev/null | grep -q '\['; then
        _bwu_load_secrets
        echo "Bitwarden session restored"
        return 0
      fi
      echo "Session expired, re-unlocking..."
    fi

    # No valid session — unlock interactively and cache the token in Keychain
    export BW_SESSION=$(bw unlock --raw)
    if [[ -z "$BW_SESSION" ]]; then
      echo "Unlock failed"
      return 1
    fi

    security delete-generic-password -a "$USER" -s "bitwarden-session" 2>/dev/null || true
    security add-generic-password -a "$USER" -s "bitwarden-session" -w "$BW_SESSION"
    _bwu_load_secrets
    echo "Bitwarden unlocked"
  }

  # Exports secrets from Bitwarden into the current shell session (memory only, nothing on disk).
  # Add new secrets here following the same pattern.
  _bwu_load_secrets() {
    export GITHUB_TOKEN=$(bw get password github-token 2>/dev/null)
  }
fi
