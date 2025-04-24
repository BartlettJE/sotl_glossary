library(readxl)
library(tidyverse)

dat <- read_xlsx("menti_to_word_docs/SoTL Glossary.xlsx", skip = 2) %>%
  select(x = "What SoTL-related terms would you want in a glossary?:") %>%
  mutate(x = trimws(x, 
                    which = "both", 
                    whitespace = "[\\h\\v]")) %>%
  separate(x, 
           c("a","b","c","d"), # clunky as number of splits is not known due to blank spaces and 5 is a fudge
           sep = " ") %>%
  pivot_longer(everything(),
               values_to = "terms") %>%
  mutate(terms = na_if(terms,""),
         terms = str_replace(terms,"_"," "),
         terms = str_to_title(terms)) %>%
  filter(!is.na(terms)) %>%
  arrange(terms) %>%
  select(terms)

# Render Doc --------------------------------------------------------------

rmarkdown::render("menti_to_word_docs/MockUp.Rmd",
                  output_file = "menti_to_word_docs/DefinitionsOfTerms")
