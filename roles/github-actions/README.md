# roles/github-actions
You can discover, create, and share actions to perform any job you'd like, including CI/CD, and combine actions in a completely customized workflow.



## Dependencies
- homebrew



## Debug
- [Contexts - GitHub Docs](https://docs.github.com/en/actions/learn-github-actions/contexts#example-printing-context-information-to-the-log)

```
name: Context testing
on: push

jobs:
  dump_contexts_to_log:
    runs-on: ubuntu-latest
    steps:
      - name: Dump GitHub context
        id: github_context_step
        run: echo '${{ toJSON(github) }}'
      - name: Dump job context
        run: echo '${{ toJSON(job) }}'
      - name: Dump steps context
        run: echo '${{ toJSON(steps) }}'
      - name: Dump runner context
        run: echo '${{ toJSON(runner) }}'
      - name: Dump strategy context
        run: echo '${{ toJSON(strategy) }}'
      - name: Dump matrix context
        run: echo '${{ toJSON(matrix) }}'
```



## Lint/actionlint
- [rhysd/actionlint: Static checker for GitHub Actions workflow files](https://github.com/rhysd/actionlint)
- [actionlint playground](https://rhysd.github.io/actionlint/)
- [GitHub Actions のワークフローをチェックする actionlint をつくった - はやくプログラムになりたい](https://rhysd.hatenablog.com/entry/2021/07/11/214313)
- [actionlint v1.4 → v1.6 で実装した新機能の紹介 - はやくプログラムになりたい](https://rhysd.hatenablog.com/entry/2021/08/11/221044)



## References
- [Actions | GitHub](https://github.co.jp/features/actions)
- [GitHub Actions Documentation - GitHub Docs](https://docs.github.com/en/actions)

