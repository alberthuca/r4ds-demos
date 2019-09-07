library(readr)

filename = "./data/murders.csv"
# We don't know what format the file is.
# So we read the first line to understand the format.
# It can also show us if there is a header.
read_lines(filename, n_max = 3)

# Now we know we can read the data using read_csv function
dat <- read_csv(filename)

# dat is a tibble type.
# Check the first six lines of data
head(dat)
