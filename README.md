# DEVCUT STUDIO

<div align="center">

### A local-first AI clipping workspace for streamers and short-form creators.

Paste a video or channel link. Find moments worth clipping. Make vertical videos. Queue and publish to connected platforms.

[![Version](https://img.shields.io/badge/version-0.9.1-7c3aed?style=for-the-badge)](https://github.com/ghostfacethegreat/devcut)
[![Platform](https://img.shields.io/badge/platform-macOS-black?style=for-the-badge&logo=apple)](https://github.com/ghostfacethegreat/devcut)
[![Tests](https://img.shields.io/badge/tests-66%20passing-16a34a?style=for-the-badge)](https://github.com/ghostfacethegreat/devcut/actions)
[![License](https://img.shields.io/badge/license-proprietary-64748b?style=for-the-badge)](LICENSE)

**[Install](#install) · [Features](#features) · [Quick start](#quick-start) · [Publishing](#social-publishing) · [Support](#support)**

</div>

---

## What is DevCut?

DevCut Studio is a guided command-line clipping workspace. Paste a video or YouTube channel link, choose actions by name, rank candidate moments, render vertical clips and manage your publishing workflow.

The local worker can monitor a YouTube channel you are authorized to use and capture completed segments from supported YouTube livestreams.

> **Media rights matter:** only process videos and channels you own or have explicit permission to download, edit and distribute. A clipping-reward campaign does not automatically grant rights to every creator or stream.

## Install

### One-command installer

1. Download your edition ZIP from the private download supplied with your purchase or owner access.
2. Keep it in your Downloads folder.
3. Open Terminal and paste the matching command.

**Free Owner Edition**
```bash
curl -fsSL https://raw.githubusercontent.com/ghostfacethegreat/devcut/main/install.sh | bash -s -- --zip "$HOME/Downloads/DevCut-Studio-v0.9.1-OWNER.zip"
```

**Customer Edition — $30 one-time**
```bash
curl -fsSL https://raw.githubusercontent.com/ghostfacethegreat/devcut/main/install.sh | bash -s -- --zip "$HOME/Downloads/DevCut-Studio-v0.9.1-CUSTOMER.zip"
```

The script verifies the archive's SHA-256 checksum, extracts it locally, and runs the included installer. It does not upload your ZIP, social credentials or Owner key.

### Alternative: Finder installation

1. Double-click the downloaded ZIP to extract it.
2. Open the extracted `DevCut-Studio-v0.9.1-OWNER` or `DevCut-Studio-v0.9.1-CUSTOMER` folder.
3. Double-click **Install DevCut.command**.
4. When installation completes, double-click **Open DevCut Studio.command**.

If macOS blocks the installer, right-click it and choose **Open**.

### Requirements

- macOS 12 or newer recommended
- Python 3.10+
- FFmpeg / FFprobe
- Homebrew is used by the installer to obtain missing dependencies
- At least 2 GB free space for setup; video processing needs additional space

The installer does not delete personal media or coding projects. It does not require `sudo`.

## Features

| Capability | Details |
|---|---|
| Guided CLI | Paste-first input and plain-language action names |
| Source intake | Local files and supported YouTube URLs via `yt-dlp` |
| Highlight analysis | Transcript-aware ranking when speech AI is configured, plus audio energy, motion and optional timestamped chat exports |
| Moment scores | 0–100 editing-priority score with reasons; not a guarantee of virality |
| Vertical editing | 9:16 rendering, timed captions and word emphasis |
| Branding | Campaign watermark and reusable presets |
| Channel monitor | Poll authorized YouTube channels for new uploads |
| Live capture | Capture completed rolling segments from supported YouTube livestreams |
| Social workflow | Instagram Reels and YouTube publishing integrations, subject to developer/app authorization |
| Campaign reminders | Local macOS reminders after a confirmed published post |

Video analysis and rendering are local. Social publishing requires each platform's own developer app, authorization and any required app approval.

## Quick start

1. Open DevCut Studio from the installed launcher.
2. Paste a video URL, or press Return to use a video already in your DevCut Inbox.
3. Choose **Set up speech AI** once to configure local transcription.
4. Choose **Make clips from latest video**.
5. Choose **Review clip scores** to inspect candidate moments.
6. Choose **Open finished clips** to preview MP4 files in Finder.
7. Connect social accounts only after reviewing the draft workflow.

Working folders:

```text
~/Movies/DevCut/
├── Inbox/       # source videos
├── Exports/     # rendered clips and upload queue
└── Processed/   # completed source recordings
```

## Social publishing

### Instagram Reels
Requires an eligible Instagram Professional account, a Meta developer app, current publishing permissions and any required Meta app review. DevCut uses the official publishing API; it does not ask for your Instagram password.

### YouTube Shorts
Requires a Google OAuth Desktop client and YouTube Data API upload scope. Confirm privacy settings before enabling unattended publishing.

### TikTok
Direct Post requires an approved developer app, `video.publish` permission, user authorization and TikTok app audit for public posting. TikTok requires a preview and explicit consent for each post. Promotional logo/watermark overlays are not allowed on API-shared content under TikTok's content-sharing guidelines, so campaign-branded clips must be posted manually.

### X
Automatic X publishing is not included. X API access has usage-based pricing and separate developer requirements.

Publishing does not guarantee campaign approval or earnings. Check campaign rules, use connected and verified accounts, and submit post URLs within the campaign deadline.

## Pricing and licensing

- **Owner:** free Owner Edition, activated on the project owner's Mac.
- **Customers:** $30 one-time for a machine-bound lifetime license; no subscription.
- The Customer ZIP contains the public verification key only.
- The Owner signing key is private and never belongs in GitHub or Customer builds.
- Payment-to-license fulfillment is currently manual; Stripe checkout and webhook automation are not live.

## Privacy and safety

- Source media, transcripts, score reports and exports stay on your Mac.
- Platform access uses official OAuth; tokens are stored in macOS Keychain where available.
- Never paste passwords, access tokens, developer secrets or private keys into issues or chat.
- Do not use purchased views, bots, engagement manipulation or unauthorized footage.
- Follow platform policies and each campaign's specific branding requirements.

## Development

The public repository contains documentation and the installer bootstrap. The licensed application packages are distributed separately.

To validate the application after extracting a development package:

```bash
python3 -m venv .venv
source .venv/bin/activate
python -m pip install -r requirements.txt pytest
python -m py_compile devcut_cli.py devcut_worker.py devcut_intelligence.py devcut_social.py
pytest -q
```

CI runs repository quality checks on pushes and pull requests.

## Support

- Report reproducible bugs via [GitHub Issues](https://github.com/ghostfacethegreat/devcut/issues).
- Include DevCut version, macOS version, the selected action and redacted error output.
- Never attach source videos, passwords, OAuth tokens, private keys, Owner ZIPs or license files.

<div align="center">

**DEVCUT STUDIO** · Built for a simpler clipping workflow.

</div>
