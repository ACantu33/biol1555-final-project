# Characterization of Human Microbiome Composition in Ethnic U.S. Populations
Alyssa N. Cantu and Rohan A. Rastogi
Brown University, Providence RI

## Introduction
The human microbiome encompasses the genes and genomes of the 100 trillion microbiota that inhabit our bodies (1,2). Microbiome composition varies with host lifestyle, genetics, age, nutrition, medication, and environment (3). Currently, there is a limitation in the scope of human microbiome studies, with the most representation coming from the US, Europe, and other so-called WEIRD countries (i.e. Western, Educated, Industrialized, Rich, and Democratic countries) (4). While this limitation does characterize the NIH Human Microbiome Project (HMP), the database contains data samples from six major U.S. racial/ethnic groups (5). The use of race and ethnicity is important to understand the roles of, and interactions between, genetic and environment factors (6), and will be utilized in this study to investigate variations in microbial composition of individuals belonging to different racial/ethnic groups. As microbial profiles have been discovered to characterize certain diseases (7), understanding the population-level composition of the human microbiome in different ethnic groups can reveal disease-susceptibility of that population, demonstrating clinical importance (8).

## Methods
Sample data acquired from the HMP database using the [HMP Portal API](https://github.com/jmatsumura/ihmp_portal_api) (9). From such data variation in microbial composition will be determined using UniFrac, an algorithm that measures similarity between microbial communities using phylogenetic information (10,11). To identify bacterial species-level operational taxonomic units (OTUs) (12), the [Random Forests Algorithm](https://github.com/bicycle1885/RandomForests.jl) will be used. For verification, will also be generated using the [mothur software packages](https://mothur.org/wiki/Main_Page).

## Results
We anticipate finding small variations in microbiome composition of different ethnic groups. Data that results in low similarity scores between groups will affirm this. Significant differences will be evaluated for disease risk with respect to differences in ethnic groups and compared with those found in public health literature.

## Discussion
If successful, these results will have broader implications in understanding the relations between race/ethnic background and susceptibility of disease. Contemporary research in health disparities among different racial and ethnic communities continue to address the causal factors of these disparities as systemic or sociological phenomena. These results may demonstrate such health disparities are grounded more intrinsically within the unique biological systems present in each community. Determining what constitutes a small variation in population-level composition poses an anticipated challenge, as well as determination of statistically significant results. An alternative strategy that can still demonstrate variations in microbiome composition of different ethnic populations would involve text mining publications that research these concepts.

## References
1. Proctor LM. The Human Microbiome Project in 2011 and Beyond. Cell Host & Microbe. 2011;10(4):287–91.Pryor TA, Gardner RM, Clayton RD, Warner HR. The HELP system. J Med Sys. 1983;7:87-101.
2. Turnbaugh PJ. The human microbiome project: exploring the microbial part of ourselves in a changing world. Nature. 2007Oct17;449(7164):804–10.
3. Ottman N, Smidt H, Vos WMD, Belzer C. The function of our microbiota: who is out there and what do they do? Frontiers in Cellular and Infection Microbiology. 2012;2.
4. Gupta VK, Paul S, Dutta C. Geography, Ethnicity or Subsistence-Specific Variations in Human Microbiome Composition and Diversity. Frontiers in Microbiology. 2017;8.
5. portal.hmpdacc.org. [cited 2018Mar22]. Available from: https://portal.hmpdacc.org/
6. Lin SS, Kelsey JL. Use of Race and Ethnicity in Epidemiologic Research: Concepts, Methodological Issues, and Suggestions for Research. Epidemiologic Reviews. 2000Jan;22(2):187–202.
7. Chen J, Wright K, Davis JM, Jeraldo P, Marietta EV, Murray J, et al. An expansion of rare lineage intestinal microbes characterizes rheumatoid arthritis. Genome Medicine. 2016;8(1).
8. The associations made in this hypothesis will largely follow the information presented in Chapter 4 (Hypothesis Generation from Heterogeneous Datasets). 
9. Data preparation, mining, and reduction will follow the concepts presented in Chapter 7 (Knowledge Discovery in Biomedical Data: Theory and Methods).
10. Yatsuneko T. Human gut microbiome viewed across age and geography. Nature. 2012May9;486(7402):222–7.
11. UniFrac is available in the QIIME and mothur packages.
12. Nguyen N-P, Warnow T, Pop M, White B. A perspective on 16S rRNA operational taxonomic unit clustering using sequence similarity. npj Biofilms and Microbiomes. 2016;2(1).

## Contributions
Midterm Abstract: Alyssa Cantu
Proofreading and Editing of Midterm Abstract: Rohan Rastogi
Presentation Slides: Alyssa Cantu & Rohan Rastogi
Proofreading and Editing of Presentation Slides: Alyssa Cantu
Data Analysis: Alyssa Cantu & Rohan Rastogi
Final Project write-up: Alyssa Cantu & Rohan Rastogi
