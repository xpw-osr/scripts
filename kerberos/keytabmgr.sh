#!/usr/bin/env bash

# this script only use for Linux

function add() {
    keytab_path=$1
    principal=$2
    kadmin.local -q "xst -norandkey -k ${keytab} ${principal}"
}

function remove() {
    keytab_path=$1
    principal=$2
    kadmin.local -q "ktremove -k ${keytab} ${principal}"
}

function list() {
    keytab_path=$1
    klist -kt ${keytab_path}
}

keytab_name='hdfs.keytab'
keytab_store_path='/home/kerberos'

declare -A principals
principals=(['hdfs']='master;slave01;slave02' [HTTP]='master;slave01;slave02' [yarn]='master;slave01;slave02' [dn]='master;slave01;slave02' [nn]='master;slave01;slave02' [sn]='master;slave01;slave02' [jn]='master;slave01;slave02' [rm]='master;slave01;slave02' [nm]'master;slave01;slave02')

# clear
for username in ${!principals[@]}; do
    IFS=';' read -r -a hostarr <<< "${principals[${username}]}"
    for host in ${hostarr[*]}; do
        principal="${username}/${host}"
        keytab="${keytab_store_path}/${keytab_name}"

        echo "## Remove ${principal} from ${keytab}"
        # remove "${principal}" "${keytab}"
    done
done