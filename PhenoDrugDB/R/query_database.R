# This script queries medication database
library(data.table)
library(tidyverse)
library(stringr)


query_database <- function(db_df, phenotype, medication){
  query_result <- db_df %>%
                    mutate(upper_pheno = toupper(pheno),
                           upper_med = toupper(med)) %>%
                    filter(upper_pheno == toupper(phenotype), upper_med == toupper(medication)) %>%
                    select(response)

  return(query_result$response)
}
