library(glue)
library(tidyverse)
library(readxl)

# load form of terms and definitions
dat <- read_xlsx("terms.xlsx")

# get first letter of each term 
dat <- dat %>% 
  mutate(first_letter = toupper(substr(term, 0, 1))) # capitalise first letter of term

# What pages to add to .yml?
paste0(sort.int(dat$first_letter), ".qmd")

# function to create a .Rmd file by adding in terms and definitions 
make_entry <- function(dat){
  # for each entry, use glue to add the term, short definition, and long definition 
  entry <- glue("
# {dat$first_letter}
  
## {dat$term}

<dfn>{dat$short_def}</dfn>

{dat$long_def}
")
  # create a unique file name for each term
  file_name <- paste0(dat$first_letter, ".qmd")
  # add the template and save 
  cat(entry, 
      file = file_name)
}

# we want to create a .Rmd for each term with a static format
# so add the terms for each row of the spreadsheet and create a .Rmd for each one
for (i in 1:nrow(dat)){
  make_entry(dat[i, ])
}



