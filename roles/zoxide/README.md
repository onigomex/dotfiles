# roles/zoxide
よく行くディレクトリへ z で飛ぶ。cd の代替



## Dependencies
- homebrew



## Usage
```
z foo              # cd into highest ranked directory matching foo
z foo bar          # cd into highest ranked directory matching foo and bar
z foo /            # cd into a subdirectory starting with foo

z ~/foo            # z also works like a regular cd command
z foo/             # cd into relative path
z ..               # cd one level up
z -                # cd into previous directory

zi foo             # cd with interactive selection (using fzf)

z foo<SPACE><TAB>  # show interactive completions (zoxide v0.8.0+, bash 4.4+/fish/zsh only)
```


### zoxide settings
```
% zoxide --help

zoxide v0.8.1
Ajeet D'Souza <98ajeet@gmail.com>
A smarter cd command for your terminal

USAGE:
    zoxide <SUBCOMMAND>

OPTIONS:
    -h, --help       Print help information
    -V, --version    Print version information

SUBCOMMANDS:
    add       Add a new directory or increment its rank
    import    Import entries from another application
    init      Generate shell configuration
    query     Search for a directory in the database
    remove    Remove a directory from the database

ENVIRONMENT VARIABLES:
    _ZO_DATA_DIR            Path for zoxide data files
    _ZO_ECHO                Print the matched directory before navigating to it when set to 1
    _ZO_EXCLUDE_DIRS        List of directory globs to be excluded
    _ZO_FZF_OPTS            Custom flags to pass to fzf
    _ZO_MAXAGE              Maximum total age after which entries start getting deleted
    _ZO_RESOLVE_SYMLINKS    Resolve symlinks when storing paths
```



## References
- [ajeetdsouza/zoxide: A smarter cd command. Supports all major shells.](https://github.com/ajeetdsouza/zoxide)

