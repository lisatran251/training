#!/usr/bin/env nextflow

// Declares a parameter greeting that is initialized with the value 'Hello world!'.
params.greeting = 'Hello world!' 
// Channels are the input type for processes in nf   
greeting_ch = Channel.of(params.greeting)

process SPLITLETTERS {
    // Input can be values (val), files of paths (path)
    input: 
    // In this case, it's an input value
    val x

    output:
    // output files (path), name starts with 'chunk_'
    path 'chunk_*'

    script: 
    // triple " to execute the process
    """
    #!/usr/bin/env python
    x="$x"
    for i, word in enumerate(x.split()):
        with open(f"chunk_{i}", "w") as f:
            f.write(word)
    """
}

process CONVERTTOUPPER {
    input:
    // Input the path 
    path y

    output:
    // expect output as standard output (stdout)
    stdout

    script:
    """
    #!/usr/bin/env python
    with open("$y") as f:
        print(f.read().upper(), end="")
    """
}

workflow {
    letters_ch = SPLITLETTERS(greeting_ch)
    // flatten() splits the SPLITLETTERS output into individual files to be processed by CONVERTTOUPPER
    results_ch = CONVERTTOUPPER(letters_ch.flatten())
    results_ch.view{ it }
}

// Run script using command: nextflow run hello_py.nf