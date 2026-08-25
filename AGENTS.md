# Agents

## Adding a new extension

When asked to add a new ComfyUI extension, update the following three files **in alphabetical order** by the extension slug / GitHub owner:

### 1. `extensions.sh`

Add an `install_extension` call:

```sh
install_extension <slug> https://github.com/<owner>/<repo>.git
```

- `<slug>` is lowercase, hyphen-separated (e.g. `comfyui-seedvr2-videoupscaler`).
- Keep entries sorted alphabetically by slug.

### 2. `requirements.in`

Add a block in the `CUSTOM NODES` section, sorted alphabetically by slug:

```plain
# <slug>
# https://github.com/<owner>/<repo>
-r "https://raw.githubusercontent.com/<owner>/<repo>/refs/heads/main/requirements.txt"
```

- If the repository has no `requirements.txt`, leave the `-r` line commented out (`#-r ""`).
- If the extension needs extra packages not in its `requirements.txt`, add them on the lines immediately after the `-r` line (see `comfyui-ipadapter-plus` for an example).
- After editing `requirements.in`, regenerate the lock file: `task lock`.

### 3. `README.md`

Add a row to the `## Pre-installed extensions` table, sorted alphabetically by GitHub owner:

```markdown
| [<owner>/<repo>](https://github.com/<owner>/<repo>) | <one-line description>. |
```

Align the columns to match the surrounding rows (use spaces to pad to the same column widths).

---

## Patching an extension

When an extension needs a local fix that isn't upstream yet, don't fork it — add a patch under `patches/<slug>/` instead. See `patches/README.md` for the format. It's applied automatically by `patch_extension` (called from `install_extension` in `entrypoint.sh`) on every install/update, so no wiring is needed elsewhere.

```sh
git diff > patches/<slug>/001-short-description.patch
```

---

### Checklist

- [ ] `extensions.sh` — `install_extension` line added in alphabetical order
- [ ] `requirements.in` — dependency block added in alphabetical order
- [ ] `pylock.toml` regenerated via `task lock`
- [ ] `README.md` — table row added in alphabetical order
