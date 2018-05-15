#
# Final Project
# Rohan Rastogi
#

using Plotly
Plotly.set_credentials_file(Dict("username"=>"rohan_rastogi", "api_key"=> "qBuSDac2hp8wL5Lw7NpY"))
Plotly.signin("rohan_rastogi","qBuSDac2hp8wL5Lw7NpY")

# Takes in a Text File Containing the BLAST Results for a Population
# Produces an Array of Strings representing the microbial strains
# found within each subject of the sample
function extract(file)
output = []
i = 0
    for line in eachline(file)
            i += 1
            regex1 = match(r"(.*)\sstrain", line)
            if regex1 == nothing
                push!(output, "Error Occurred in Parsing in Line " * string(i))
            else
                regex2 = match(r"\"fasta\",\s\"(.*)\Z", regex1[1])
                push!(output, regex2[1])
            end
    end
return output
end

# Takes in an Array of Strains/Species and Corrects it for unnecessary characters
function clean(matches)
output = []
    for match in matches
        match_cleaned1 = strip(match, '[')
        push!(output,match_cleaned1)
    end
return sort(output)
end

# Takes in an Array of Strings denoting the Species of Microbes found
# within each site/subject for a given sample
# Yields the corresponding list of genuses
function genusify(species)
output = []
    for strain in species
        genus = split(strain," ")[1]
        genus_corrected = strip(genus, ']')
        push!(output,genus_corrected)
    end
return sort(output)
end

# Takes in an Array of Strings denoting the Genuses of all Microbial strains
# found within each site/subject for a given sample
# Yields a Dictionary containing the frequency count distribution of each genus
function count(genuses)
output = Dict{String, Int64}()
    for genus in genuses
        if haskey(output, genus)
            output[genus] += 1
        else
            output[genus] = 1
        end
    end
return output
end

# Takes in a Dictionary containing the frequency count distribution for a genus
# for a given population and a String denoting the Graph's Title
# Requests the Plotly API to produce and store a bar chart with the given data and title
function createBar(genus_FC, graph_title)
    keys_out = []
    values_out = []
    for k in sort(collect(keys(genus_FC)))
        push!(keys_out, k)
        push!(values_out, genus_FC[k])
    end
layout = Layout(title=graph_title,yaxis_title = "Frequency Counts")
my_plot = Plotly.plot([bar(x=keys_out, y=values_out)], layout)
remote_plot = Plotly.post(my_plot)
end

# Takes in a Dictionary containing the percent composition breakdown of each genus
# for a given population and a String denoting the chart's Title
# Requests the Plotly API to produce and store a pie chart with the given data and title
function createPie(genus_composition, chart_title)
    species = []
    species_percentages = []
    for k in sort(collect(keys(genus_composition)))
        push!(species, k)
        push!(species_percentages, genus_composition[k])
    end
    layout = Layout()
    #my_plot = Plotly.plot([Pie(labels, values)], layout)
    my_plot = Plotly.plot(pie(labels=species, values=species_percentages), layout)
    remote_plot = Plotly.post(my_plot)
end

# Takes in a Dictionary containing the frequency count distribution for a genus
# for a given population and a String denoting a comment
# Yields an Array containing the 3 most prominent genera present in that population
# along with their respective counts
function determineOutliers(genus_FC,comment)
    output = sort(collect(genus_FC), by = tuple -> last(tuple), rev=true)[1:3]
    println("determineOutliers output: ")
    println(output)
    return output
end

# Takes in a Pair containing a prominent genus present in a given population
# as well as its total count, as well as the list of all the species/strains
# for each site/subject in the given population
# Yields a Dictionary containing the percentage composition of that prominent
# genus by species/strain
function determineComposition(population_name, prominent_genus_pair, species_sample)
    prominent_genus_name = prominent_genus_pair.first
    prominent_genus_total = prominent_genus_pair.second
    println(prominent_genus_name)
    println(prominent_genus_total)
    genus_breakdown = Dict{String, Float16}("Other" => 0.0)
    for strain in species_sample
        strain_genus = split(strain, " ")[1]
        strain_species = split(strain, " ")[2]
        if (prominent_genus_name == strain_genus)
            strain_species_percent = (1.0/prominent_genus_total)
            if haskey(genus_breakdown, strain_species)
                genus_breakdown[strain_species] += strain_species_percent
            else
                genus_breakdown[strain_species] = strain_species_percent
            end
        end
    end
    for species in keys(genus_breakdown)
        if (species == "Other")
        else
            if (genus_breakdown[species] < 0.005)
                increment = pop!(genus_breakdown, species)
                genus_breakdown["Other"] += increment
            else
            end
        end
    end
    println(genus_breakdown)
    createPie(genus_breakdown, population_name * " " * prominent_genus_name * " Composition")
end

function breakdown(data_file, population_name)
    species_sample = clean(extract(open(data_file)))
    genus_FC_sample = count(genusify(species_sample))
    prominent_genera_pairs = determineOutliers(genus_FC_sample, "Prominent Genera:")
    for prominent_genus_pair in prominent_genera_pairs
        determineComposition(population_name, prominent_genus_pair, species_sample)
    end
end

# Takes in Strings denoting the filename of the file containing the data,
# the name for the bargraph to be produced, and a generic comment
# Calls upon helper functions to actually perform the microbial profile
# comparative analysis across different populations
function perform(filename,bargraph_name, comment)
    raw_data = open(filename)
    species_list = clean(extract(raw_data))
    genus_list = genusify(species_list)
    genus_FC = count(genus_list)
    createBar(genus_FC, bargraph_name)
    determineOutliers(genus_FC, comment)
end

# A broader version of the 'perform'function which operates on the entire total
# population as opposed to merely the ethnic-based populations
function combine()
    african_american_FC = count(genusify(clean(extract(open("african_american_blast_results.txt")))))
    asian_FC = count(genusify(clean(extract(open("asian_blast_results.txt")))))
    caucasian_FC = count(genusify(clean(extract(open("caucasian_blast_results.txt")))))
    latinx_FC = count(genusify(clean(extract(open("latinx_blast_results.txt")))))
    entire_FC = merge(+, african_american_FC,asian_FC,caucasian_FC,latinx_FC)
    createBar(entire_FC, "Total Population")
    determineOutliers(entire_FC, "Prominent Genera within Total Population")
end

# FUNCTION CALLS TO GENERATE GRAPHS
#breakdown("asian_blast_results.txt", "Asian")
#breakdown("african_american_blast_results.txt", "African American")
#breakdown("caucasian_blast_results.txt", "Caucasian")
#breakdown("latinx_blast_results.txt", "Hispanic or Latino")
#perform("asian_blast_results.txt", "Asian Genera Frequency Counts", "Prominent Genera within Asian Population:")
#perform("caucasian_blast_results.txt", "Caucasian Genera Frequency Counts", "Prominent Genera within Caucasian Population:")
#perform("latinx_blast_results.txt", "Hispanic or Latino Genera Frequency Counts", "Prominent Genera within Hispanic of Latino Population:")
#perform("african_american_blast_results.txt", "African American Genera Frequency Counts", "Prominent Genera within African American Population:")
#combine()
