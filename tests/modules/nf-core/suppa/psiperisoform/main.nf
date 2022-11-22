#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { SUPPA_PSIPERISOFORM } from '../../../../../modules/nf-core/suppa/psiperisoform/main.nf'

workflow test_suppa_psiperisoform {
    
    
    transcript_tpm = [
        [ id:'test'], // meta map
        file("https://nf-core-awsmegatests.s3-eu-west-1.amazonaws.com/rnaseq/results-e049f51f0214b2aef7624b9dd496a404a7c34d14/aligner_star_salmon/star_salmon/salmon.merged.transcript_tpm.tsv", checkIfExists: true)
    ]
    genome_gtf = file(params.test_data['homo_sapiens']['genome']['genome_gtf'], checkIfExists: true)


    SUPPA_PSIPERISOFORM ( transcript_tpm, genome_gtf)
}
