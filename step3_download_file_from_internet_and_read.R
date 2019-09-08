# If you know the URL of the data file you want to use,
#   you can do this
url <- "https://raw.githubuserconent.com/rafalab/dslabs/master/inst/extdata/murders.csv"

dat <- read_csv(url)

# You can download the file to your working directory
download.file(url, "murders.csv")

# You can also download the file and give it an unique name for the temporary data file
tmp_filename <- tempfile()

# Download the file with a unique temporary name
download.file(url, tmp_filename)

dat2 <- read_csv(tmp_filename)
file.remove(tmp_filename)
