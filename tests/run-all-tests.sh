#!/bin/bash -e

modules="Count"

usage()
{
cat << EOF
USAGE: `basename $0` [options]
    -k  service account key (e.g. secrets.json)
EOF
}

while getopts "k:i:l:o:h" OPTION
do
    case $OPTION in
        k) service_account_key=$OPTARG ;;
        h) usage; exit 1 ;;
        *) usage; exit 1 ;;
    esac
done

if [ -z "$service_account_key" ]
then
    usage
    exit 1
fi

for module_name in $modules
do

    echo "Testing ${module_name}..."

    ./run-test.sh -k ${service_account_key} -m ${module_name}

done
