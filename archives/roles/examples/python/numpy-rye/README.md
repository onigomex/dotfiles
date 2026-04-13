# examples/python/numpy-rye
- numpy
- rye



## Setup
```
% rye init .
% rye sync
% python -V
Python 3.12.5
% rye add numpy
% rye list
-e file:///Users/h20240108/src/github.com/onigomex/dotfiles/roles/examples/python/library
numpy==2.1.1
```



## Usage
※ 単に実行するだけであれば仮想環境への activate は不要だが、LSP を効かすためには ativate する必要がある。

```
% source .venv/bin/activate
[1 2 3 4 5]
(numpy-rye) % rye run python src/numpy_rye/example.py
[1 2 3 4 5]
1
(numpy-rye) % deactivate
```

