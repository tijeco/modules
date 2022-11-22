def VERSION = 2.3 // unfortunately suppa doesn't have a version flag 

process SUPPA_PSIPERISOFORM {
    tag "$meta.id"
    label 'process_medium'

    conda (params.enable_conda ? "bioconda::suppa=2.3" : null)
    container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
        'https://depot.galaxyproject.org/singularity/suppa:2.3--py_2':
        'quay.io/biocontainers/suppa:2.3--py_2' }"

    input:
    
    tuple val(meta), path(merged_transcript_tpm)
    path gtf

    output:
    
    tuple val(meta), path("*.psi"), emit: psi
    
    path "versions.yml"           , emit: versions

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = task.ext.args ?: ''
    def prefix = task.ext.prefix ?: "${meta.id}"
    
    """
    suppa.py \\
        psiPerIsoform \\
        -g $gtf \\ 
        -e $merged_transcript_tpm \\
        -o ${prefix}.psi

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        suppa: \$(echo  $VERSION > versions.yml)
    END_VERSIONS
    """
}
