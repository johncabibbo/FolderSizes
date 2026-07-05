# Folder Sizes

**List the size of every subfolder in a directory — human-readable size, exact bytes, and file count.**

`folderSizes.sh` reports the size of each immediate subfolder within a target directory: a human-readable size (e.g. `4.0G`), the size in bytes with thousands separators, the file count, and the folder name. Sort alphabetically or by size. A single self-contained Bash script — no config, no dependencies.

---

## Table of Contents

1. [Overview](#overview)
2. [Features](#features)
3. [Requirements](#requirements)
4. [Installation](#installation)
5. [Alias Setup — Run From Anywhere](#alias-setup--run-from-anywhere)
6. [Usage & Examples](#usage--examples)
7. [Troubleshooting](#troubleshooting)
8. [License / Copyright](#license--copyright)

---

## Overview

Quickly answer "what's eating space in this folder?" without opening a GUI. Point it at any directory (defaults to the current one) and get a sorted table of subfolder sizes.

---

## Features

- **Rich output** — human-readable size, exact bytes (comma-grouped), file count, folder name.
- **Two sort modes** — alphabetical (`-a`, default) or largest-first (`-s`).
- **Defaults to the current directory** when no folder is given.
- **CB9-styled** — dynamic-width header/footer, colors, and a legend showing the active sort.

---

## Requirements

| Requirement | Notes |
|-------------|-------|
| **macOS** (or Linux) | Uses `bash` and `du`. Shebang targets Homebrew bash (`/opt/homebrew/bin/bash`). |
| **Bash 4+** | For associative arrays / formatting. On macOS install via `brew install bash`. |

---

## Installation

```bash
git clone <REPOSITORY_URL> FolderSizes
cd FolderSizes
chmod +x folderSizes.sh
./folderSizes.sh -h
```

---

## Alias Setup — Run From Anywhere

Launch from any directory by typing `foldersizes`.

### macOS / Linux (zsh or bash)

Make it executable, then add to `~/.zshrc` or `~/.bashrc`:

```bash
chmod +x ~/path/to/FolderSizes/folderSizes.sh
alias foldersizes='~/path/to/FolderSizes/folderSizes.sh'
```

Reload and run:

```bash
source ~/.zshrc
foldersizes -s ~/Documents
```

**Alternative — symlink onto your `PATH`:**

```bash
ln -s ~/path/to/FolderSizes/folderSizes.sh /usr/local/bin/foldersizes
```

> **Windows:** run under **WSL** or **Git Bash** with `bash folderSizes.sh`.

---

## Usage & Examples

```
folderSizes.sh [-a] [-s] [-h] [FOLDER]
```

| Option | Meaning |
|--------|---------|
| `-a` | Sort alphabetically by folder name (default) |
| `-s` | Sort by size, largest first |
| `-h` | Show help and usage |
| `FOLDER` | Directory to scan (defaults to the current directory) |

**Examples:**

```bash
folderSizes.sh                       # current directory, alphabetical
folderSizes.sh -s ~/Documents        # ~/Documents, largest first
folderSizes.sh /Volumes/Media        # a specific volume
```

---

## Troubleshooting

| Symptom | Fix |
|---------|-----|
| `bad interpreter: /opt/homebrew/bin/bash` | Install Homebrew bash (`brew install bash`) or run via `bash folderSizes.sh`. |
| Sizes look slow on huge trees | `du` walks the whole tree; large volumes take time. |
| Permission denied on some folders | Run against paths you can read, or with appropriate permissions. |

---

## License / Copyright

---
**Version:** 1.3
**Author:** Cloud Box 9 Inc.
**Maintainer / Owner:** Cloud Box 9 Inc.
**Last Updated:** Jul 5, 2026

Copyright © 2026 Cloud Box 9 Inc. All rights reserved.
