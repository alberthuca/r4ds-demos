# The following code demonstrate how to extract
#   data from a PDF document

library("pdftools")
library(tidyverse)
library(dslabs)

temp_file <- tempfile()
url <- "http://www.pnas.org/content/suppl/2015/09/16/1510159112.DCSupplemental/pnas.201510159SI.pdf"
download.file(url, temp_file)
txt <- pdf_text(temp_file)

?pdf_text

file.remove(temp_file)

# txt object is a character vector with an entry for each page.
length(txt)

# We keep the page we want using the folloiwng code:
raw_data_research_funding_rates <- txt[2]

class(raw_data_research_funding_rates)
raw_data_research_funding_rates

data("raw_data_research_funding_rates")

raw_data_research_funding_rates %>% head

# We see that it is a long string. Each line the page, including the table rows,
#   is separated by the symbol of new line: \n
# We can therefore create a list with the lines of the text as elements
tab <- str_split(raw_data_research_funding_rates, "\n")

tab

# Because we start off with just one element in the string, we end up with a list with just one entry
tab <- tab[[1]]

# Examing the object
tab %>% head

# We see that the information for the column names is the third and forth entries
the_names_1 <- tab[3]
the_names_2 <- tab[4]

# Examing the names
the_names_1
the_names_2

# We want to remove the leading space and everything following the comma. 
# Then we can obtain the elements by splitting using the space.
# We want to split only when there are 2 or more spaces to avoid splitting `success rate`.
the_names_1 <- the_names_1 %>%
  str_trim() %>%
  str_replace_all(",\\s.","") %>%
  str_split("\\s{2,}", simplify = TRUE)

the_names_1

class(the_names_1)

# We trim the leading space and then split by space for the_names_2
the_names_2 <- the_names_2 %>%
  str_trim() %>%
  str_split("\\s+", simplify = TRUE)

the_names_2

# Now we can join these to generate one name for each column
tmp_names <- str_c(rep(the_names_1, each = 3), the_names_2[-1], sep = "_")

tmp_names

the_names <- c(the_names_2[1], tmp_names) %>%
  str_to_lower %>%
  str_replace_all("\\s", "_")

the_names

# By examing the tab object, we notice that the information is in lines 6 through 14.
#   We can use str_split to get the actual data
new_research_funding_rates <- tab[6:14] %>%
  str_trim %>%
  str_split("\\s{2,}", simplify = TRUE) %>%
  data.frame(stringsAsFactors = FALSE) %>%
  setNames(the_names) %>%
  mutate_at(-1, parse_number)


length(tab)

new_research_funding_rates

identical(research_funding_rates, new_research_funding_rates)

research_funding_rates
