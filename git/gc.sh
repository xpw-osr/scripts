#!/usr/bin/env sh

URL=$1

function check_result() {
  RET=$1
  MSG=$2

  if [ ${RET} -ne 0 ]; then
    echo ${MSG}
    exit ${RET}
  fi
}

function show_messages() {
    TITLE=$1
    CONTENT=$2

    echo "\n${TITLE}"
    echo "=========================================="
    echo "${CONTENT}"
    echo "=========================================="
}

echo "Cloning ${URL} ..."
MSG=`git clone "${URL}" 2>&1`
check_result $? "${MSG}"
REPO_FOLDER=$(echo "${MSG}" | awk '{split($0,s," "); print s[3]}' | sed "s/[\'|\.]//g")
echo "Repository is cloned into ./${REPO_FOLDER}"

if [ -d "./${REPO_FOLDER}" ]; then
    cd "./${REPO_FOLDER}"
    show_messages "Repository information" "$(git status)"

    echo "\nEnter user information"
    echo "=========================================="
    read -p 'user.name: ' username
    read -p 'user.email: ' useremail

    show_messages "Please Confirm:" "user.name: ${username}\nuser.email: ${useremail}"
    read -p "Only 'yes' for confirm: " confirm

    if [ "${confirm}" == "yes" ]; then
        git config --local user.name "${username}"
        git config --local user.email "${useremail}"

        RESULTS=$(git config --list | grep 'user.')
        if [ "${RESULTS}" == "" ]; then
            show_messages "Failed to add user info to configurations" "${RESULTS}"
            exit 1
        fi
        show_messages "Following configurations have been added:" "${RESULTS}"
    fi
fi

