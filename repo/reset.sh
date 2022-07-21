curDir=$(pwd)
curProject=

repo status > ./status.tmp
cat ./status.tmp | while read line; do
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
            echo "rm -f ${path}"
            # rm -f "${path}"
            # if [[ "$?" == "0" ]]; then
            #     echo ' --- removed'
            # else
            #     echo ' --- failed to remove'
            # fi
        elif [[ "${flag}" == "-m" ]]; then
            echo "git checkout -f ${path}"
            # git checkout -f "${path}"
            # if [[ "$?" == "0" ]]; then
            #     echo ' --- removed'
            # else
            #     echo ' --- failed to remove'
            # fi
        elif [[ "${flag}" == "-d" ]]; then
            echo "git checkout -f ${path}"
            # git checkout -f "${path}"
            # if [[ "$?" == "0" ]]; then
            #     echo ' --- removed'
            # else
            #     echo ' --- failed to remove'
            # fi
        fi
    fi
done
cd "${curDir}"