# macOS only — Bitwarden session management via Keychain (supports Touch ID)
# Session token is cached in Keychain; falls back to interactive unlock when expired.
if [[ "$OSTYPE" == darwin* ]]; then
  bwu() {
    # Try to restore a cached session (triggers Touch ID / Keychain prompt)
    local session
    session=$(security find-generic-password -a "$USER" -s "bitwarden-session" -w 2>/dev/null)

    if [[ -n "$session" ]]; then
      export BW_SESSION="$session"
      if bw status 2>/dev/null | grep -q '"status":"unlocked"'; then
        echo "Bitwarden session restored"
        return 0
      fi
      echo "Session expired, re-unlocking..."
    fi

    # No valid session — unlock interactively and cache the new token
    export BW_SESSION=$(bw unlock --raw)
    if [[ -z "$BW_SESSION" ]]; then
      echo "Unlock failed"
      return 1
    fi

    security delete-generic-password -a "$USER" -s "bitwarden-session" 2>/dev/null || true
    security add-generic-password -a "$USER" -s "bitwarden-session" -w "$BW_SESSION"
    echo "Bitwarden unlocked and session cached"
  }
fi
