library(dplyr)
library(dslabs)
data("polls_us_election_2016")

# Intersection example
# Get intersection of numeric vectors
intersected_vector <- dplyr::intersect(c("a", "b", "c"), c("b", "c", "d"))

intersected_vector

# Get inersection of two tables
tab1 <- polls_us_election_2016[1:10, ]
tab2 <- polls_us_election_2016[5:20, ]

intersected_tab <- dplyr::intersect(tab1, tab2)

intersected_tab

# Union example
unioned_vector <- union(c("a", "b", "c"), c("b", "c", "d"))

unioned_vector

# dplyr function union cal do this for tables having the same column names

unioned_tab <- dplyr::union(tab1, tab2)

unioned_tab

# Set Difference example
# Unlike intersect and union, this function is not symmetric
setdiff(1:10, 6:15)

setdiff(6:15, 1:10)
