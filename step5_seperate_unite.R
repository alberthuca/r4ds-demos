library(tidyverse)
path <- system.file("extdata", package = "dslabs")

filename <- file.path(path, "life-expectancy-and-fertility-two-countries-example.csv")

raw_dat <- readr::read_csv(filename)

# You can find out raw_dat is in wide format
# You can also note that there are values for two variables with the column names
#   encoding which column represents which variables, such as, 1960_fertility
dplyr::select(raw_dat, 1:5)


# We can start the data wrangling with the gather function,
#   but we should not use the column name Year for the new column,
#   since it also contains the varaible type
#   We will call it key, which is the default of the function
dat <- raw_dat %>%
  tidyr::gather(key, value, -country)

# Check the result
head(dat)

# The data in dat object is not exactly tidy,
#   since each observation is associated with two, not one, row.
# We want to have the value from the two variables, 
#   ferility and life expectancy, as two separate columns

# Example 1
dat_separated <- dat %>%
  tidyr::separate(key, c("Year", "variable_name"), "_")

head(dat_separated)

# Code Example 1 gives us a warning, `too many values at 112 locations`
# This is because the underscore is used to separate life and expectancy in the name,
#   not just to seperate year and the variable name.

# Example 2
# We can add a third column to catch this and let the seperate function know
#   which  column to fill in with missing values - NAs, in this case, when there is no third value.
dat_separated2 <- dat %>%
  tidyr::separate(key, c("year", "first_variable_name", "second_variable_name"), fill = "right")

head(dat_separated2)

# Example 3
# Use extra like this
dat_separated3 <- dat %>%
  tidyr::separate(key,c("year", "variable_name"), sep="_", extra="merge")


head(dat_separated3)


# Now it's time to create a column for each variable
tidy_dat <- dat_separated3 %>%
  spread(variable_name, value)

# Check the result
head(tidy_dat)



# Sometimes it is usefult to do the inverse of separate,
#   which is to unite two columns into one

new_dat <- dat %>%
  separate(key, c("year", "first_variable_name", "second_variable_name"), fill = "right")

# Then we use unite function to merge two columns into one
new_dat <- new_dat %>%
  tidyr::unite(variable_name, first_variable_name, second_variable_name, sep = "_")

# Check the result
head(new_dat)

# Then we spread the columns
new_dat <- new_dat %>%
  tidyr::spread(variable_name, value) %>%
  dplyr::rename(fertility = fertility_NA)

# Check the result
head(new_dat)
