bind Space:magic-space
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH=~/bin:$PATH
export PATH=~/bin/alexbalan:$PATH
export PATH=$PATH:/Users/alexbalan/.rvm/bin
# in case git colors fuck up
export LESS="-rX"

. ~/bin/aliases
export INPUTRC=~/.inputrc

#history in no longer lost
export HISTCONTROL=erasedups
export HISTSIZE=1000000
shopt -s histappend

shopt -s checkwinsize


#from https://github.com/evilchelu/dotfiles/blob/master/.profile
# hack && ship
function current_git_branch {
  git branch 2> /dev/null | grep '\*' | awk '{print $2}'
}
 
hack()
{
  CURRENT=$(current_git_branch)
  git checkout master
  git pull origin master
  git checkout ${CURRENT}
  git rebase master
  unset CURRENT
}
 
ship()
{
  CURRENT=$(current_git_branch)
  git checkout master
  git merge ${CURRENT}
  git push origin master
  git checkout ${CURRENT}
  unset CURRENT
}


# completion
complete -C ~/.bash_completion.d/rake-complete.rb -o default rake
source ~/.bash_completion.d/git-completion.bash
complete -o default -o nospace -F _git gh


function git_current_branch {
  git branch 2>/dev/null | awk '/^\* /{print $2 }'
}
function git_dirty {
  git st 2> /dev/null | grep -c : | awk '{if ($1 > 0) print "*"}'
}
function git_formatted_current_branch_with_dirty {
  if [ -n "$(git_current_branch)" ]; then
echo " ($(git_current_branch)$(git_dirty))"
  fi
  #awk '{if ($(git_current_branch)) print " (" $(git_current_branch)$(git_dirty) ")"}'
}
function dollar_or_pound {
  if [ $(whoami) == "root" ]; then
echo "#"
  else
echo "$"
  fi
}
# bleh, el ugly :/
function git_status {
  if [ -n "$(git status 2>/dev/null)" ]; then
    #echo "$(git status 2>/dev/null)"
    echo "["
  else
echo "["
  fi
}
export PS1="\$(git_status)\u@\h \w\$(git_formatted_current_branch_with_dirty)]\$(dollar_or_pound) "

#loading rvm
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

