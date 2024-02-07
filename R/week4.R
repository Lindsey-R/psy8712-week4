# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)

# Data Import
import_tbl <- read_delim("../data/week4.dat", delim = "-", col_names = c("casenum", "parnum","stimver", "datadate", "qs"))
str(import_tbl)
wide_tbl <- separate(import_tbl, qs, into = c("q1","q2","q3","q4","q5"), sep = "-")
wide_tbl[,5:9] <- sapply(wide_tbl[,5:9], as.integer)
wide_tbl$datadate <- mdy_hms(wide_tbl$datadate) #Using lubridate
wide_tbl[,5:9] <- replace(wide_tbl[,5:9], wide_tbl[,5:9] == 0, NA)
wide_tbl <- wide_tbl[is.na(wide_tbl$q2) == FALSE, ]
long_tbl <- pivot_longer(wide_tbl, cols = c('q1','q2','q3','q4','q5'), names_to = "question", values_to = "response")