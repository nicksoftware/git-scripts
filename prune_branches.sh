#!/bin/bash

# Function to print script usage
function print_usage {
    echo "Usage: $0 [-r] [-e <branch1,branch2,...>]"
    echo "    -r: Also prune remote branches"
    echo "    -e <branch1,branch2,...>: Exclude branches from pruning"
    exit 1
}

# Parse the arguments
prune_remote=false
exclusion_list=""
while getopts ":re:" opt; do
    case "$opt" in
        r)
            prune_remote=true
            ;;
        e)
            exclusion_list="$OPTARG"
            ;;
        \?)
            echo "Invalid option: -$OPTARG"
            print_usage
            ;;
    esac
done

# Convert the exclusion list to an array
IFS=',' read -ra excluded_branches <<< "$exclusion_list"

# Function to check if a branch should be pruned
function should_prune {
    local branch="$1"
    for excluded_branch in "${excluded_branches[@]}"; do
        if [ "$branch" == "$excluded_branch" ]; then
            return 1
        fi
    done
    return 0
}

# Get the list of local branches, excluding excluded branches
branches=$(git branch | grep -vE "^\s*(staging|production)")
filtered_branches=""

for branch in $branches; do
    if should_prune "$branch"; then
        filtered_branches="$filtered_branches $branch"
    fi
done

# Confirm with the user before pruning
echo "The following branches will be pruned:"
echo "$filtered_branches"
read -p "Are you sure you want to prune these branches? (y/n): " confirm

if [ "$confirm" != "y" ] && [ "$confirm" != "Y" ]; then
    echo "Aborted."
    exit 0
fi

# Prune the local branches
for branch in $filtered_branches; do
    git branch -d "$branch"
done

echo "Local branches pruned."

# Prune remote branches if -r flag is provided
if [ "$prune_remote" = true ]; then
    for branch in $filtered_branches; do
        git push origin --delete "$branch"
    done
    echo "Remote branches pruned."
fi
