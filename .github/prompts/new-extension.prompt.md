---
name: new-extension
agent: Plan
description: Add a new pre-installed ComfyUI extension to the project
---

Add a new ComfyUI extension to this project. If the user provided a GitHub URL, derive `<owner>`, `<repo>`, and `<slug>` from it. Otherwise ask for the GitHub URL before proceeding.

The slug is lowercase and hyphen-separated (e.g. `comfyui-seedvr2-videoupscaler`).

Update the following three files, keeping all entries sorted **alphabetically** (by slug in `extensions.sh` and `requirements.in`, by GitHub owner in `README.md`):

## 1. `extensions.sh`

Add:
```sh
install_extension <slug> https://github.com/<owner>/<repo>.git
```

## 2. `requirements.in`

Fetch the repository's `requirements.txt` (if any) at:
`https://raw.githubusercontent.com/<owner>/<repo>/refs/heads/main/requirements.txt`

Add a block in the `# CUSTOM NODES` section:
```
# <slug>
# https://github.com/<owner>/<repo>
-r "https://raw.githubusercontent.com/<owner>/<repo>/refs/heads/main/requirements.txt"
```

- If the repo has no `requirements.txt`, comment out the `-r` line (`#-r ""`).
- If extra packages are needed beyond `requirements.txt`, add them on the lines immediately after the `-r` line.

After editing `requirements.in`, run `task lock` to regenerate `pylock.toml`.

## 3. `README.md`

Add a row to the `## Pre-installed extensions` table:
```
| [<owner>/<repo>](https://github.com/<owner>/<repo>) | <one-line description>. |
```

Align column widths to match surrounding rows.

## Checklist

- [ ] `extensions.sh` updated in alphabetical order
- [ ] `requirements.in` updated in alphabetical order
- [ ] `pylock.toml` regenerated via `task lock`
- [ ] `README.md` table row added in alphabetical order
