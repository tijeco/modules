#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { SUPPA_GENERATEEVENTS } from '../../../../../modules/nf-core/suppa/generateevents/main.nf'

workflow test_suppa_generateevents {
    
    genome_gtf = file(params.test_data['homo_sapiens']['genome']['genome_gtf'], checkIfExists: true)

    SUPPA_GENERATEEVENTS ( genome_gtf )
}
