# wdl-cellranger-gex

WDLized Cell Ranger Gene Expression

## Setup

```bash
aws s3 cp s3://dp-lab-home/software/install-CellRangerGex-6.0.2.sh - | bash
```

```bash
conda create -n cromwell python=3.7.6 pip
conda activate cromwell
pip install cromwell-tools
```

Update `secrets.json` with your Cromwell Server address and credentials:

```bash
$ cat secrets.json
{
    "url": "http://ec2-100-26-170-43.compute-1.amazonaws.com",
    "username": "****",
    "password": "****"
}
```

## Running Workflow

Submit your job:

```bash
conda activate cromwell

./submit.sh \
    -k secrets-aws.json \
    -i configs/sample.inputs.aws.json \
    -l configs/sample.labels.aws.json \
    -o CellRangerGex.options.aws.json
```
