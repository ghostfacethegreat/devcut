<div align="center">

# DEVCUT STUDIO

### A local-first AI clipping workspace for streamers and short-form creators.

Paste a video or channel link. Find moments worth clipping. Make vertical videos. Queue and publish to connected platforms.

[![Latest version](https://img.shields.io/badge/version-0.9.1-7c3aed?style=for-the-badge)](https://github.com/ghostfacethegreat/devcut)
[![macOS](https://img.shields.io/badge/platform-macOS-black?style=for-the-badge&logo=apple)](https://github.com/ghostfacethegreat/devcut)
[![Tests](https://img.shields.io/badge/tests-66%20passing-16a34a?style=for-the-badge)](https://github.com/ghostfacethegreat/devcut/actions)
[![License](https://img.shields.io/badge/license-proprietary-64748b?style=for-the-badge)](LICENSE)

**[Install](#-install) · [Features](#-what-it-does) · [Quick start](#-quick-start) · [Publishing](#-social-publishing) · [Support](#-support)**

</div>

---

## ✦ What is DevCut?

DevCut Studio is a command-line clipping assistant designed to feel like a small editing workspace—not a wall of terminal commands. It keeps video processing on your Mac, ranks candidate moments, renders vertical clips and helps manage a repeatable publishing workflow.

The interactive CLI accepts natural-language-style actions and direct video or YouTube channel links. The background worker can watch an authorized YouTube channel for new uploads and capture completed segments from supported YouTube livestreams.

> **Media rights matter:** only process videos and channels you own or have explicit permission to download, edit and distribute. A clipping-reward campaign does not automatically grant rights to every creator or stream.

## ✦ Install

### One-command install (recommended)

**For customers:** open Terminal and paste this command. It downloads the latest packaged Customer Edition, verifies its SHA-256 checksum, and runs the macOS installer.

```bash
curl -fsSL https://raw.githubusercontent.com/ghostfacethegreat/devcut/main/install.sh | bash
```

A $30 one-time lifetime license is required to activate the Customer Edition. No subscription is required.

### Free Owner Edition

The project owner has a free machine-bound Owner Edition. The private signing key is deliberately not stored in this public repository.

1. Download your private `DevCut-Studio-v0.9.1-OWNER.zip` from the owner download provided to you.
2. Keep that ZIP in `~/Downloads` with its original filename.
3. Run:

```bash
curl -fsSL https://raw.githubusercontent.com/ghostfacethegreat/devcut/main/install.sh | bash -s -- --owner-zip "$HOME/Downloads/DevCut-Studio-v0.9.1-OWNER.zip"
```

The installer reads the signing key locally from your Owner ZIP. It does **not** upload the key. Never commit or share the Owner ZIP.

### Manual installation (alternative)

1. Open the [latest Customer package](packages/DevCut-Studio-CUSTOMER.zip) and download it.
2. Extract it in Finder.
3. Open the extracted `DevCut-Studio-v0.9.1-CUSTOMER` folder.
4. Double-click **Install DevCut.command**. If macOS blocks it, right-click → **Open**.
5. Double-click **Open DevCut Studio.command**.

### Requirements

- macOS 12 or newer recommended
- Python 3.10+
- FFmpeg / FFprobe
- Homebrew is used by the installer to obtain Python or FFmpeg when they are missing
- At least 2 GB free disk space for setup; more is needed for video files and exports

The installer does not delete your personal media or coding projects.

## ✦ What it does

| Capability | Details |
|---|---|
| Guided CLI | Paste-first input; plain-language action names; no numbered command memorization |
| Source intake | Local files and supported YouTube URLs via `yt-dlp` |
| Highlight analysis | Transcript-aware ranking when speech AI is configured, plus audio energy, motion and optional timestamped chat exports |
| Moment scores | 0–100 editing-priority score with reasons; not a guarantee of virality |
| Vertical editing | 9:16 rendering with subject-aware crop support, timed captions and word emphasis |
| Branding | Campaign watermark and reusable presets |
| Channel monitor | Poll authorized YouTube channels for new uploads |
| Live capture | Capture completed rolling segments from supported YouTube livestreams |
| Social workflow | Instagram Reels and YouTube publishing integrations, subject to developer/app authorization |
| Campaign reminders | Local macOS reminders after a confirmed published post |

All video analysis and rendering are local. Optional platform APIs require your own developer apps and approved permissions.

## ✦ Quick start

1. Open DevCut Studio from the installed launcher.
2. Paste a video URL, or press Return to use a video already in your DevCut Inbox.
3. Choose **Set up speech AI** once to configure local transcription.
4. Choose **Make clips from latest video**.
5. Choose **Review clip scores** to inspect candidate moments.
6. Choose **Open finished clips** to preview the MP4 files in Finder.
7. Connect social accounts only after you are happy with the draft workflow.

Your working folders:

```text
~/Movies/DevCut/
├── Inbox/       # source videos
├── Exports/     # rendered clips and upload queue
└── Processed/   # completed source recordings
```

## ✦ Social publishing

### Instagram Reels

Requires an eligible Instagram Professional account, a Meta developer app, the current publishing permissions and any required Meta app review. DevCut uses the official publishing API; it does not ask for your Instagram password.

### YouTube Shorts

Requires a Google OAuth Desktop client and YouTube Data API upload scope. Vertical videos that meet YouTube's current Shorts criteria can be uploaded as Shorts. Confirm the privacy setting before enabling unattended publishing.

### TikTok

TikTok Direct Post requires an approved developer app, `video.publish` permission, user authorization and—before public posting—TikTok's app audit. TikTok also requires a preview and explicit consent for each post. Promotional logos/watermarks are not allowed on API-shared content under TikTok's content-sharing guidelines, so campaign-branded clips must be posted manually through TikTok.

### X

Automatic X publishing is not included in this release. X API access has usage-based pricing and separate developer requirements.

**Publishing does not guarantee campaign acceptance or earnings.** Check each campaign's exact rules, publish from a connected and verified account, and submit the post URL within the campaign's deadline. DevCut's reminder does not extend a deadline.

## ✦ Pricing and licensing

- **Owner:** free Owner Edition, activated on the owner's Mac.
- **Customers:** $30 one-time for a machine-bound lifetime license; no subscription.
- The public Customer package contains only the public verification key.
- The Owner signing key is private and never belongs in GitHub, customer builds or support messages.
- Payment-to-license fulfillment is currently manual. Do not treat checkout or automatic license delivery as live until the publisher connects and tests the payment webhook.

See [MONETIZATION.md](MONETIZATION.md) and [OWNER_LICENSE_FULFILLMENT.md](OWNER_LICENSE_FULFILLMENT.md) in the private Owner package for fulfillment procedures.

## ✦ Privacy and safety

- Source media, transcripts, score reports and exports stay on your Mac.
- Platform access uses official OAuth flows; tokens are stored in macOS Keychain where available.
- Never paste API secrets into issues, chat messages or public config files.
- Do not use purchased views, bots, engagement manipulation or unauthorized source footage.
- Use platform-provided disclosures and obey each campaign's branding requirements.

## ✦ Development

```bash
python3 -m venv .venv
source .venv/bin/activate
python -m pip install -r requirements.txt pytest
python -m py_compile devcut_cli.py devcut_worker.py devcut_social.py
pytest -q
```

See [CONTRIBUTING.md](CONTRIBUTING.md) before submitting changes. CI runs the test suite on pushes and pull requests.

## ✦ Support

- Report reproducible bugs via [GitHub Issues](https://github.com/ghostfacethegreat/devcut/issues).
- Include macOS version, DevCut version, the exact error and relevant redacted logs.
- Never include source videos, passwords, OAuth tokens, private keys or license files in an issue.

<div align="center">

**DEVCUT STUDIO** · Built for a simpler clipping workflow.

</div>
