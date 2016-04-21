##--------------------------------------------------------------##
##                    Script for Producing                      ##
##                 Figures 1, 3, 4, 5, 6, 7, 8                  ##
##  for "The National School System and the Irish Language      ##
##   in the Nineteenth Century" by Nicholas M. Wolf             ##
##              Published by Four Courts Press                  ##
##                          2016                                ##
##--------------------------------------------------------------##

provnumschool <-read.csv(file="Provinces_NatSchools.csv", header=TRUE, sep=",")
uk_fitz <- read.csv(file="Lang_Schools_Counties.csv", header=TRUE, sep=",")
mapsum <- read.csv(file="Counties_NatSchools_1851.csv", header=TRUE, sep=",")

library(ggplot2)

# Figure 1: Rankings of Counties by Number of Schools Per Child Aged 1-9, 1851

sortmapsum <- transform(mapsum, county = reorder(county, numschools_percapita_age1.9))
ggplot(sortmapsum, aes(x = county, y = numschools_percapita_age1.9)) + geom_bar(stat = "identity", fill = "black") + ggtitle("County Ranks by Number of Schools per Child Aged 1-9, 1851") + labs(y="Number of Schools per Child", x="County") + coord_flip() + theme_bw()

# Figure 3: Ratio of Enrolled Children to Resident Children Aged 1-9, by County, 1851
# New variable: part_rate. This is the participation rate as expressed using the average enrollment over the course of March and September 1851

mapsum$part_rate <- ((mapsum$num_schol_sept31_1851 + mapsum$num_schol_mar31_1851)/2)/mapsum$ukda_num_age1.9_1851
sortmapsum3 <- transform(mapsum, county = reorder(county, part_rate))
ggplot(sortmapsum3, aes(x = county, y = part_rate)) + geom_bar(stat = "identity", fill = "black") + ggtitle("Ratio of Enrolled Children to Resident Children Aged 1-9, by County, 1851") + labs(y="Ratio", x="County") + coord_flip() + theme_bw() + theme_bw()

# Figure 4: Share of All Schools (1826) and of National Schools (1835-65) Located in Each Province

ggplot(data = provnumschool, aes(x = Year, y = PercTotSchools, shape= Province)) + theme_classic() + geom_line() + geom_point() + theme_bw() + ggtitle("Share of All Schools (1826) and of National Schools (1835-65) Located in Each Province") + labs(x="Year", y="Percent of Schools") + theme_bw()

# Figure 5: Share of All Enrolled Children Resident in Each Province

ggplot(data = provnumschool, aes(x = Year, y = PercTotChildren, shape=Province)) + theme_classic() + geom_line() + geom_point() + theme_bw() + ggtitle("Share of All Children Enrolled in National Schools Resident in Each Province") + labs(x="Year", y="Percent of All Enrolled Children") + geom_segment(aes(x=1825.5, y=0.178, xend=1826.5, yend=0.178), linetype="solid") + geom_point(aes(x=1826, y=0.178), shape=20) + geom_segment(aes(x=1825.5, y=0.252, xend=1826.5, yend=0.252), linetype="solid") + geom_point(aes(x=1826, y=0.252), shape=17) + geom_segment(aes(x=1825.5, y=0.290, xend=1826.5, yend=0.290), linetype="solid") + geom_point(aes(x=1826, y=0.290), shape=3) + geom_segment(aes(x=1825.5, y=0.279, xend=1826.5, yend=0.279), linetype="solid") + geom_point(aes(x=1826, y=0.279), shape=15) + geom_segment(aes(x=1840.5, y=0.186, xend=1841.5, yend=0.186),linetype="solid") + geom_point(aes(x=1841, y=0.186), shape=20) + geom_segment(aes(x=1840.5, y=0.223, xend=1841.5, yend=0.223), linetype="solid") + geom_point(aes(x=1841, y=0.223), shape=17) + geom_segment(aes(x=1840.5, y=0.298, xend=1841.5, yend=0.298), linetype="solid") + geom_point(aes(x=1841, y=0.298), shape=3) + geom_segment(aes(x=1840.5, y=0.292, xend=1841.5, yend=0.292), linetype="solid") + geom_point(aes(x=1841, y=0.292), shape=15) + geom_segment(aes(x=1850.5, y=0.161, xend=1851.5, yend=0.161), linetype="solid") + geom_point(aes(x=1851, y=0.161), shape=20) + geom_segment(aes(x=1850.5, y=0.25, xend=1851.5, yend=0.25), linetype="solid") + geom_point(aes(x=1851, y=0.25), shape=17) + geom_segment(aes(x=1850.5, y=0.31, xend=1851.5, yend=0.31), linetype="solid") + geom_point(aes(x=1851, y=0.31), shape=3) + geom_segment(aes(x=1850.5, y=0.279, xend=1851.5, yend=0.279), linetype="solid") + geom_point(aes(x=1851, y=0.279), shape=15) + theme_bw() 

# Figure 6: A Comparison of Strength of Irish Monoglottism among Children Aged 1-9 to National School Enrollment Strength, by County, 1851

# Note: The following derived variables are used in this scatterplot, based on the following county-wide totals
# Total number of schools in 1851 was 4704; total number of students enrolled Sept 1851 was 517497; for march 1851 491395. Average for 1851 was thus 504446
# Total number of children aged 1-9, according to the L.A. Clarkson et al. dataset, was 1312156
# Total number of monoglot Irish-speakers aged 1-9 according to the L.A. Clarkson, et al. dataset, was 56124

