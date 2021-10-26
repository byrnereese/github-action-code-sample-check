# GitHub Action - Code sample checker ️

This GitHub action scans a folder (recursively if desired) for a set of code samples, evaluates them to ensure that they compile and run properly. This action is a wrapper around the [codechecker-mkdocs python script](https://github.com/byrnereese/codechecker-mkdocs), and is heavily inspired by:

* [tcort/markdown-link-check](https://github.com/tcort/markdown-link-check)
* [gaurav-nelson/github-action-markdown-link-check](https://github.com/gaurav-nelson/github-action-markdown-link-check)

## How to use

1. Create a new file in your repository `.github/workflows/action.yml`.
1. Copy-paste the following workflow in your `action.yml` file:

   ```yml
   name: Check code samples
   
   on: push
   
   jobs:
     code-sample-check:
       runs-on: ubuntu-latest
       steps:
       - uses: actions/checkout@master
       - uses: byrnereese/github-action-code-sample-check@v1
   ```

### Real-life usage samples

Following is a list of some of the repositories which are using GitHub Action -
Markdown link check.

1. [RingCentral API documentation](https://github.com/ringcentral/ringcentral-api-docs/)
   
*(Edit this file and add your name here)*

## Configuration

- [Custom variables](#custom-variables)
- [Scheduled runs](#scheduled-runs)
- [Disable check for some links](#disable-check-for-some-links)

### Custom variables

You customize the action by using the following variables:

| Variable  | Description   | Default value |
|:----------|:--------------|:--------------|
|`excludes` | One or more patterns to identify links that can be excluded or skipped in your tests. | *None* |
|`folder-path` |By default the `github-action-mkdocs-link-check` action checks for all markdown files in your repository, which typically are located in the `docs` directory for mkdocs projects. Use this option to limit checks to only specific folders. |`docs/` |
|`syntax-only` | Process code samples for syntax validity only. | `false` |
|`languages` | A comma-delimited list of languages to check. | `all` |
|`recurse` |Recurse through the entire directory tree below the specified path.|`true` |
|`verbose-mode`|Specify `yes` to show detailed HTTP status for checked links. |`no` |

#### Sample workflow with variables

```yml
name: Check code samples

on: push

jobs:
  code-sample-check:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - uses: byrnereese/github-action-code-sample-check@v1
      with:
        use-verbose-mode: 'yes'
        folder-path: 'code-samples/'
```

### Scheduled runs

In addition to checking code samples on every push, or pull request, it is also a good hygine practice to check code samples regularly as well in case errors have been introduced by newer SDKs or software libaries. See [Workflow syntax for GitHub Actions - on.schedule](https://help.github.com/en/actions/reference/workflow-syntax-for-github-actions#onschedule) for more details.

#### Sample workflow with scheduled job

```yml
name: Check Markdown links

on: 
  push:
    branches:
    - master
  schedule:
  # Run everyday at 9:00 AM (See https://pubs.opengroup.org/onlinepubs/9699919799/utilities/crontab.html#tag_20_25_07)
  - cron: "0 9 * * *"

jobs:
  code-sample-check:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - uses: byrnereese/github-action-code-sample-check@v1
      with:
        use-verbose-mode: 'yes'
        folder-path: 'code-samples/'
```

## Versioning

GitHub Action - Markdown link check follows the [GitHub recommended versioning strategy](https://github.com/actions/toolkit/blob/master/docs/action-versioning.md). 

1. To use a specific released version of the action ([Releases](https://github.com/byrnereese/github-action-code-sample-check/releases)):
   ```yml
   - uses: byrnereese/github-action-code-sample-check@1.0.1
   ```
1. To use a major version of the action:
   ```yml
   - uses: byrnereese/github-action-code-sample-check@v1
   ```
1. You can also specify a [specific commit SHA](https://github.com/byrnereese/github-action-code-sample-check/commits/master) as an action version:
   ```yml
   - uses: byrnereese/github-action-code-sample-check@44a942b2f7ed0dc101d556f281e906fb79f1f478
   ```
