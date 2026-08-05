# roles/python
Python | uv で Python 本体・バージョン・パッケージ・仮想環境を一括管理する



## Dependencies
- homebrew



## Notes
- Python 管理は **uv**（Rust 製・高速）に一本化している。uv 1 つで pyenv / pip / venv / pipx 相当をまかなう。
- この role の責務は「uv を入れる」＋「デフォルトの最新 Python を入れる」まで。プロジェクト個別のバージョンや依存は uv のプロジェクト機能で扱う。
- **role 名を `uv` ではなく `python` にしている**のは、あくまで「Python を使えるようにする」ための role だから。将来 uv を置き換えるツールが出たら、この role の中身（実装）を差し替える。
- `install.sh` は `uv python install --default` で最新 Python を入れ、`python` / `python3` も PATH に張る。uv 管理の実行ファイルは `~/.local/bin` に置かれるため、`.zsh.d/python.zshrc.env` で同ディレクトリを PATH に通している。



## Usage
### バージョン管理
```
% uv python list --only-installed   # 導入済みだけ一覧
% uv python install 3.10            # 版を追加（導入済みなら DL せず検証のみ）
```

### デフォルト版を指定する（2 種類）
```
# (a) PATH の python / python3 が指す実体を変える。導入済みでも叩き直しでOK（DL は起きずリンク更新のみ）
% uv python install 3.12 --default

# (b) uv が使う既定版を .python-version で固定
% uv python pin --global 3.12       # 全体の既定
% uv python pin 3.12                # このプロジェクトだけ（グローバルより優先）
```

### プロジェクトで使う
```
% mkdir example; cd $_
% uv init .               # pyproject.toml / .python-version を生成
% uv python pin 3.10      # このプロジェクトの Python を固定
% uv add ruff             # 依存追加（自動で .venv 作成・解決）
% uv run ruff check       # 仮想環境内で実行
% uv run --python 3.10 python -V   # 特定版で単発実行
```



## References
- [astral-sh/uv](https://github.com/astral-sh/uv)
- [Installing and managing Python | uv](https://docs.astral.sh/uv/guides/install-python/)
