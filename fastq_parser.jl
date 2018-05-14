#
# Final Project
# Alyssa Cantu
#

fasta_file = open("fasta_output.txt", "w")

init_path = "C:/Users/Alyssa/Desktop/hmp_latinx_files_all/"

fastq_files = readdir("$init_path")

fq_files_length = length(fastq_files)

all_seq_array = []

fasta_array = []

for i=1:fq_files_length
    dna_array = []
    sequence = ""
    path = init_path * fastq_files[i]
    hmp_file = open("$path", "r")

    for line in readlines(hmp_file)
        if line[1] == '@'
            continue
        end
        if line[1] == '+'
            continue
        end
        if ismatch(r"^[AGCT]+$", line)
            push!(dna_array, line)
        else
            continue
        end
    end

    dna_array_length = length(dna_array)

    for i = 1:dna_array_length-1
        sequence = dna_array[i] * dna_array[i+1]
    end

    push!(all_seq_array, sequence)
end

all_seq_length = length(all_seq_array)
#formats DNA sequence to FASTA file for BLAST search algorithm
format = ">fasta\n"

for i=1:all_seq_length
    fasta = format * all_seq_array[i] * "\n" * "\n"
    write(fasta_file, "$fasta")
end
