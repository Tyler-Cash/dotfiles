# macOS only — Bitwarden unlock via Keychain (supports Touch ID)
# One-time setup: security add-generic-password -a "$USER" -s "bitwarden" -w
if [[ "$OSTYPE" == darwin* ]]; then
  bwu() {
    export BW_SESSION=$(
      security find-generic-password -a "$USER" -s "bitwarden" -w \
      | bw unlock --raw
    )
    echo "Bitwarden unlocked"
  }
fi
