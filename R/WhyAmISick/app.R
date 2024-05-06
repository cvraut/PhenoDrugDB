#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:

# Why am I sick

library(shiny)
library(bslib)
library(shinyWidgets)
library(shinydashboard)
library(data.table)
suppressPackageStartupMessages(library(tidyverse))
library(dqshiny)


setwd("/nfs/corenfs/INTMED-Speliotes-data/Projects/hackathons/PhenoDrugDB/")
source("PhenoDrugDB/R/query_database.R")

# Load data
pheno_con <- file("data/phenolist.txt")
pheno <- readLines(pheno_con)
close(pheno_con)
med_con <- file("data/medlist.txt")
medication <- readLines(med_con)
close(med_con)
example_db <- fread("data/example_db.tsv")


if (interactive()) {

  shinyApp(
    ui = fluidPage(
      titlePanel("Why am I sick"),

      fluidRow(
        column(2,
               autocomplete_input("Phenotype", "Phenotype:", pheno, max_options = 1000),
               autocomplete_input("Medication", "Medication:", medication, max_options = 1000)
        )
      ),

      textOutput("query_result")
    ),
    server = function(input, output) {
        output$query_result <- renderText({
          response <- query_database(example_db, input$Phenotype, input$Medication)
          paste("Here is the result: ", response)
        })

    }
  )

}
