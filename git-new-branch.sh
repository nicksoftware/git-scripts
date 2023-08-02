#!/bin/bash

# Function to print script usage
function print_usage {
    echo "Usage: $0 -t <type_flag> <branch_name>"
    echo "    -t <type_flag>: Type flag indicating the suffix to use (u, n, f)"
    echo "    <branch_name>: The name of the new branch to create"
    exit 1
}

# Check if number of arguments is correct
if [ "$#" -ne 3 ]; then
    print_usage
fi

# Parse the arguments
while getopts ":t:" opt; do
    case "$opt" in
        t)
            case "$OPTARG" in
                u|n|f)
                    type_flag="$OPTARG"
                    ;;
                *)
                    echo "Invalid type flag: $OPTARG"
                    print_usage
                    ;;
            esac
            ;;
        :)
            echo "Option -$OPTARG requires an argument."
            print_usage
            ;;
        \?)
            echo "Invalid option: -$OPTARG"
            print_usage
            ;;
    esac
done

# Shift the options, so $1 will be the branch name
shift $((OPTIND-1))

# Check if branch name is provided
if [ -z "$1" ]; then
    echo "Missing branch name."
    print_usage
fi

# Define the base branch to create the new branch from
base_branch="production"
branch_name="$1"

# Determine the suffix based on the type flag
case "$type_flag" in
    u)
        suffix="update/"
        ;;
    n)
        suffix="feat/"
        ;;
    f)
        suffix="fix/"
        ;;
esac

# Create the new branch
new_branch_name="${suffix}${branch_name}"
git checkout -b "$new_branch_name" "$base_branch"

echo "New branch '$new_branch_name' created from '$base_branch'."
