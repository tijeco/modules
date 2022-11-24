#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { MISOPY_INDEXGFF } from '../../../../../modules/nf-core/misopy/indexgff/main.nf'

workflow test_misopy_indexgff {
    
    
    genome_gff3 = file("https://raw.githubusercontent.com/yarden/MISO/fastmiso/misopy/gff-events/mm9/SE.mm9.gff")
    // file(params.test_data['homo_sapiens']['genome']['genome_gff3'], checkIfExists: true)

    MISOPY_INDEXGFF ( genome_gff3 )
}
