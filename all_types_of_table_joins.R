library(dslabs)
library(tidyverse)

data("polls_us_election_2016")
data("murders")

# Prepare sample datasets tab1 and tab2
tab1 <- dplyr::slice(murders, 1:6) %>%
  dplyr::select(state, population)

tab1

tab2 <- dplyr::slice(results_us_election_2016, c(1:3, 5, 7:8)) %>%
  dplyr::select(state, electoral_votes)

tab2

# Left Join example
# We want a table like tab2, 
#   but adding electoral votes to whatever states
#   we have available in tab1.
#   NAs will be added to states in tab1, but not in tab2
left_join_result <- dplyr::left_join(tab1, tab2, by = c("state"))

left_join_result

# Right Join example
# Right join is opposite to left join, 
right_join_result <- dplyr::right_join(tab1, tab2, by = c("state"))

right_join_result


# Inner Join example
# If we want to keep only the rows that have information in both tables,
#   we use inner join
inner_join_result <- dplyr::inner_join(tab1, tab2, by=c("state"))

inner_join_result

# Full Join example
# If you want to keep all the rows and fill in the missing parts with NAs,
#   you can use full join. You can think of this as a union
full_join_result <- dplyr::full_join(tab1, tab2, by=c("state"))

full_join_result

# Semi Join example
# It lets us keep the part of the first table
#   for which we have information in the second.
# It does not add the columns of the second.
semi_join_result <- dplyr::semi_join(tab1, tab2, by = c("state"))

semi_join_result

# Anti Join example
# The function keeps the elements of the first table
#  for which there is no information in the second table.
anti_join_result <- dplyr::anti_join(tab1, tab2, by = c("state"))

anti_join_result
