# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# 消除历史中的重复条目
setopt HIST_IGNORE_DUPS
setopt appendhistory autocd beep extendedglob nomatch notify
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/drlin/.zshrc'
autoload -Uz compinit promptinit
compinit
promptinit
# End of lines added by compinstall
# 方向键控制的自动补全
#zstyle ':completion:*' menu select
# End
#
#Currently available prompt themes:
#adam1 adam2 bart bigfade clint elite2 elite fade fire off oliver pws redhat suse walters zefram
#prompt adam2
# oh-my-zsh
#plugins=(git archlinux history mvn python git-extras textmate lighthouse autojump)
# 自定义命令提示符
autoload -U colors && colors
PROMPT="%{$fg[blue]%}%n%{$reset_color%}@%{$fg[red]%}%m %{$fg[yellow]%}%1~ %{$reset_color%}%# "
RPROMPT="[%{$fg[yellow]%}%?%{$reset_color%}]"
#标题栏、任务栏样式{
#case $TERM in (*xterm*|*rxvt*|(dt|k|E)term)
#precmd () {print -Pn "\e]0;%n@%M//%/\a" }
#preexec () {print -Pn "\e]0;%n@%M//%/\ $1\a"}
#;;
#esac
#Title set
#set_title() 
#{
#	ORIG=$PS1
#	TITLE="\e]2;$*\a"
#	PS1=${ORIG}${TITLE}
#}
# 锁定/解锁终端
ttyctl -f
# 文件管理器的快捷键绑定
cdUndoKey() {
	popd      > /dev/null
	zle       reset-prompt
	echo
	ls
	echo
}
cdParentKey() {
	pushd .. > /dev/null
	zle      reset-prompt
	echo
	ls
	echo
}
zle -N                 cdParentKey
zle -N                 cdUndoKey
bindkey '^[[1;3A'      cdParentKey
bindkey '^[[1;3D'      cdUndoKey
# 目录栈(dirstack)
DIRSTACKFILE="$HOME/.cache/zsh/dirs"
if [[ -f $DIRSTACKFILE ]] && [[ $#dirstack -eq 0 ]]; then
	dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
	[[ -d $dirstack[1] ]] && cd $dirstack[1]
fi
chpwd(){
	print -l $PWD ${(u)dirstack} >$DIRSTACKFILE
}
DIRSTACKSIZE=20
setopt AUTO_PUSHD PUSHD_SILENT PUSHD_TO_HOME
## Remove duplicate entries
setopt PUSHD_IGNORE_DUPS
## This reverts the +/- operators.
setopt PUSHD_MINUS
#仿Fish命令高亮
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# Help command
autoload -U run-help
autoload run-help-git
autoload run-help-svn
autoload run-help-svk
#unalias run-help
alias help=run-help
#刷新自动补全
zstyle ':completion:*' rehash true
export LS_OPTIONS="--color=auto -N -T 0"
alias ls="ls $LS_OPTIONS"
alias ll="ls -l"
alias lf="ls -F"
alias la="ls -a"
#export VISUAL="vim"
export EDITOR=vim
bindkey -v
#virtualenvwrapper settings
#if [ -f /usr/local/bin/virtualwrapper.sh ]; then
#    export WORKON_HOME=$HOME/.virtualenvs
#    source /usr/local/bin/virtualenvwrapper.sh
#fi
#export path
export PATH=/home/drlin/opt/FriendlyARM/toolschain/4.5.1/bin:/home/drlin/Android/Sdk/platform-tools:$PATH
# TensorFlow environment variable responsible for the logs, to silence INFO logs set it to 1, to filter out WARNING 2 and to additionally silence ERROR logs (not recommended) set it to 3
export TF_CPP_MIN_LOG_LEVEL=2
