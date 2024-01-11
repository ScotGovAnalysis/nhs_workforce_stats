#######################################
# Written by Oyinda Jackson
# August 2023

#######################################
# 00_Setup.R
# Script to setup environment for running the quarterly official workforce stats 
# RAP
# Script requires MANUAL UPDATES(defining briefing rounds (section 2) before running others.
# Loads in libraries required in all scripts.

# Creates sub-folders for the output and markdown folders. 

######################################

######## Section 1: load in libraries

library(here)
library(dplyr)
library(tidyr)
library(openxlsx)
library(readxl)
library(tidyverse)
library(readr)
library(janitor)
library(rmarkdown)



####################################### 
############Section 2: - UPDATE THIS SECTION

# This label is used to name the folder of output from this briefing round
# This should be changed every quarter round
# Follow this naming convention: "year-quarter-data month" e.g. 2023-Q4-March

### Specify briefing rounds

# First, specify where the source data location and manipulate for naming 
folder_loc <- "2023-Q3-September"
folder_loc_split <- str_split_1(folder_loc, "-")

# Specify the current briefing quarter to align with the naming convention
briefing_round <- paste(folder_loc_split[1], folder_loc_split[3], sep ="-")

# Specify previous quarter for briefings
prevquarter_briefing_round <- "2023-June"

# Specify previous year for briefings
prevyear_briefing_round <- "2022-September"


## 2.2 Format the presentation of briefing rounds for markdowns
new_quarter <- as.Date(paste0(briefing_round, "-01"), format = "%Y-%B-%d")
new_quarter <-format(new_quarter, format = "%B %Y")


prev_quarter <- as.Date(paste0(prevquarter_briefing_round, "-01"), format = "%Y-%B-%d")
prev_quarter <-format(prev_quarter, format = "%B %Y")

prev_year <- as.Date(paste0(prevyear_briefing_round, "-01"), format = "%Y-%B-%d")
prev_year <-format(prev_year, format = "%B %Y")

########################################


######### Section 3: Create vectors that would be used in multiple scripts

# 3.1 To filter territorial boards

territorialboards <- c("NHS Ayrshire & Arran", "NHS Borders", 
                       "NHS Dumfries & Galloway", "NHS Fife", "NHS Forth Valley", 
                       "NHS Grampian", "NHS Greater Glasgow & Clyde", 
                       "NHS Highland", "NHS Lanarkshire", "NHS Lothian", 
                       "NHS Orkney", "NHS Shetland", "NHS Tayside", 
                       "NHS Western Isles")


# 3.2 To specify midwifery specialties 
midwifery_specialties <- c("Midwifery (exc neonatal)", "Midwifery (pre2015)", 
                           "Neonatal midwifery")


# 3.3 To filter dental specialties
dental_specialties <- c("Community dentistry", "Dental & maxillofacial radiology", 
                        "Dental public health", "Oral & maxillofacial pathology", 
                        "Oral medicine", "Oral microbiology", "Oral surgery", 
                        "Orthodontics", "Paediatric dentistry", "Restorative dentistry", 
                        "Special care dentistry", "Surgical dentistry", 
                        "Not known dental specialty")



######### Section 4: Create folders 

# If sub-folders for the briefing round specified above don't already exist,
# create sub-folders

if(!file.exists(here("output", folder_loc))) {
  dir.create(here("output", folder_loc))
}
