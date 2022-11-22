

process MISOPY_INDEXGFF {
    tag "$indexed_SE_events"
    label 'process_medium'
    conda (params.enable_conda ? "bioconda::misopy=0.5.4" : null)
    container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
        'https://depot.galaxyproject.org/singularity/misopy:0.5.4--py27heb79e2c_4':
        'quay.io/biocontainers/misopy:0.5.4--py27heb79e2c_4' }"

    input:
    path SE_gff3
    

    output:
    path "indexed_SE_events", emit: index
    path "versions.yml",      emit: versions

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = task.ext.args ?: ''
    
    
    """
    index_gff \\
        --index $SE_gff3 \\
        indexed_SE_events

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        misopy: \$(echo \$(miso --version 2>&1) | sed 's/^.*MISO //; s/Using.*\$//' ))
    END_VERSIONS
    """
}
