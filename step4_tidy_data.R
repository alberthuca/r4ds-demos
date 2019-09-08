library(readr)
library(tidyverse)

path <- system.file("extdata", package = "dslabs")

filename <- file.path(path, "fertility-two-countries-example.csv")

wide_data <- read_csv(filename)

# Check the data format
head(wide_data)

dplyr::select(wide_data, country, `1960`:`1967`)

# Reshape the data using gather function in tidyr
new_tidy_data1 <- wide_data %>%
  gather(year, fertility, `1960`:`2015`)

# Check the reshaped data
head(new_tidy_data1)


# The simpler way to specify which columns not to gather, 
#   rather than all the columns that will be gathered is like this:
new_tidy_data2 <- wide_data %>%
  tidyr::gather(year, fertility, -country)

head(new_tidy_data2)

# gather function assume columns are character data type
#  So we need to convert year column to number
class(new_tidy_data2$year)


new_tidy_data3 <- wide_data %>%
  gather(year, fertility, -country, convert = TRUE)

class(new_tidy_data3$year)

# Now the data is tidy, so we can plot the data
new_tidy_data3 %>%
  ggplot(aes(year, fertility, color = country)) +
  geom_point()


# It is sometimes useful for data wrangling purposes
#  to convert tidy data into the wide format data.
# We often use this as an intermediate step in tidying up data
# The spread function is basically the inverse of gather
new_wide_data <- new_tidy_data3 %>%
  tidyr::spread(year, fertility)

dplyr::select(new_wide_data, country, `1960` : `1967`)
