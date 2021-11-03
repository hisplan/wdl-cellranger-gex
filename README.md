# wdl-cellranger-gex

WDLized Cell Ranger Gene Expression Pipeline

## License

The pipeline code is available to everyone under the standard [MIT license](./LICENSE). However, the pipeline internally uses 10x software, so please make sure that you read and agree to [10x End User Software License](https://www.10xgenomics.com/end-user-software-license-agreement).

## Setup

The pipeline is a part of SCING (Single-Cell pIpeliNe Garden; pronounced as "sing" /siŋ/). For setup, please refer to [this page](https://github.com/hisplan/scing). All the instructions below is given under the assumption that you have already configured SCING in your environment.

## Create Job Files

You need two files for processing a GEX sample - one inputs file and one labels file. Use the following example files to help you create your configuration file:

- `configs/template.inputs.json`
- `configs/template.labels.json`

### Reference

Use one of the URLs below for the reference genome:

Type       | `CellRangerGex.reference`
---------- | -----------------------------------------------------------------------------
GRCh38     | `https://cf.10xgenomics.com/supp/cell-exp/refdata-gex-GRCh38-2020-A.tar.gz`
mm10       | `https://cf.10xgenomics.com/supp/cell-exp/refdata-gex-mm10-2020-A.tar.gz`

## Submit Your Job

```bash
conda activate scing

./submit.sh \
    -k ~/keys/cromwell-secrets.json \
    -i configs/your-sample.inputs.json \
    -l configs/your-sample.labels.json \
    -o CellRangerGex.options.aws.json
```
