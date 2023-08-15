# git-scripts

This contains the following scripts that i use to improve my dev speed

## The merge_to_staging.sh script

This script allows me to take my current changes on my branch and merge them to a staging branch this script allows you to set the following flags


- `-f` (force merge)
- `-p` (push to remote after merge)
- `-n` staging (-n should be followed by the name of the staging branch you want to merge to)

example:

```bash

#This will force merge to staging-nick then push to staging
/merge_to_staging.sh -f -p -n staging-nick
```

```bash

#this will merge to staging and push to remote
/merge_to_staging.sh -p
```

## The new_branch.sh script

There is the new_branch script that allows me to create a branch and prefix fix with the one of the following terms:

- `-f` /fix
- `-u` /update
- `-n` /feat

  Then followed by the name of the branch
  e.g

```bash

./new_branch.sh -n this-is-a-new-feature
./new_branch.sh -f this-is-a-fix
./new_branch.sh -u this-is-an-update

```

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
