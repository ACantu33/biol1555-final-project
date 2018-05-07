#
# Final Project
# Alyssa Cantu and Rohan Rastogi
#

hmp_file = open("C:/Users/Alyssa/Desktop/HMP2_J28940_1_ST_T0_B0_0000_ZMBVNFM_1012_B44V8_S202.clean.dehost.fastq", "r")

dna_array = []
quality_array = []
sequence = ""

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
        push!(quality_array, line)
    end
end

dna_array_length = length(dna_array)
quality_array_length = length(quality_array)

for i = 1:dna_array_length-1
    sequence = dna_array[i] * dna_array[i+1]
end
