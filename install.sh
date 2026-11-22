#!/usr/bin/env bash
# DevCut Studio verified macOS ZIP installer.
# Download the OWNER or CUSTOMER ZIP first, then run:
# curl -fsSL https://raw.githubusercontent.com/ghostfacethegreat/devcut/main/install.sh | bash -s -- --zip "$HOME/Downloads/DevCut-Studio-v0.9.1-OWNER.zip"
set -euo pipefail

ZIP_PATH=""
while [[ $# -gt 0 ]]; do
  case "$1" in
    --zip|--owner-zip|--customer-zip)
      [[ $# -ge 2 ]] || { echo "Missing ZIP path after $1" >&2; exit 2; }
      ZIP_PATH="$2"; shift 2 ;;
    --help|-h)
      cat <<'HELP'
DevCut Studio installer for macOS

1. Download your ZIP and keep it in Downloads.
2. Run one of these commands:

Owner (free for the project owner):
  curl -fsSL https://raw.githubusercontent.com/ghostfacethegreat/devcut/main/install.sh | bash -s -- --zip "$HOME/Downloads/DevCut-Studio-v0.9.1-OWNER.zip"

Customer (requires a $30 lifetime license):
  curl -fsSL https://raw.githubusercontent.com/ghostfacethegreat/devcut/main/install.sh | bash -s -- --zip "$HOME/Downloads/DevCut-Studio-v0.9.1-CUSTOMER.zip"

Alternative: extract the ZIP in Finder, then double-click Install DevCut.command.
The ZIP is verified locally before installation. The installer never uploads your ZIP or Owner key.
HELP
      exit 0 ;;
    *) echo "Unknown option: $1 (use --help)" >&2; exit 2 ;;
  esac
done

if [[ "$(uname -s)" != "Darwin" ]]; then
  echo "DevCut Studio currently supports macOS only." >&2
  exit 1
fi
command -v unzip >/dev/null 2>&1 || { echo "unzip is required (included with macOS)." >&2; exit 1; }
command -v shasum >/dev/null 2>&1 || { echo "shasum is required (included with macOS)." >&2; exit 1; }

if [[ -z "$ZIP_PATH" ]]; then
  if [[ -f "$HOME/Downloads/DevCut-Studio-v0.9.1-OWNER.zip" ]]; then
    ZIP_PATH="$HOME/Downloads/DevCut-Studio-v0.9.1-OWNER.zip"
  elif [[ -f "$HOME/Downloads/DevCut-Studio-v0.9.1-CUSTOMER.zip" ]]; then
    ZIP_PATH="$HOME/Downloads/DevCut-Studio-v0.9.1-CUSTOMER.zip"
  else
    echo "DevCut ZIP not found in Downloads."
    echo "Download the OWNER or CUSTOMER ZIP first, then rerun this installer with --zip <path>."
    exit 1
  fi
fi

[[ -f "$ZIP_PATH" ]] || { echo "ZIP not found: $ZIP_PATH" >&2; exit 1; }
ROOT="$(unzip -Z1 "$ZIP_PATH" | awk -F/ 'NF > 1 { print $1; exit }')"
case "$ROOT" in
  DevCut-Studio-v0.9.1-OWNER)
    EXPECTED="3436521b7f937548f09a04374a84d5e7c2969c0c7e17c2d5ca5c8a13d190441d"
    EDITION="Owner Edition — free for the project owner" ;;
  DevCut-Studio-v0.9.1-CUSTOMER)
    EXPECTED="6c6103d721084a7018db8b32fecf6b04325bb7a98829e86766922e53c2e3b54c"
    EDITION="Customer Edition — $30 one-time lifetime license" ;;
  *)
    echo "This ZIP is not a supported DevCut Studio v0.9.1 package." >&2
    exit 1 ;;
esac
ACTUAL="$(shasum -a 256 "$ZIP_PATH" | awk '{print $1}')"
if [[ "$ACTUAL" != "$EXPECTED" ]]; then
  echo "ZIP checksum verification failed. Nothing was installed." >&2
  exit 1
fi

TMP_DIR="$(mktemp -d "${TMPDIR:-/tmp}/devcut-install.XXXXXX")"
cleanup() { rm -rf "$TMP_DIR"; }
trap cleanup EXIT
unzip -q "$ZIP_PATH" -d "$TMP_DIR"
SOURCE_DIR="$TMP_DIR/$ROOT"
[[ -f "$SOURCE_DIR/install_local.sh" ]] || { echo "The ZIP is missing its installer." >&2; exit 1; }

printf '\033[96m\n  DEVCUT STUDIO  /  INSTALLER\033[0m\n'
printf '  Verified package: %s\n\n' "$EDITION"
bash "$SOURCE_DIR/install_local.sh"
printf '\n\033[92m  Installation finished. Open DevCut Studio from Applications/Terminal launcher.\033[0m\n'
