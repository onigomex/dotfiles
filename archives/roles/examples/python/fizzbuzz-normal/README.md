# examples/python/fizzbuzz-normal
- fizzbuzz
- test fizzbuzz
- normal(venv, pip)



## Setup
```
% python -m venv venv
% source venv/bin/activate
(venv)% pip install pytest
```



## Usage
```
% source venv/bin/activate
(venv) % python example/fizzbuzz.py
(venv) % python -m pytest tests/test_fizzbuzz.py
```



## Tips
### pytest 使用時の注意: python -m pytest で実行しておくのが無難
- [pytestした時にModuleNotFoundErrorが出る時の原因と対処法](https://zenn.dev/pesuchin/articles/9573476d53d234f09433)

```
(venv) % pytest tests/test_fizzbuzz.py
...
E   ModuleNotFoundError: No module named 'example'

# エラーが出るので __init__.py を各ディレクトリに追加して sys.path に通す。
(venv) % touch tests/__init__.py
...
(venv) % pytest tests/test_fizzbuzz.py
```

