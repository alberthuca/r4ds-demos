library(dplyr)
library(dslabs)
data("polls_us_election_2016")

# dplyr function bind_cols binds two objects 
#   by putting the columns of each together in a tibble
new_tbl <- dplyr::bind_cols(a = 1:3, b = 4:6)

new_tbl

# We can also use bind_cols to bind data frames
tab1 <- polls_us_election_2016[, 1:3]
tab2 <- polls_us_election_2016[, 4:6]
tab3 <- polls_us_election_2016[, 7:9]

dim(tab1)
dim(tab2)
dim(tab3)

combined_tbl <- dplyr::bind_cols(tab1, tab2, tab3)

head(combined_tbl)


# cbind function in R-base performs the same function,
#   but it creates objects other than tibbles, either matrices or data frame.
cbind_tbl <- cbind(a = 1:3, b = 4:6)

cbind_tbl

# This object is matrix type
class(cbind_tbl)

# dplyr function bin_rows bind rows.
tab4 <- polls_us_election_2016[1:2, ]
tab5 <- polls_us_election_2016[3:4, ]
row_binded_tbl <- dplyr::bind_rows(tab4, tab5)
row_binded_tbl

