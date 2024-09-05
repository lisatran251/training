// Salmon: quantify molecules as transcripts in RNA-seq data 
// fastQC: analysis of high throughput sequence data
// multiQC: searches given dir for analysis logs and compiles a HTML report for easy viewing -> summarize output from multiple tools  


params.reads = "$projectDir/data/ggal/gut_{1,2}.fq"
params.transcriptome_file = "$projectDir/data/ggal/transcriptome.fa"
params.multiqc = "$projectDir/multiqc"
params.outdir = "$projectDir/results"

// println "reads: $params.reads"

// nextflow run script1.nf --reads '/workspace/gitpod/nf-training/data/ggal/lung_{1,2}.fq'

/*Note: 
log.info: print multiple lines info = groovy's logger 
e.g. 
log.info """\
    This is
    message
"""
*/ 

// Modify script1.nf to print all of the workflow parameters by using a single log.info command as a multiline string statement.

// stripIndent: remove any leading whitespace from all lines in the text block

// Instead of using println, use log.info to print the workflow parameters (multiple lines at once)

log.info """\
R N A S E Q - N F   P I P E L I N E
    ===================================
    transcriptome   : ${params.transcriptome_file}
    read            : ${params.reads}
    outdir          : ${params.outdir}
    """
    .stripIndent(true)
