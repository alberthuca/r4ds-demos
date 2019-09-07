# Find where the sample data are
path <-  system.file("extdata", package="dslabs")
list.files(path)


filename <- "murders.csv"
fullpath <- file.path(path, filename)
fullpath


destpath <- file.path(getwd(), "data")
destpath

# Copy the files from where the package is installed,
# to data directory under my working directory
file.copy(fullpath, destpath)

