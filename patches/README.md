# Extension patches

Some extensions occasionally need a small local fix that isn't merged
upstream yet (a bug fix, a compatibility tweak, ...). Rather than forking the
extension, drop a patch here and it will be applied automatically every time
the extension is installed or updated (see `patch_extension` in
`entrypoint.sh`).

## Layout

```
patches/
└── <slug>/
    ├── 001-short-description.patch
    └── 002-another-fix.patch
```

- `<slug>` must match the extension's `install_extension` slug in
  `extensions.sh`.
- Patch files are applied in lexical order, hence the numeric prefix.
- An extension with no `patches/<slug>/` directory is left untouched.

See `_example/001-fix-deprecated-numpy-alias.patch` for a worked example
(fixing a `np.float` deprecated-alias crash in a fictitious node) — copy its
layout, renaming `_example` to the real extension's slug. `_example` itself
is never applied to anything: no extension is named `_example` in
`extensions.sh`.

## Creating a patch

From inside the extension's clone (e.g.
`$HOME/HDATA/$BASE_DIR/ComfyUI/custom_nodes/<slug>`), make your fix, then:

```sh
git diff > /path/to/comfyture.algonix/patches/<slug>/001-short-description.patch
```

## Notes

- `install_extension` always leaves the extension at a clean upstream state
  (fresh clone, or `git reset --hard` on update), so patches are re-applied
  on every container start — no manual reapplication needed.
- If a patch fails to apply (e.g. upstream changed the patched lines), the
  container will fail to start with a `git apply` error; refresh the patch
  against the new upstream code.
