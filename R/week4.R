# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)

# Data Import
import_tbl <- read_delim("../data/week4.dat", delim = "-", col_names = c("casenum", "parnum","stimver", "datadate", "qs"))
glimpse(import_tbl)
wide_tbl <- separate(import_tbl, qs, into = c("q1","q2","q3","q4","q5"), sep = "-") #paste0("q", 1:5)
wide_tbl[,5:9] <- sapply(wide_tbl[,5:9], as.integer) #This is not a great practice cuz is referring things by position numbers; change 5:9 by paste0("q",1:5)
wide_tbl$datadate <- mdy_hms(wide_tbl$datadate) #Using lubridate
wide_tbl[,5:9] <- replace(wide_tbl[,5:9], wide_tbl[,5:9] == 0, NA) #wide_tbl[,paste0("q", 1:5)][wide_tbl[,paste0("q", 1:5)] == 0] <- NA
wide_tbl <- drop_na(wide_tbl, q2) #subset: !is.na(q2) #q2 != NA will not work
long_tbl <- pivot_longer(wide_tbl, cols = c('q1','q2','q3','q4','q5'), names_to = "question", values_to = "response")
# pivot_longer(wide_tbl, q1:q5)