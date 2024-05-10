# Dotfiles symlinked on my machine

### Install basics and stow:

```bash
bin/bash ./setup-script/mac-linux-setup.sh
```

### Install with stow:

```bash
git add .
git commit -am "updated stow files"
stow --adopt -nv .config --target ~/.config
stow --adopt -nv home --target ~
```
