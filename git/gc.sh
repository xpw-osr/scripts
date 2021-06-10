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

MSG=$(git clone "${URL}")
check_result $? ${MSG}

read -p 'user.name: ' username
read -p 'user.email: ' useremail

echo "Please Confirm:"
echo " user.name: ${username}"
echo " user.email: ${useremail}"

read -p "Only 'yes' for confirm: " confirm
if [ "${confirm}" == "yes" ]; then
  git config --local user.name "${username}"
  git config --local user.email "${useremail}"
fi
