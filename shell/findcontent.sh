folder=$1
fileext=$2
target=$3

find ${folder} | grep "${fileext}$" | while read line; do
    if [[ -d "${line}" ]]; then
        continue
    fi
    result=$(grep "${target}" "${line}")
    if [[ "${result}" != "" ]]; then
        echo "## ${line} ###"
        echo "${result}"
    fi
done