# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="powerlevel10k/powerlevel10k"
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# fzf keybinds
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Used on NixOS
if [ -n "${commands[fzf-share]}" ]; then
        source "$(fzf-share)/key-bindings.zsh"
        source "$(fzf-share)/completion.zsh"
        alias  "nr"="sudo nixos-rebuild switch --flake /home/marc/git/private/linux/nixos#work_dg --impure"
        alias  "ns"="nix-search"
else
        # Plugin installation:

        # autosuggestions --> "git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"

        # zsh-syntax-highlighting --> "sudo apt install -y zsh-syntax-highlighting && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"

        # fzf --> "git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install"

        # ..
        # then "source ~/.zshrc"
        plugins=(
                git
                zsh-autosuggestions
                z)
        source $ZSH/oh-my-zsh.sh
fi

# Various keybinds
bindkey '^ ' autosuggest-accept
setxkbmap -option caps:escape

ENABLE_CORRECTION="true"

# Enable new docker buildkit
export DOCKER_BUILDKIT=1

#fix ssh issues with kitty
[ "$TERM" = "xterm-kitty" ] && alias ssh="kitty +kitten ssh"

# Aliases
alias rm="echo Use 'del', or the full path i.e. '/bin/rm' && cat ~/.monkey"
alias t="tree -L 2"
alias "cp"="rsync -ah --progress"
alias "apt"="nala"
alias "apt-get"="nala"
alias "vim"="nvim"
