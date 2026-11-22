# Contributing to DevCut Studio

Thanks for helping improve DevCut.

## Before opening an issue

- Search existing issues for duplicates.
- Include the DevCut version, macOS version, exact steps and full error text.
- Redact access tokens, OAuth credentials, license files, private keys and personal media paths.

## Development setup

```bash
python3 -m venv .venv
source .venv/bin/activate
python -m pip install -r requirements.txt pytest
python -m py_compile devcut_cli.py devcut_worker.py devcut_social.py
pytest -q
```

## Pull requests

- Keep changes focused and explain the user-facing behavior.
- Add or update tests for bug fixes and new behavior.
- Do not commit `config.json`, credentials, downloaded media, exports, `.venv`, cache files or owner signing material.
- Never weaken platform authorization, campaign compliance, licensing, deduplication or source-rights checks.

The project is proprietary. Submitting a patch does not grant permission to redistribute the application or grant a broader license to the source code.
