library(rvest)
library(dplyr)

url <- "https://en.wikipedia.org/wiki/Murder_in_the_United_States_by_state"
h <- read_html(url)

# Object h is xml document type
class(h)

# Extract all nodes of table type
tab <- h %>%
  html_nodes("table")

tab <- tab[[2]]


# Check the data in tab object
tab

# You can use html_table function in rvest 
#   to convert HTML tables into data frames.
tbl <- tab %>%
  html_table()

View(tbl)

tbl <- tbl %>%
  setNames(c("state", "population", "total", "murders", "gun_murders", "gun_ownership",
             "total_rate", "murder_rate", "gun_murder_rate"))

# Now tbl oject is a data frame type
class(tbl)

