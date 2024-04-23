# Dotfiles symlinked on my machine

### Install basics and stow:

```bash
bin/bash ./setup-script/mac-linux-setup.sh
```

### Install with stow:

```bash
cd ./.config
stow --target ~/.config .
cd ./HOME
stow --target ~/ */
# stow --target ~/ */
```
