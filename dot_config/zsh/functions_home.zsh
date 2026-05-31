# macOS only — Bitwarden unlock via Keychain (supports Touch ID)
# One-time setup: security add-generic-password -a "$USER" -s "bitwarden" -w
if [[ "$OSTYPE" == darwin* ]]; then
  bwu() {
    local pass
    pass=$(security find-generic-password -a "$USER" -s "bitwarden" -w 2>/dev/null)
    if [[ -z "$pass" ]]; then
      echo "No Bitwarden password in Keychain. Run this once to store it:"
      echo "  security add-generic-password -a \"\$USER\" -s \"bitwarden\" -w"
      return 1
    fi
    export BW_SESSION=$(BW_MASTERPASSWORD="$pass" bw unlock --passwordenv BW_MASTERPASSWORD --raw)
    echo "Bitwarden unlocked"
  }
fi
