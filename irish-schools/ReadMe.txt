Table summaries for datasets used for Nicholas M. Wolf, "The National School System and the Irish Language in the Nineteenth Century"
to be published by Four Courts Press in 2016 as part of the edited St. Patrick's, Drumcondra, 2015 Heaney Lecture Series.

These data were derived from four sources:
===========================================

(1) Clarkson, L.A., Kennedy, L., Crawford, E.M., Dowling, M.W. (1997). Database of Irish Historical Statistics : Language, 1851-1911. [data collection]. UK Data Service. SN: 3573, http://dx.doi.org/10.5255/UKDA-SN-3573-1. 

(2) Clarkson, L.A., Kennedy, L., Crawford, E.M., Dowling, M.W. (1997). Database of Irish Historical Statistics : Age, 1821-1911. [data collection]. UK Data Service. SN: 3574, http://dx.doi.org/10.5255/UKDA-SN-3574-1.

(3) Garret FitzGerald et al., Irish Primary Education in the Early Nineteenth Century: An Analysis of the First and Second Reports of the Commissioners of Irish Education Inquiry, 1825–26 (Dublin, 2013).

(4) The second through thirty-second Reports of the Commissioners of National Education in Ireland for the years 1835 to 1865, published as part of the House of Commons Parliamentary Papers


TABLE 1: Counties_NatSchools_1851.csv
=====================================

county: Name of Irish county

num_natschools_1851: The number of national schools in 1851 as reported in the  Eighteenth Report of the Commissioners of National Education in Ireland (for the Year 1851), with Appendices [1582] [1583], H.C. 1852–53, xlii, 1.

ukda_num_age1-9_1851: The number of persons in the given county aged 1-9 in the 1851 census, as recorded in the Clarkson et al. data (2)

numschools_percapita_age1-9: num_natschools_1851 divided by ukda_num_age1-9_1851

num_schol_mar31_1851: The number of children on the rolls in March 1851 as reported in the Eighteenth Report of the Commissioners of National Education

num_schol_sept31_1851: The number of children on the rolls in September 1851 as reported in the Eighteenth Report of the Commissioners of National Education

fall_spring_diff: Calculated as the difference of num_schol_sept31_1851 subtracted from num_schol_mar31_1851, with negative sign used to indicate higher March enrollment.

fall_spring_diff_perc: The variable fall_spring_diff expressed as a percent of September enrollment, again with negative sign used to indicate higher March enrollment.


TABLE 2: Provinces_NatSchools.csv
=====================================

Year: The school year referred to in the Commissioners' Report (4), or in the case of the year 1826, the figures provided in FitzGerald et al. (3)

ReportNum: The Commissioners' Report (4) number (e.g. Thirty-Second Report, Twenty-Fourth Report, etc.), or in the case of the year 1826, the value zero to indicate use of FitzGerald et al. (3) 

Province: The name of the Irish province

NumSchools: The number of national schools on the rolls in a given province in the given year as reported in Commissioners' Report (4)

NumChildren: The final number of children on the rolls in a given province in the given year as reported in Commissioners' Report (4)

TotalSchools: The total number of national schools on the rolls in all of Ireland in the given year (that is, the sum of NumSchools for all four provinces in a given year)

TotalChildren: The total number of children on the rolls in all of Ireland in the given year (that is, the sum of NumChildren for all four provinces in a given year)

PercTotChildren: The portion of the overall children resident in a given province for a given year (that is, NumChildren divided by TotalChildren)

PercTotSchools: The portion of the overall schools located in a given province for a given year (that is, NumSchools divided by TotalSchools)


TABLE 3: Lang_Schools_Counties.csv
=====================================

Province: Name of Irish province

County: Name of Irish county

Adj_PopNumber: The population of each county for 1826 as calculated by FitzGerald et al. (3) using the 1831 census.

Children_3to10: The number of children aged 3 to 10 resident in the county as calculated by FitzGerald et al. (3) using the 1831 census

fitz_total_pupils: The number of children enrolled in schools (pre-national schools) for given county as indicated in the First and Second Reports of the Commissioners of Irish Education Inquiry and reported by FitzGerald et al. (3)

ukda_num_age1-9_1851: The number of children aged 1-9 for given county as reported in the 1851 census and recorded in Clarkson et al. (2)

num_schol_mar31_1851: The number of children on the rolls in March 1851 for given county as reported in the Eighteenth Report of the Commissioners of National Education

num_schol_sept31_1851: The number of children on the rolls in September 1851 for given county as reported in the Eighteenth Report of the Commissioners of National Education

Total_age1-9_i: The total number of Irish-language monoglots aged 1-9 resident in a given county as reported in 1851 census and recorded in Clarkson et al. (1)