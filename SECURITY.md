# Security policy

## Reporting a vulnerability

Please do not publish secrets or exploit details in a public issue. Contact the repository owner through the GitHub profile and provide a concise report with reproduction steps.

## Never disclose

- OAuth access or refresh tokens
- Meta, TikTok, Google or X developer secrets
- `config.json`, `.env` files or local Keychain exports
- `owner_keys/ed25519_private.pem`
- Owner ZIPs or signed customer license files

## Local security

DevCut uses official platform OAuth flows and stores platform tokens in macOS Keychain where available. Keep macOS user access protected and do not run untrusted scripts as an administrator. The installer does not require `sudo`.
