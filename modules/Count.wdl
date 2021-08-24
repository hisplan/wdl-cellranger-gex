version 1.0

task Count {

    input {
        String sampleName
        String fastqName
        Array[File] inputFastq
        String referenceUrl

        Int numCores = 16
        Int memory = 128

        # docker-related
        String dockerRegistry
    }

    String cellRangerVersion = "6.0.2"
    String dockerImage = dockerRegistry + "/cromwell-cellranger:" + cellRangerVersion
    Float inputSize = size(inputFastq, "GiB")

    # max memory Cell Ranger can use
    Int localMemory = floor(memory * 0.9)

    # ~{sampleName} : the top-level output directory containing pipeline metadata
    # ~{sampleName}/outs/ : contains the final pipeline output files.
    String outBase = sampleName + "/outs"

    command <<<
        set -euo pipefail

        export MRO_DISK_SPACE_CHECK=disable

        # download reference
        curl -L --silent -o reference.tgz ~{referenceUrl}
        mkdir -p reference
        tar xvzf reference.tgz -C reference --strip-components=1
        chmod -R +r reference
        rm -rf reference.tgz

        # path to input fastq files
        path_input=`dirname ~{inputFastq[0]}`

        cellranger count \
            --id=~{sampleName} \
            --transcriptome=./reference/ \
            --fastqs=${path_input} \
            --sample=~{fastqName} \
            --localcores=~{numCores} \
            --localmem=~{localMemory}

        # targz the analysis folder and pipestance metadata if successful
        if [ $? -eq 0 ]
        then
            tar czf ~{outBase}/analysis.tgz ~{outBase}/analysis/*
        fi

        find .
    >>>

    output {
        File webSummary = outBase + "/web_summary.html"
        File metricsSummary = outBase + "/metrics_summary.csv"

        File bam = outBase + "/possorted_genome_bam.bam"
        File bai = outBase + "/possorted_genome_bam.bam.bai"

        Array[File] rawFeatureBarcodeMatrix = glob(outBase + "/raw_feature_bc_matrix/*")
        Array[File] filteredFeatureBarcodeMatrix = glob(outBase + "/filtered_feature_bc_matrix/*")

        File rawFeatureBarcodeMatrixH5 = outBase + "/raw_feature_bc_matrix.h5"
        File filteredFeatureBarcodeMatrixH5 = outBase + "/filtered_feature_bc_matrix.h5"

        File perMoleculeInfo = outBase + "/molecule_info.h5"

        File? outAnalysis = outBase + "/analysis.tgz"

        File cloupe = outBase + "/cloupe.cloupe"

        File pipestanceMeta = sampleName + "/" + sampleName + ".mri.tgz"
    }

    runtime {
        docker: dockerImage
        # disks: "local-disk 1500 SSD"
        cpu: numCores
        memory: memory + " GB"
    }
}
