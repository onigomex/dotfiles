# roles/gron
JSON を 1 行 1 パスに展開して grep できるようにする



## Dependencies
- homebrew



## Usage
```
% curl "https://api.github.com/repos/tomnomnom/gron/commits?per_page=1"
[
  {
    "sha": "13561bd6339bff18ba571e62313b3f5a6db00111",
    "node_id": "C_kwDOAFdYP9oAKDEzNTYxYmQ2MzM5YmZmMThiYTU3MWU2MjMxM2IzZjVhNmRiMDAxMTE",
    "commit": {
      "author": {
        "name": "Tom Hudson",
        "email": "mail@tomnomnom.com",
        "date": "2022-04-13T14:23:37Z"
      },
      "committer": {
        "name": "Tom Hudson",
        "email": "mail@tomnomnom.com",
        "date": "2022-04-13T14:23:37Z"
      },
      "message": "Adds arm64 to build arch list",
      "tree": {
        "sha": "f1fdbe2c20bc4bb49e5ad85512242fb345254a7e",
        "url": "https://api.github.com/repos/tomnomnom/gron/git/trees/f1fdbe2c20bc4bb49e5ad85512242fb345254a7e"
      },
      "url": "https://api.github.com/repos/tomnomnom/gron/git/commits/13561bd6339bff18ba571e62313b3f5a6db00111",
      "comment_count": 0,
      "verification": {
        "verified": false,
        "reason": "unsigned",
        "signature": null,
        "payload": null
      }
    },
    "url": "https://api.github.com/repos/tomnomnom/gron/commits/13561bd6339bff18ba571e62313b3f5a6db00111",
    "html_url": "https://github.com/tomnomnom/gron/commit/13561bd6339bff18ba571e62313b3f5a6db00111",
    "comments_url": "https://api.github.com/repos/tomnomnom/gron/commits/13561bd6339bff18ba571e62313b3f5a6db00111/comments",
    "author": {
      "login": "tomnomnom",
      "id": 58276,
      "node_id": "MDQ6VXNlcjU4Mjc2",
      "avatar_url": "https://avatars.githubusercontent.com/u/58276?v=4",
      "gravatar_id": "",
      "url": "https://api.github.com/users/tomnomnom",
      "html_url": "https://github.com/tomnomnom",
      "followers_url": "https://api.github.com/users/tomnomnom/followers",
      "following_url": "https://api.github.com/users/tomnomnom/following{/other_user}",
      "gists_url": "https://api.github.com/users/tomnomnom/gists{/gist_id}",
      "starred_url": "https://api.github.com/users/tomnomnom/starred{/owner}{/repo}",
      "subscriptions_url": "https://api.github.com/users/tomnomnom/subscriptions",
      "organizations_url": "https://api.github.com/users/tomnomnom/orgs",
      "repos_url": "https://api.github.com/users/tomnomnom/repos",
      "events_url": "https://api.github.com/users/tomnomnom/events{/privacy}",
      "received_events_url": "https://api.github.com/users/tomnomnom/received_events",
      "type": "User",
      "site_admin": false
    },
    "committer": {
      "login": "tomnomnom",
      "id": 58276,
      "node_id": "MDQ6VXNlcjU4Mjc2",
      "avatar_url": "https://avatars.githubusercontent.com/u/58276?v=4",
      "gravatar_id": "",
      "url": "https://api.github.com/users/tomnomnom",
      "html_url": "https://github.com/tomnomnom",
      "followers_url": "https://api.github.com/users/tomnomnom/followers",
      "following_url": "https://api.github.com/users/tomnomnom/following{/other_user}",
      "gists_url": "https://api.github.com/users/tomnomnom/gists{/gist_id}",
      "starred_url": "https://api.github.com/users/tomnomnom/starred{/owner}{/repo}",
      "subscriptions_url": "https://api.github.com/users/tomnomnom/subscriptions",
      "organizations_url": "https://api.github.com/users/tomnomnom/orgs",
      "repos_url": "https://api.github.com/users/tomnomnom/repos",
      "events_url": "https://api.github.com/users/tomnomnom/events{/privacy}",
      "received_events_url": "https://api.github.com/users/tomnomnom/received_events",
      "type": "User",
      "site_admin": false
    },
    "parents": [
      {
        "sha": "badf401da553eb41b7ffde4be6a64809ed0ed846",
        "url": "https://api.github.com/repos/tomnomnom/gron/commits/badf401da553eb41b7ffde4be6a64809ed0ed846",
        "html_url": "https://github.com/tomnomnom/gron/commit/badf401da553eb41b7ffde4be6a64809ed0ed846"
      }
    ]
  }
]

% gron "https://api.github.com/repos/tomnomnom/gron/commits?per_page=1" | grep "commit.author" 
json[0].commit.author = {};
json[0].commit.author.date = "2022-04-13T14:23:37Z";
json[0].commit.author.email = "mail@tomnomnom.com";
json[0].commit.author.name = "Tom Hudson";

% gron "https://api.github.com/repos/tomnomnom/gron/commits?per_page=1" | grep "commit.author" | gron -u
[
  {
    "commit": {
      "author": {
        "date": "2022-04-13T14:23:37Z",
        "email": "mail@tomnomnom.com",
        "name": "Tom Hudson"
      }
    }
  }
]
```



## References
- [tomnomnom/gron: Make JSON greppable!](https://github.com/TomNomNom/gron)

