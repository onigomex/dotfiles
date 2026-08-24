# roles/docker
コンテナを扱う CLI。実行基盤は colima 側が担う



## Dependencies
- homebrew



## Usage
```
docker ps             # 動いているコンテナ
docker run -it <image> <cmd>
docker compose up -d
```
**実行基盤は colima。** `Cannot connect to the Docker daemon` が出たら `colima start` を先に。



## References
- [Docker](https://github.com/docker)
- [moby/moby: The Moby Project - a collaborative project for the container ecosystem to assemble container-based systems](https://github.com/moby/moby)

