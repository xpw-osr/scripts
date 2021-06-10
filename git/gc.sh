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

echo "Cloning ${URL} ..."
MSG=`git clone "${URL}" 2>&1`
check_result $? "${MSG}"
REPO_FOLDER=$(echo "${MSG}" | awk '{split($0,s," "); print s[3]}' | sed "s/[\'|\.]//g")
echo "Repository is cloned into ./${REPO_FOLDER}"

if [ -d "./${REPO_FOLDER}" ]; then
    cd "./${REPO_FOLDER}"
    git status

    echo "\nSet Local Account"
    echo "=========================================="
    read -p 'user.name: ' username
    read -p 'user.email: ' useremail

    echo "\nPlease Confirm:"
    echo "=========================================="
    echo " user.name: ${username}"
    echo " user.email: ${useremail}"
    echo "=========================================="
    read -p "Only 'yes' for confirm: " confirm

    if [ "${confirm}" == "yes" ]; then
      git config --local user.name "${username}"
      git config --local user.email "${useremail}"
    fi
fi

