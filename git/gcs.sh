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

recurse_submodules() {
    SUBMODULE_FOLDER="$1"
    cd "${SUBMODULE_FOLDER}"

    git submodule update --init
    git pull origin main

    git submodule | awk '{print $2}' | while read submodule; do
        recurse_submodules "${submodule}"
    done
}

REPO_URL="$1"
PROJECT_ROOT="$2"

if test -z "${PROJECT_ROOT}"; then
    PROJECT_ROOT=`git clone ${REPO_URL} ${PROJECT_ROOT} 2>&1 | tee /dev/tty | grep -o -P "(?<=Cloning into ').*(?='...)" | grep "^[^/]"`
else
    git clone ${REPO_URL} ${PROJECT_ROOT}
fi

cd ${PROJECT_ROOT}
git submodule | awk '{print $2}' | while read submodule; do
    recurse_submodules ${submodule}
done