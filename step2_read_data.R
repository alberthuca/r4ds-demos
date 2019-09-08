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

# You can also use import functions in R base, like this
dat2 <-  read.csv(filename)

# The difference between dat and dat2 is that dat is a tibble, dat2 is a data frame.
class(dat)
class(dat2)

# Another difference is that the characters are converted to factors in dat2
class(dat2$region)

# You can avoid converting characters to factors like this
dat3 <- read.csv(filename, stringsAsFactors = FALSE)
class(dat3$region)
