#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { SPLADDER_BUILD } from '../../../../../modules/nf-core/spladder/build/main.nf'

workflow test_spladder_build {
    
    test_bam = [
        [ id:'test' ], // meta map
        file(params.test_data['homo_sapiens']['illumina']['test_paired_end_sorted_bam'], checkIfExists: true),
        file(params.test_data['homo_sapiens']['illumina']['test_paired_end_sorted_bam_bai'], checkIfExists: true)
    ]
    genome_gtf =  file(params.test_data['homo_sapiens']['genome']['genome_gtf'], checkIfExists: true)

    SPLADDER_BUILD ( test_bam, genome_gtf )
}
