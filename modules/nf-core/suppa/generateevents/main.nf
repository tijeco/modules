
def VERSION = 2.3 // unfortunately suppa doesn't have a version flag 

process SUPPA_GENERATEEVENTS {
    tag '$events'
    label 'process_medium'
    conda (params.enable_conda ? "bioconda::suppa=2.3" : null)
    container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
        'https://depot.galaxyproject.org/singularity/suppa:2.3--py_2':
        'quay.io/biocontainers/suppa:2.3--py_2' }"

    input:
    
    path gtf

    output:
    
    path "events.ioi", emit: events
    
    path "versions.yml"           , emit: versions

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = task.ext.args ?: '-f ioi' // format: ioi for transcript events, 
                                        // otherwise can be set to ioe for local events (requires space separated -e {SE/SS/MX/RI/FL})
    
    """
    suppa.py \\
        generateEvents \\
        -i $gtf \\
        -o events \\
        $args
    
    
    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        suppa: \$(echo  $VERSION > versions.yml)
    END_VERSIONS
    """
}
