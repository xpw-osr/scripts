curDir=$(pwd)
curProject=

STATUS_FILE='./.repo.status.tmp'

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
            ## TODO: need check the path is file or dir
            rm -f "${path}"
            if [[ "$?" == "0" ]]; then
                echo ' --- removed'
            else
                echo ' --- failed to remove'
            fi
        elif [[ "${flag}" == "-m" ]]; then
            git checkout -f "${path}"
            if [[ "$?" == "0" ]]; then
                echo ' --- removed'
            else
                echo ' --- failed to remove'
            fi
        elif [[ "${flag}" == "-d" ]]; then
            git checkout -f "${path}"
            if [[ "$?" == "0" ]]; then
                echo ' --- removed'
            else
                echo ' --- failed to remove'
            fi
        fi
    fi
done
cd "${curDir}"

#rm -f "${STATUS_FILE}"
