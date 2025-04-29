library(officer)
library(tidyverse)

fname <- "menti_to_word_docs/DefinitionsOfTerms_290425.docx"

alldat <- read_docx(fname[1]) %>%
    docx_summary() %>% 
    as_tibble() %>%
    select(text) %>%
  filter(text != "") %>%
  mutate(counter = ifelse(text == "Prefilled Terms",1,NA)) %>%
  fill(counter) %>%
  filter(counter == 1) %>%
  select(-counter) %>%
  # separate text col at first :
  separate(text, c("category", "text"), 
           sep = ":\\s*", 
           extra = "merge", 
           fill = "left") %>%
  mutate(text = trimws(text, which = "both", whitespace = "[\\h\\v]")) %>%
  filter(text != "Additional Terms" & text != "Prefilled Terms") %>%
  fill(category) %>%
  mutate(test = ifelse(category == "Term", text, NA)) %>%
  fill(test) %>%
  filter(test != "") %>%
  group_by(category, test) %>%
  mutate(counter = row_number()) %>% 
  ungroup() %>%
  unite("category",c(category, counter)) %>%
  pivot_wider(names_from = "category",
              values_from = "text",
              values_fill = "") %>%  
  unite("LongDef", starts_with("Long"), sep = "\n\n") %>%
  unite("ShortDef", starts_with("Short"), sep = "\n\n") %>%
  unite("DeepDive", starts_with("Deep"), sep = "\n\n") %>%
  unite("Contributors", starts_with("Contributors"), sep = "\n\n") %>%
  unite("Tags", starts_with("Tags"), sep = "\n\n") %>%
  rename(terms = Term_1) %>%
  mutate(#terms = str_to_title(terms),
         LongDef = str_to_sentence(LongDef),
         ShortDef = str_to_sentence(ShortDef)) %>%
  select(-test)

# create csv file for all the terms that need rendering
write_csv(alldat, "Terms_to_render.csv")
