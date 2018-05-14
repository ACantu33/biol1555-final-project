#
# Final Project
# Alyssa Cantu
#
using Bio.Seq, Bio.Tools.BLAST

blast_query = open("query_sequence.txt", "w")

blast_results = open("blast_results.txt", "w")

sequences = open("C:/Users/Alyssa/biol1555/asg/fasta_output.txt", "r")

query_array = []

query_sequence = ""

total_queries = []

for line in readlines(sequences)
    if ismatch(r">", line)
        push!(query_array, line)
    end
    if ismatch(r"^[AGCT]+$", line)
        push!(query_array, line)
    else
        continue
    end
    query_array_length = length(query_array)
    for i=1:query_array_length-1
        query_sequence = query_array[i] * "\n" * query_array[i+1]
    end
    write(blast_query, "$query_sequence")
    close(blast_query)
    profile = blastn("C:\\Users\\Alyssa\\biol1555\\asg\\query_sequence.txt", "C:\\Users\\Alyssa\\Desktop\\blastdb\\16SMicrobial", db=true, ["-perc_identity", 98])
    write(blast_results, "$profile")
    query_array = []
    query_sequence = ""
    blast_query = open("query_sequence.txt", "w")
end
