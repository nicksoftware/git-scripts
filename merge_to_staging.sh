#!/bin/bash

# Function to print script usage
function print_usage {
    echo "Usage: $0 [-p] [-f] [-n <staging_branch_name>]"
    echo "    -p: Push the changes to the remote staging branch"
    echo "    -f: Override staging with the current branch"
    echo "    -n <staging_branch_name>: Specify a name for the staging branch"
    exit 1
}

# Parse the arguments
push_to_remote=false
override_staging=false
staging_branch_name="staging"  # Default staging branch name

while getopts ":pfn:" opt; do
    case "$opt" in
        p)
            push_to_remote=true
            ;;
        f)
            override_staging=true
            ;;
        n)
            staging_branch_name="$OPTARG"
            ;;
        \?)
            echo "Invalid option: -$OPTARG"
            print_usage
            ;;
    esac
done

# Check if both -p and -f flags are provided (which is not allowed)
if [ "$push_to_remote" = true ] && [ "$override_staging" = true ]; then
    echo "Error: The -p and -f options cannot be used together."
    print_usage
fi

# Get the current branch name
current_branch=$(git symbolic-ref --short HEAD)

# Check if the staging branch exists
if ! git show-ref --quiet refs/heads/"$staging_branch_name"; then
    echo "Error: The '$staging_branch_name' branch does not exist in the repository."
    exit 1
fi

# Override staging with the current branch if -f flag is provided
if [ "$override_staging" = true ]; then
    git checkout -B "$staging_branch_name" "$current_branch"
    echo "Staging branch overridden with the current branch: '$current_branch'."
else
    # Merge the current branch into the staging branch
    git checkout "$staging_branch_name"
    git merge "$current_branch"

    # Check if merge was successful
    if [ $? -eq 0 ]; then
        echo "Merge successful: '$current_branch' merged into '$staging_branch_name'."
    else
        echo "Merge failed. Please resolve conflicts and try again."
        exit 1
    fi
fi

# Optionally push the changes to the remote staging branch
if [ "$push_to_remote" = true ]; then
    git push origin "$staging_branch_name"
    if [ $? -eq 0 ]; then
        echo "Changes pushed to remote '$staging_branch_name'."
    else
        echo "Error: Failed to push changes to remote '$staging_branch_name'."
        exit 1
    fi
fi

# Switch back to the original branch
git checkout "$current_branch"
