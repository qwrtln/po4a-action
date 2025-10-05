# `qwrtln/po4a-action`

Run [po4a](https://github.com/mquinson/po4a) in your GitHub workflows.

## Usage

### Inputs

```yaml
- uses: qwrtln/po4a-action@v1.4
  with:
    # Version of po4a to use.
    # As of 1.4, only 0.74 is supported.
    # Use 1.3 if you need versions 0.69-0.73.
    # Required
    version:

    # Path to your po4a configuration file, e.g., po4a.cfg
    # Required.
    config:

    # Additional arguments to pass to po4a, e.g., --no-update
    # Optional. Defaults to nothing.
    args:

    # Specific language to process (e.g., pl, fr, de).
    # Works by passing --target-lang argument to po4a.
    # Optional. Defaults to all languages specified in configuration file.
    language:
```

## Examples

### Generate translations for all languages

```yaml
- uses: qwrtln/po4a-action@v1.4
  with:
    version: "0.74"
    config: "po4a.cfg"
    args: "--no-update"
```

### Generate translations for a specific language only

```yaml
- uses: qwrtln/po4a-action@v1.4
  with:
    version: "0.74"
    config: "po4a.cfg"
    args: "--no-update"
    language: "fr"
```

### Update pot and po files and list them with git

```yaml
- uses: actions/checkout@v4

- name: Run po4a
  uses: qwrtln/po4a-action@v1.4
  with:
    version: "0.74"
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
  uses: qwrtln/po4a-action@v1.4
  with:
    version: "0.74"
    config: "po4a.cfg"
    language: ${{ matrix.language }}
```
