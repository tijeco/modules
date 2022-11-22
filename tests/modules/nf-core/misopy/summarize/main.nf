#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { MISOPY_SUMMARIZE } from '../../../../../modules/nf-core/misopy/summarize/main.nf'

workflow test_misopy_summarize {
    
    input = [
        [ id:'test', single_end:false ], // meta map
        file(params.test_data['sarscov2']['illumina']['test_paired_end_bam'], checkIfExists: true)
    ]

    MISOPY_SUMMARIZE ( input )
}
