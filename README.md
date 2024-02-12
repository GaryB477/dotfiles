Note: This repo was heavily inspired by https://github.com/venthur/dotfiles

# Dotfiles

```
git clone git@github.com:GaryB477/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
make    #yes, make
```

stow will automatically symlink the contents of each "package" into the parent directory from where it is invoked (i.e. your home directory), that's why it is important to clone this repository directly into your home directory. If you cloned the repository somewhere else, you can use the --target parameter.

## How to add a new package
```
cp -r /path/to/config ~/.dotfiles/{pkgname}
cd ~/.dotfiles
make
```

## How to remove all dotfiles
```
cd ~/.dotfiles
make delete
```

## Nice to know
There is currently a bug, causing the stow to throw harmless errors like these:
```
BUG in find_stowed_path? Absolute/relative mismatch between Stow dir .dotfiles and path /home/user/.local/some/fancy/path at /usr/share/perl5/Stow.pm line 966, <DATA> line 22.
```
See here "https://github.com/aspiers/stow/issues/65".
