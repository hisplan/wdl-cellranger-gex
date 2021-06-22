#!/bin/bash

set -euo pipefail

version="6.0.2"
workflow_name="CellRangerGex"

#
# package it and push it to AWS S3
#

s3_dest="s3://dp-lab-home/software"

path_workdir=`mktemp -d`

# create installation script
cat <<EOF > ${path_workdir}/install.sh
#!/bin/bash

aws s3 cp --quiet s3://dp-lab-home/software/${workflow_name}-${version}.tar.gz .
mkdir -p ${workflow_name}-${version}
tar xzf ${workflow_name}-${version}.tar.gz -C ${workflow_name}-${version}

echo "DONE."
EOF

tar cvzf ${path_workdir}/${workflow_name}-${version}.tar.gz \
    submit.sh ${workflow_name}.wdl ${workflow_name}.deps.zip ${workflow_name}.options.aws.json

aws s3 cp ${path_workdir}/${workflow_name}-${version}.tar.gz ${s3_dest}/
aws s3 cp ${path_workdir}/install.sh ${s3_dest}/install-${workflow_name}-${version}.sh

rm -rf ${path_workdir}
