# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Add cursor ide to path
export PATH="$PATH:/mnt/c/Users/shawn/AppData/Local/Programs/cursor/resources/app/bin"

# Add git fork ide to path
alias fork='/mnt/c/Windows/System32/cmd.exe /c "%USERPROFILE%\\AppData\Local\Fork\Fork.exe "$(wslpath -w -a .)'

# eval "$(~/.local/bin/mise activate zsh)"
alias l="exa \
--long --header --modified --no-user \
--icons --group-directories-first"
alias ls="exa --icons --grid --classify --colour=auto --sort=type --group-directories-first --header --modified --created --binary --group"
alias g="cd ~/documents/github; l"

CODE_WIN_PATH="$(which code)"
CURSOR_WIN_PATH="$(which cursor)"

# overwrite cursor script with the vscode one
cp "$CODE_WIN_PATH" "$CURSOR_WIN_PATH"

# replace vscode vars and paths with cursor ones
# APP_NAME should not be replaced, since .cursor-server remote-cli still gets downloaded and extracted as "code" executable
#sed -i 's|APP_NAME="code"|APP_NAME="cursor"|' $CURSOR_WIN_PATH
sed -i 's|NAME="Code"|NAME="Cursor"|' $CURSOR_WIN_PATH
sed -i 's|SERVERDATAFOLDER=".vscode-server"|SERVERDATAFOLDER=".cursor-server"|' $CURSOR_WIN_PATH
sed -i -E 's|VSCODE_PATH=".+"|VSCODE_PATH="$(dirname "$(dirname "$(dirname "$(dirname "$(realpath "$0")")")")")"|' $CURSOR_WIN_PATH

# fix output from the Cursor in CLI
sed -i -E 's|WSL_EXT_WLOC=(.+)|WSL_EXT_WLOC=$(tail -1 /tmp/remote-wsl-loc.txt)|' $CURSOR_WIN_PATH

eval "$(~/.local/bin/mise activate zsh)"
eval "$(starship init zsh)"

