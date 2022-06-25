#!/usr/bin/env sh

# Used for cloning the project which includes the nested submodules
# For example
# ---------------------------------------------------------
#   Project Root
#     +- moduleA        // first level submodule
#     |  +- moduleB     // second level submodule
#     |  +- ...
#     +- ...
# ---------------------------------------------------------
REPO_URL="$1"
PROJECT_ROOT="$2"

if test -z "${PROJECT_ROOT}"; then
    PROJECT_ROOT=`git clone --recurse-submodules ${REPO_URL} ${PROJECT_ROOT} 2>&1 | tee /dev/tty | grep -o -P "(?<=Cloning into ').*(?='...)" | grep "^[^/]"`
else
    git clone --recurse-submodules ${REPO_URL} ${PROJECT_ROOT}
fi

cd ${PROJECT_ROOT}
git submodule foreach "
    git pull origin main --recurse-submodules
    git submodule | while read module; do
        git submodule update --init --recursive --  $(echo module | awk '{print $2}')
    done
"
