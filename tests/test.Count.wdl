version 1.0

import "modules/Count.wdl" as module

workflow Count {

    input {
        String sampleName
        String fastqName
        Array[File] inputFastq
        String referenceUrl
    }

    call module.Count {
        input:
            sampleName = sampleName,
            fastqName = fastqName,
            inputFastq = inputFastq,
            referenceUrl = referenceUrl
    }

    output {
        File webSummary = Count.webSummary
        File metricsSummary = Count.metricsSummary

        File bam = Count.bam
        File bai = Count.bai

        Array[File] rawFeatureBarcodeMatrix = Count.rawFeatureBarcodeMatrix
        Array[File] filteredFeatureBarcodeMatrix = Count.filteredFeatureBarcodeMatrix

        File rawFeatureBarcodeMatrixH5 = Count.rawFeatureBarcodeMatrixH5
        File filteredFeatureBarcodeMatrixH5 = Count.filteredFeatureBarcodeMatrixH5

        File perMoleculeInfo = Count.perMoleculeInfo

        File? outAnalysis = Count.outAnalysis

        File cloupe = Count.cloupe

        File pipestance = Count.pipestance
        File debugFile = Count.debugFile
    }
}