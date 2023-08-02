# git-scripts




# More stuff 

In addition to the git scripts I've set the following bash alias to use :


```
#System Aliases

alias cls='clear'
alias ll='ls -alF'
alias l='ls -CF'
alias la='ls -A'

#dotnet
alias ds='dotnet-script'
alias dn='dotnet'


#PHP Stuff
alias sl='./vendor/bin/sail'
alias sla='./vendor/bin/sail artisan'
alias slat='./vendor/bin/sail artisan tinker'
alias slc='./vendor/bin/sail composer'
alias sln='./vendor/bin/sail npm'
alias sail='./vendor/bin/sail'


#git stuff

alias gcm='git commit -m'
alias ga='git add .'
alias gac='git add . && git commit -m'
alias gpl='git pull'

alias gbn='~/projects/git-scripts/create_new_branch.sh -t n'
alias gbu='~/projects/git-scripts/create_new_branch.sh -t u'
alias gbf='~/projects/git-scripts/create_new_branch.sh -t f'
alias gs='~/projects/git-scripts/merge_to_staging.sh'

#npm stuff
alias npi='npm install'
alias npu='npm update'
alias npd='npm run dev'

```
