# README

To create the glossary, there is a three stage process labelled by the R script names: 

1. `01_CreateTermsListFromMenti.R` - This script takes an Excel file from a Mentimeter activity to generate a Word version we can import into Google docs and make it easy for people to contribute collaboratively. 

2. `02_ExtractTermsFromDoc.R` - This script takes the Word document and isolates each entry. For each section, we scrape the term and definitions, and create a spreadsheet of the completed entries. 

3. `03_create_term_qmds.R` - Now we have all the terms in a spreadsheet, this script generates .qmd files for the glossary by ordering everything by the first letter and creating individual files for each letter. 

Once you have created the term Qmds, you need to update the `_quarto.yml` file for any new letters (`letter.txt` will help with copy and pasting) and rerender everything for the additions to show. 