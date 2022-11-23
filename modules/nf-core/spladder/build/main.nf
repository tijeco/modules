
// def VERSION = 3.0.2 

process SPLADDER_BUILD {
    tag "$meta.id"
    label 'process_medium'


    conda (params.enable_conda ? "YOUR-TOOL-HERE" : null)
    container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
        'biowardrobe2/spladder:v0.0.1 ':
        'biowardrobe2/spladder:v0.0.1'  }"

    input:
    
    tuple val(meta), path(bam), path(bai)
    path gtf

    output:
    
    tuple val(meta), path("*_spladder"), emit: spladder_out_dir
    
    path "versions.yml"           , emit: versions

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = task.ext.args ?: ''
    def prefix = task.ext.prefix ?: "${meta.id}"
    
    """
    spladder \\
        build \\
        --bams $bam \\
        --annotation $gtf \\
        --outdir ${prefix}_spladder

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        suppa: \$(python -c 'import spladder;print(spladder.__version__)' > versions.yml)
    END_VERSIONS
    """
}
