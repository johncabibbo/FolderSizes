# Folder Sizes

`folderSizes.sh` — a small macOS command-line tool that lists the size of each
**subfolder** inside a directory, with a human-readable size, exact byte count,
file count, and folder name. Results can be sorted alphabetically or by size.

- **Script:** `folderSizes.sh`
- **Version:** 1.3
- **Platform:** macOS
- **Maintainer:** Cloud Box 9 Inc.

---

## Requirements

- **macOS** (uses the BSD `du` flags `-sh` / `-sk`).
- **Bash** — the script's shebang points at Homebrew bash
  (`/opt/homebrew/bin/bash`). If you don't have it there, run it explicitly with
  `bash folderSizes.sh …`.
- Standard tools that ship with macOS: `du`, `tput`, `awk`, `sed`.

No installation or dependencies beyond the above.

---

## Usage

```bash
folderSizes.sh [-a] [-s] [FOLDER]
```

If `FOLDER` is omitted, the current directory is used.

Make it executable once, then run it:

```bash
chmod +x folderSizes.sh
./folderSizes.sh ~/Documents
```

Or run it via bash without changing permissions:

```bash
bash folderSizes.sh -s ~/Documents
```

Optionally add an alias:

```bash
alias foldersizes='~/Documents/scriptPublished_dist/FolderSizes/folderSizes.sh'
```

### Options

| Option | Description |
|--------|-------------|
| `-a`   | Sort alphabetically by folder name **(default)** |
| `-s`   | Sort by size, largest first |
| `-h`   | Show the help screen and exit |

---

## Output columns

| Column | Meaning |
|--------|---------|
| **Size (HR)** | Human-readable size (e.g. `1.2G`, `340M`) |
| **Size (Bytes)** | Exact size in bytes, comma-formatted |
| **File Count** | Total number of files inside the folder (recursive) |
| **Folder** | Subfolder name |

The header shows the target directory and the active sort mode; a legend lists
the available sort options. Output is color-coded and the header/footer scale to
your terminal width.

---

## Examples

```bash
# Current directory, alphabetical (default)
folderSizes.sh

# A specific volume, largest folders first
folderSizes.sh -s /Volumes/CB9-13Media/BPA_Media2025

# Your Documents folder, explicit alphabetical sort
folderSizes.sh -a ~/Documents
```

---

## Notes

- Only **immediate** subfolders of the target are listed (one level deep); the
  file count for each is counted recursively.
- Sizes come from `du`, which reports disk usage (allocated blocks) — this can
  differ slightly from the logical sum of file sizes.
- Press `Ctrl+C` at any time to exit cleanly.
