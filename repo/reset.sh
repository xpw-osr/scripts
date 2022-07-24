curDir=$(pwd)
curProject=

STATUS_FILE='./.repo.status.tmp'

show_result_message() {
    RET=$1
    SUCCEED_MSG="$2"
    FAILURE_MSG="$3"

    if [[ "${RET}" == "0" ]]; then
        echo "${SUCCEED_MSG}"
    else
        echo "${FAILURE_MSG}"
    fi
}

repo status > "${STATUS_FILE}"
if [[ "$?" != '0' ]]; then
    echo 'Error: failed to collect status of repo'
    exit 1
fi

cat "${STATUS_FILE}" | while read line; do
    if [[ "$(echo ${line} | grep '^project')" != "" ]]; then
        project=$(echo ${line} | awk '{print $2}')
        echo "### ${project} ###"
        if [[ "${curProject}" != "" ]]; then
            cd "${curDir}"
        fi
        cd "${project}"
        curProject=${project}
    else
        flag=$(echo ${line} | awk '{print $1}')
        path=$(echo ${line} | awk '{print $2}')

        echo -n "  ${path}"
        if [[ "${flag}" == "--" ]]; then
            if [ -d "${path}" ]; then
                rm -rf "${curDir}/${path}"
                show_result_message $? ' --- removed' ' --- failed to remove'
            else
                rm -f "${curDir}/${path}"
                show_result_message $? ' --- removed' ' --- failed to remove'
            fi
        elif [[ "${flag}" == "-m" ]]; then
            git checkout -f "${path}"
            show_result_message $? ' --- checked out' ' --- failed to checked out'
        elif [[ "${flag}" == "-d" ]]; then
            git checkout -f "${path}"
            show_result_message $? ' --- checked out' ' --- failed to checked out'
        fi
    fi
done
cd "${curDir}"

rm -f "${STATUS_FILE}"
