# `qwrtln/po4a-action`

Run [po4a](https://github.com/mquinson/po4a) in your GitHub workflows.

## Usage

### Inputs

```yaml
- uses: qwrtln/po4a-action@v1.2
  with:
    # Version of po4a to use.
    # 0.69-0.73 are supported.
    # Required
    version:

    # Path to your po4a configuration file, e.g., po4a.cfg
    # Required.
    config:

    # Additional arguments to pass to po4a, e.g., --no-update
    # Optional. Defaults to nothing.
    args:

    # Specific language to process (e.g., pl, fr, de).
    # If not specified, processes all languages defined in po4a.cfg.
    # Works by replacing [po4a_langs] ... line with [po4a_langs] <language>
    # Optional. Defaults to nothing (processing all languages).
    language:
```

## Examples

### Generate translations for all languages

```yaml
- uses: qwrtln/po4a-action@v1.2
  with:
    version: "0.73"
    config: "po4a.cfg"
    args: "--no-update"
```

### Generate translations for a specific language only

```yaml
- uses: qwrtln/po4a-action@v1.2
  with:
    version: "0.73"
    config: "po4a.cfg"
    args: "--no-update"
    language: "fr"
```

### Update pot and po files and list them with git

```yaml
- uses: actions/checkout@v4

- name: Run po4a
  uses: qwrtln/po4a-action@v1.2
  with:
    version: "0.73"
    config: "po4a.cfg"
    args: "--no-translations"

- name: Show git changes
  run: git status --porcelain
```

### Matrix build for multiple languages separately

```yaml
strategy:
  matrix:
    language: [de, fr, es, pl]

steps:
- uses: actions/checkout@v4

- name: Run po4a for ${{ matrix.language }} language
  uses: qwrtln/po4a-action@v1.2
  with:
    version: "0.73"
    config: "po4a.cfg"
    language: ${{ matrix.language }}
```
