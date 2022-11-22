#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { MISOPY_RUN } from '../../../../../modules/nf-core/misopy/run/main.nf'

workflow test_misopy_run {
    
    input = [
        [ id:'test', single_end:false ], // meta map
        file(params.test_data['sarscov2']['illumina']['test_paired_end_bam'], checkIfExists: true)
    ]

    MISOPY_RUN ( input )
}