# Creating a few new variables, showing 
# 1) percentage that each county had of the population aged 1-9 (per_schoolpop_1851)
# 2) percentage of the overall enrolled children each county had as calculated by using average of march/sept enrollment divided by 504446 (perc_scholars_1851)
# 3) percentage of total monoglot Irish speakers aged 1-9 each county had (perc_allmonIrish1.9_1851). This becomes the y-axis of the scatterplot
# 4) The "score" of enrollment success, i.e. the different between the percent of Ireland's enrolled students resident in that county and the percent of the entire Irish population aged 1-9 resident in that county (diff_percSchoolPop_scholars)

uk_fitz$perc_schoolpop_1851 <- uk_fitz$ukda_num_age1.9_1851/1312156
uk_fitz$perc_scholars_1851 <- ((uk_fitz$num_schol_sept31_1851 + uk_fitz$num_schol_mar31_1851)/2)/504446
uk_fitz$perc_allmonIrish1.9_1851 <- uk_fitz$Total_age1.9_i/56124
uk_fitz$diff_percSchoolPop_scholars <- uk_fitz$perc_scholars_1851 - uk_fitz$perc_schoolpop_1851

ggplot(uk_fitz, aes(x=diff_percSchoolPop_scholars, y=perc_allmonIrish1.9_1851)) + geom_point(shape=1, size= 3, colour = "black") + geom_text(data=subset(uk_fitz, County == "Galway" | County == "Mayo" | County == "Donegal" | County == "Kerry" | County == "Limerick" | County == "Armagh" | County == "Waterford" | County == "Clare" | County == "Cork" | County == "Sligo"), aes(label=County), hjust=1, vjust=1.5) + ggtitle("A Comparison of Strength of Irish Monoglottism among Children Aged 1-9 to National School Enrollment Strength, by County, 1851") + labs(x="Enrollment Score (Difference Between Proportion Enrolled and Proportion of Children)", y="Percent of All Irish Monoglots Aged 1-9") + coord_cartesian(xlim = c(-0.015, 0.025)) + geom_vline(xintercept=mean(uk_fitz$diff_percSchoolPop_scholars), colour="black") + theme_bw() + theme_bw()


# Figure 7: A Comparison of Strength of Irish Monoglottism among Children Aged 3-10 to Pre-National School Enrollment Strength, by County, 1826

# Note: The following derived variables are used in this scatterplot, based on the following county-wide totals
# Total number of schools in 1826 was 11823; total number of students for Sept 1826 was 542440 
# Total number of children aged 3-10, according to Garrett FitzGerald's adjusted nums, was 1526742
# Total number of monoglot Irish-speakers aged 1-9 according to the L.A. Clarkson, et al. dataset, was 56124

# Creating a few new variables, showing 
# 1) percentage that each county had of the population aged 3-10 (per_schoolpop_1826)
# 2) percentage of the overall enrolled children each county had as calculated by using Sept enrollment divided by 542440 (perc_scholars_1826)
# 4) The "score" of enrollment success, i.e. the different between the percent of Ireland's enrolled students resident in that county and the percent of the entire Irish population aged 1-9 resident in that county (diff_percSchoolPop_scholars_1826)

uk_fitz$perc_schoolpop_1826 <- uk_fitz$Child_3to10/1526742
uk_fitz$perc_scholars_1826 <- uk_fitz$fitz_total_pupils/542440
uk_fitz$diff_percSchoolPop_scholars_1826 <- uk_fitz$perc_scholars_1826 - uk_fitz$perc_schoolpop_1826

ggplot(uk_fitz, aes(x=diff_percSchoolPop_scholars_1826, y=perc_allmonIrish1.9_1851)) + geom_point(shape=1, size= 3, colour = "black") + geom_text(data=subset(uk_fitz, County == "Galway" | County == "Mayo" | County == "Donegal" | County == "Kerry" | County == "Limerick" | County == "Roscommon" | County == "Waterford" | County == "Clare" | County == "Cork" | County == "Sligo" | County == "Dublin"), aes(label=County), hjust=1, vjust=1.5) + ggtitle("A Comparison of Strength of Irish Monoglottism among Children Aged 3-10 to Pre-National School Enrollment Strength, by County, 1826") + labs(x="Enrollment Score (Difference Between Proportion Enrolled and Proportion of Children)", y="Percent of All Irish Monoglots Aged 1-9") + coord_cartesian(xlim = c(-0.015, 0.025)) + geom_vline(xintercept=mean(uk_fitz$diff_percSchoolPop_scholars_1826), colour="black") + theme_bw() + theme_bw()
#Figure 8: County Rankings by Enrollment Fluctuation, September to March 1851

sortmapsum3 <- transform(mapsum, county = reorder(county, fall_spring_diff_perc))
ggplot(sortmapsum3, aes(x = county, y = fall_spring_diff_perc)) + geom_bar(stat = "identity", fill = "black") + ggtitle("County Rankings by Enrollment Fluctuation, September to March 1851") + labs(y="Percent Difference in Enrollment of March versus September (Negative Value Indicates Higher March Enrollment)", x="County") + coord_flip() + theme_bw()
