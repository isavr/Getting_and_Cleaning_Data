Getting and Cleaning Data
=========================

coursera.org course project

    Put run_analysis.R to , say, C:\Users\Username\Documents\R\

    in RStudio: setwd("C:\\Users\\Username\\Documents\\R\\")

    and then: source("run_analysis.R")

    The latter will run the R script, it will check if directory "UCI HAR Dataset" exists (it will download and unzip the source archive if not) then read the dataset and write this file:

    AnalysisResult.txt -- 225 Kb, a 180x68 data frame

   The created data frame is 180x68 because there are 30 subjects and 6 activities, so there would be 30*6=180 rows. Note that the provided R script has assumptions on locations of files.
