set -x LSCOLORS 'gxfxfxfxcxdxdxhbadbxbx'

function parse_git_branch
  # make sure the directory is a git repo 
  if not is-git
    return
  end
            
  if has-git-changes
    set_color white
  else
    set_color white
  end
  echo -n ' /'
  set -l branch (env git symbolic-ref -q HEAD)
  if test ! -z "$branch"
    echo -n $branch | sed -e 's/refs\/heads\///'
  else
    git name-rev --name-only HEAD ^/dev/null
  end
end

for p in /usr/bin /usr/local/bin /usr/local/mysql/bin ~/.gem/bin ~/.gem/ruby/1.8/bin ~/bin ~/.config/fish/bin 
	if test -d $p
		set -x PATH $p $PATH
	end
end

set -x EDITOR "vim"

set fish_greeting ""
set -x CLICOLOR 1

set -x BROWSER open

cd ~

set -x JAVA_HOME "/System/Library/Frameworks/JavaVM.framework/Versions/1.6/Home"


# pull in a local, ignored-by-git config file
if test -f ~/.config/fish/config.local.fish
  . ~/.config/fish/config.local.fish
end

function fish_prompt --description "Write out the prompt"
  printf "%s%s%s%s%s:" (set_color cyan) (prompt_pwd) (parse_git_branch) (set_color cyan)
  set_color normal
  printf ' '
end
