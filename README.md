# `qwrtln/po4a-action`

Run [po4a](https://github.com/mquinson/po4a) in your GitHub workflows.

## Usage

### Inputs

```yaml
- uses: qwrtln/po4a-action@v1
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
```

## Examples

### Generate translations

```yaml
- uses: qwrtln/po4a-action@v1
  with:
    version: "0.73"
    config: "po4a.cfg"
    args: "--no-update"
```

### Upload pot and po files and show git changes

```yaml
- uses: actions/checkout@v4

- name: Run po4a
  uses: qwrtln/po4a-action@v1
  with:
    version: "0.73"
    config: "po4a.cfg"
    args: "--no-translations"

- name: Show git changes
  run: git status --porcelain translations
```
