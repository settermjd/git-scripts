#!/usr/bin/env bash

#
# This script simplifies the process of updating a branch to the latest version
# from the remote.  At this stage, it's rather simplistic, in that it assumes
# that the branch exists. It doesn't perform any branch validation.
#

set -e
set -o noclobber
set -o errexit
set -o pipefail
set -o nounset

ERR_INSUFFICIENT_ARGS=85

function usage()
{
    echo "Usage: update-branch <branch>"
}

function get_current_branch_name()
{
    echo $(git rev-parse --abbrev-ref HEAD)
}

function update_branch()
{
    local branch_name="$1"

    if [[ "$(get_current_branch_name)" != "${branch_name}" ]]; then
        git checkout "${branch_name}"
    fi 

    git fetch && git reset --hard origin/"${branch_name}"
}

(( $# != 1 )) && usage && exit $ERR_INSUFFICIENT_ARGS

update_branch $1
