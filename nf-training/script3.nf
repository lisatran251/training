// Collect read files by pairs
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
    .stripIndent()

// fromFilePairs channel factory takes a glob pattern as input and returns a channel of tuples
// Each tuple contains two items: the first is the read pair prefix and the second is a list of paths to the read files.
// set operator equals = -> read_pairs_ch chanel

read_pairs_ch = Channel.fromFilePairs(params.reads)
// equals
Channel 
    .fromFilePairs(params.reads)
    .set {read_pairs_ch}


// Add .view() to see the content
read_pairs_ch.view()

// Creates a channel of all the files in the data/ggal directory: 
// nextflow run script3.nf --reads 'data/ggal/*_{1,2}.fq'

/*
checkIfExists option = check if specified path contains file pairs 
file pairs = paired-end sequencing files. generating 2 files for each sample 
    -> 2 ends of DNA fragments, so enhancing assembly accuracy, map reads more accurately to ref genome 
    -> identitfy insertions, deletions, rearrangements 
*/
Channel 
    .fromFilePairs(params.reads, checkIfExists: true)
    .set {read_pairs_ch}