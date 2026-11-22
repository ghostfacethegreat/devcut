#!/usr/bin/env bash
# One-command DevCut Studio installer for macOS.
# Customer: curl -fsSL https://raw.githubusercontent.com/ghostfacethegreat/devcut/main/install.sh | bash
# Owner:    curl -fsSL https://raw.githubusercontent.com/ghostfacethegreat/devcut/main/install.sh | bash -s -- --owner-zip "$HOME/Downloads/DevCut-Studio-v0.9.1-OWNER.zip"
set -euo pipefail

OWNER_ZIP=""
while [[ $# -gt 0 ]]; do
  case "$1" in
    --owner-zip)
      [[ $# -ge 2 ]] || { echo "Missing path after --owner-zip" >&2; exit 2; }
      OWNER_ZIP="$2"; shift 2 ;;
    --help|-h)
      cat <<'HELP'
DevCut Studio installer

Customer install (requires a $30 lifetime license):
  curl -fsSL https://raw.githubusercontent.com/ghostfacethegreat/devcut/main/install.sh | bash

Owner install (free; use your private Owner ZIP already downloaded):
  curl -fsSL https://raw.githubusercontent.com/ghostfacethegreat/devcut/main/install.sh | bash -s -- --owner-zip "$HOME/Downloads/DevCut-Studio-v0.9.1-OWNER.zip"

The Owner ZIP is read locally. Its private signing key is never uploaded.
HELP
      exit 0 ;;
    *) echo "Unknown option: $1 (use --help)" >&2; exit 2 ;;
  esac
done

if [[ "$(uname -s)" != "Darwin" ]]; then
  echo "DevCut Studio currently supports macOS only." >&2
  exit 1
fi
command -v curl >/dev/null 2>&1 || { echo "curl is required." >&2; exit 1; }
command -v unzip >/dev/null 2>&1 || { echo "unzip is required." >&2; exit 1; }
command -v shasum >/dev/null 2>&1 || { echo "shasum is required (normally included with macOS)." >&2; exit 1; }

if [[ -n "$OWNER_ZIP" && ! -f "$OWNER_ZIP" ]]; then
  echo "Owner ZIP not found: $OWNER_ZIP" >&2
  echo "Download DevCut-Studio-v0.9.1-OWNER.zip and pass its local path with --owner-zip." >&2
  exit 1
fi

TMP_DIR="$(mktemp -d "${TMPDIR:-/tmp}/devcut-install.XXXXXX")"
cleanup() { rm -rf "$TMP_DIR"; }
trap cleanup EXIT
BASE_URL="https://raw.githubusercontent.com/ghostfacethegreat/devcut/main/packages"
PACKAGE="$TMP_DIR/DevCut-Studio-CUSTOMER.zip"
CHECKSUM="$TMP_DIR/DevCut-Studio-CUSTOMER.zip.sha256"

printf '\033[96m\n  DEVCUT STUDIO  /  INSTALLER\033[0m\n'
printf '  Downloading the verified macOS package...\n\n'
curl --fail --location --silent --show-error "$BASE_URL/DevCut-Studio-CUSTOMER.zip" -o "$PACKAGE"
curl --fail --location --silent --show-error "$BASE_URL/DevCut-Studio-CUSTOMER.zip.sha256" -o "$CHECKSUM"
EXPECTED="$(awk 'NR==1 {print $1}' "$CHECKSUM")"
ACTUAL="$(shasum -a 256 "$PACKAGE" | awk '{print $1}')"
if [[ -z "$EXPECTED" || "$EXPECTED" != "$ACTUAL" ]]; then
  echo "Package checksum verification failed. Nothing was installed." >&2
  exit 1
fi

unzip -q "$PACKAGE" -d "$TMP_DIR"
SOURCE_DIR="$TMP_DIR/DevCut-Studio-v0.9.1-CUSTOMER"
[[ -f "$SOURCE_DIR/install_local.sh" ]] || { echo "The downloaded package is incomplete." >&2; exit 1; }

# Owner key must only come from the owner's local archive or an earlier local owner install.
if [[ -n "$OWNER_ZIP" ]]; then
  MEMBER="DevCut-Studio-v0.9.1-OWNER/owner_keys/ed25519_private.pem"
  if ! unzip -Z1 "$OWNER_ZIP" | grep -Fxq "$MEMBER"; then
    echo "The selected Owner ZIP does not contain its expected private key." >&2
    exit 1
  fi
  mkdir -p "$SOURCE_DIR/owner_keys"
  unzip -p "$OWNER_ZIP" "$MEMBER" > "$SOURCE_DIR/owner_keys/ed25519_private.pem"
  chmod 600 "$SOURCE_DIR/owner_keys/ed25519_private.pem"
elif [[ -f "$HOME/Library/Application Support/DevCut/owner/ed25519_private.pem" ]]; then
  mkdir -p "$SOURCE_DIR/owner_keys"
  cp "$HOME/Library/Application Support/DevCut/owner/ed25519_private.pem" "$SOURCE_DIR/owner_keys/ed25519_private.pem"
  chmod 600 "$SOURCE_DIR/owner_keys/ed25519_private.pem"
fi

if [[ -f "$SOURCE_DIR/owner_keys/ed25519_private.pem" ]]; then
  printf '\033[92m  Owner key detected. Installing your free Owner Edition.\033[0m\n\n'
else
  printf '\033[93m  Installing Customer Edition. A $30 lifetime license is required to activate it.\033[0m\n\n'
fi
bash "$SOURCE_DIR/install_local.sh"
