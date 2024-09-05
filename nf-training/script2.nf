// Create transcriptome index file 
/*
 * pipeline input parameters
 */
params.reads = "$projectDir/data/ggal/gut_{1,2}.fq"
params.transcriptome_file = "$projectDir/data/ggal/transcriptome.fa"
params.multiqc = "$projectDir/multiqc"
params.outdir = "results"

log.info """\
    R N A S E Q - N F   P I P E L I N E
    ===================================
    transcriptome: ${params.transcriptome_file}
    reads        : ${params.reads}
    outdir       : ${params.outdir}
    """
    .stripIndent(true)

// Process is defined = 3 declarations
// - input 
// - output
// - script

/*
 * define the `INDEX` process that creates a binary index
 * given the transcriptome file
 */

/* 
params.transcriptome_file parameter = input for INDEX process
INDEX process using salmon tool -> salmon_index = indexed transcriptome -> index_ch (output)
cpus = specify number of CPUs to use for indexing -> check the work dir to see scrip executed (work folder in this case)
then use cmd: cat work/file/name.command.sh 
*/
process INDEX {
    cpus 2
    input:
    path transcriptome

    output:
    path 'salmon_index'

    script:
    """

    salmon index --threads $task.cpus -t $transcriptome -i salmon_index
    """
}

// input declaration declare transcriptome path variable & script as ref
// print the output of index_ch chanel = view() operator
workflow {
    index_ch = INDEX(params.transcriptome_file)
    index_ch.view()
}

// Even when salmon is not installed -> use docker container where salmon is defined in nextflow.config
// Nextflow has support for managing the execution of processes in Docker containers

// Run using this command: nextflow run script2.nf -with-docker
// Avoid adding -with-docker every time -> Adding docker.enabled = true to nextflow.config
