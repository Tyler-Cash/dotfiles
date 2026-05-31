# Fetch a secret value from AWS Secrets Manager on demand
# Usage: awssecret my/secret/name
awssecret() {
  aws secretsmanager get-secret-value \
    --secret-id "$1" \
    --query SecretString \
    --output text || return 1
}

# Create a directory and cd into it
mkcd() {
  mkdir -p "$1" && cd "$1"
}

# Cross-platform open — delegates to the right tool per OS
if [[ "$OSTYPE" == darwin* ]]; then
  xopen() { open "$@"; }
elif [[ -n "$WSL_DISTRO_NAME" ]]; then
  xopen() { wslview "$@"; }
else
  xopen() { xdg-open "$@"; }
fi
