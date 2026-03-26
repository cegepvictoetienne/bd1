# Migrate mkdocs.yml to zensical.toml

Instructions for Claude Code to convert an existing MkDocs site to Zensical.

## Steps

### 1. Read the existing config

Read `mkdocs.yml` in the project root.

### 2. Create `zensical.toml`

Create a `zensical.toml` file in the project root using the rules below.

---

## Conversion rules

### Site metadata

```toml
[project]
site_name = "..."
site_url = "..."
```

---

### Navigation

The nav is a TOML array assigned directly under `[project]`. Each entry is an inline table:

- Single page: `{"Title" = "path/to/file.md"}`
- Section with pages: `{"Title" = ["path1.md", "path2.md"]}`
- Section with named sub-pages: `{"Title" = [{"Sub title" = "path.md"}, ...]}`
- Nested sections follow the same pattern recursively.

```toml
nav = [
  {"Accueil" = "index.md"},
  {"Section" = [
    {"Page A" = "section/page-a.md"},
    {"Sub-section" = [
      {"Page B" = "section/sub/page-b.md"},
    ]},
  ]},
]
```

---

### Theme

```toml
[project.theme]
name = "material"
variant = "classic"
favicon = "images/favicon.png"
language = "fr"
features = [
  "navigation.tabs",
  "navigation.tabs.sticky",
  "navigation.tracking",
  "content.code.copy",
  "toc.integrate",
]

[project.theme.icon]
logo = "fontawesome/solid/bookmark"

[project.theme.icon.admonition]
note = "fontawesome/solid/note-sticky"
# ... other admonition icons

[[project.theme.palette]]
scheme = "slate"
primary = "deep purple"
accent = "blue"
```

---

### Plugins

```toml
[project.plugins]
search = {}
```

---

### Classic theme
Be sure to add this to the [project.theme]:

variant = "classic"

### Markdown extensions

Do not convert Markdown extensions.

---

### 3. Verify

After creating the file, confirm all nav entries from `mkdocs.yml` are present in `zensical.toml`.
