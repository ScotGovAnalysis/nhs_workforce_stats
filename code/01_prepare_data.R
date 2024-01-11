######################################
# 01_prepare_data.R
# Loads in data for briefing round and produce data that are required for other
# codes, particularly for FMQ markdowns.

######################################################

### 0 - Setup

## Run setup scripts where needed data and libraries are loaded
## output destination folder also created there

source(here::here("code", "00_setup.R"))



############ Section 1: - Load in data for briefing round and get the record highs

##### 1A.1. Read in and tidy up detailed WTE data

detailed_wte <- here("data", folder_loc,
                     paste(briefing_round,"detailedwte_td.xlsx")) %>%
  read.xlsx(sheet=1)


# Rename the columns
names(detailed_wte) <- c("board", "job_family", "subjob_family", "band_grouping",
                         "band_grade", "sep2007_wte", "prevyear_wte", "prevquarter_wte", "new_wte")

# Remove first row and rows at the end
detailed_wte <- detailed_wte[-1,] %>%
  drop_na(job_family) %>%
  
  # Assign employment columns as numeric 
  mutate_at(c(6:9), as.numeric)

# Replace blank or nas with 0s
detailed_wte[is.na(detailed_wte)] <- 0


##### 1A.2. Now load in headcount data
hc_wte_data<- here("data", folder_loc,
                   paste(briefing_round,"headcount wte_td.xlsx")) %>%
  read.xlsx(sheet=1)

# Rename the columns
names(hc_wte_data) <- c("census_date", "board", "job_family", "headcount_wte", "value")

# Remove first row and rows at the end
hc_wte_data <- hc_wte_data %>%
  drop_na(job_family) %>%
  # Assign date and employment columns as numeric 
  mutate_at(c(1,5), as.numeric)

# format the census date 
hc_wte_data$census_date <- format(as.Date(hc_wte_data$census_date, origin = "1899-12-30"),
                                  format = "%Y-%B")

# Filter out headcount only
#hc_data <- hc_wte_data %>%
#filter(headcount_wte == "Headcount")


##### 1A.3. Load data for permanent wte. Data is taken from public dashboard. 
# Data table selects granular data for current, previous quarter and previous year
# This would be needed for ministerial briefing, core brief

wte_pd <- here("data", folder_loc,
               paste(briefing_round,"wte_pd.xlsx")) %>%
  read.xlsx(sheet=1)

# drop the country and region columns as they are never used
wte_pd <- wte_pd[,-c(1,2)]


# Rename the columns
names(wte_pd) <- c("board", "job_family", "subjob_family_grouping", "subjob_family",
                   "band_grouping", "band_grade", "sex", "contract",
                   "whole_part_time", "prevyear_wte", "prevquarter_wte", "new_wte")

# Remove first row and rows at the end
wte_pd <- wte_pd[-1,] %>%
  drop_na(job_family) %>%
  
  # Assign employment columns as numeric 
  mutate_at(c(10:12), as.numeric)

# Replace blank or nas with 0s
wte_pd[is.na(wte_pd)] <- 0


##### 1A.4. Load in consultant wte since 2006 from the time series dashboard
# This would be used to get the record high for consultants
consultantwte_td <- here("data", folder_loc,
                         paste(briefing_round,"consultantwte_td.xlsx")) %>%
  read.xlsx(sheet=1)


# Rename the columns
names(consultantwte_td) <- c("census_date", "value")

# Remove first row and rows at the end
consultantwte_td <- consultantwte_td[-1,] %>%
  # Assign employment columns as numeric 
  mutate_at(c(1:2), as.numeric)

# format the census date 
consultantwte_td$census_date <- format(as.Date(consultantwte_td$census_date, origin = "1899-12-30"),
                                       format = "%Y-%B")



######### Section 1B. Check for the record highs - 
# NOTE THAT THE CONSULTANT RH MUST BE CHECKED AND UPDATED EVERY ROUND 

recordhigh_all_census <- hc_wte_data %>%
  filter(board == "Scotland") %>%
  filter(job_family == "All staff") %>%
  filter(headcount_wte == "Whole Time Equivalent") %>%
  slice(which.max(value)) %>%
  dplyr::pull(census_date)

recordhigh_all <- hc_wte_data %>%
  filter(board == "Scotland") %>%
  filter(job_family == "All staff") %>%
  filter(headcount_wte == "Whole Time Equivalent") %>%
  slice(which.max(value)) %>%
  dplyr::pull(value)


recordhigh_nm_census <- hc_wte_data %>%
  filter(board == "Scotland") %>%
  filter(job_family == "Nursing & midwifery") %>%
  filter(headcount_wte == "Whole Time Equivalent") %>%
  slice(which.max(value)) %>%
  dplyr::pull(census_date)

recordhigh_nm <- hc_wte_data %>%
  filter(board == "Scotland") %>%
  filter(job_family == "Nursing & midwifery") %>%
  filter(headcount_wte == "Whole Time Equivalent") %>%
  slice(which.max(value)) %>%
  dplyr::pull(value)


recordhigh_ahp_census <- hc_wte_data %>%
  filter(board == "Scotland") %>%
  filter(job_family == "Allied health professions") %>%
  filter(headcount_wte == "Whole Time Equivalent") %>%
  slice(which.max(value)) %>%
  dplyr::pull(census_date)

recordhigh_ahp <- hc_wte_data %>%
  filter(board == "Scotland") %>%
  filter(job_family == "Allied health professions") %>%
  filter(headcount_wte == "Whole Time Equivalent") %>%
  slice(which.max(value)) %>%
  dplyr::pull(value)


recordhigh_consultants_census <- consultantwte_td %>%
  slice(which.max(value)) %>%
  dplyr::pull(census_date)

recordhigh_consultants <- consultantwte_td %>%
  slice(which.max(value)) %>%
  dplyr::pull(value)



######## Section 2: Create files for FMQs ####

## Save the detailed wte data for current, previous year and quarter 
write_rds(detailed_wte,
          here("data", folder_loc, paste0(briefing_round, "_detailed_wte.rds")),
          compress = "gz")


## Save headcount & wte data for data from 2006
write_rds(hc_wte_data,
          here("data", folder_loc, paste0(briefing_round, "_hc_wte_data.rds")),
          compress = "gz")


## Save the granular wte data for current, previous year and quarter from public 
# dashboard
write_rds(wte_pd,
          here("data", folder_loc, paste0(briefing_round, "_wte_pd.rds")),
          compress = "gz")


## create consultants only
consultant_wte <- detailed_wte %>%
  filter (band_grouping == "Consultant")

# Save the file
write_rds(consultant_wte,
          here("data", folder_loc, paste0(briefing_round, "_consultant_wte.rds")),
          compress = "gz")

#Save the time series consultant for record high figure
write_rds(consultantwte_td,
          here("data", folder_loc, paste0(briefing_round, "_consultantwte_td.rds")),
          compress = "gz")



## For Nursing and Midwifery 
nm_wte <- detailed_wte %>%
  filter (job_family == "Nursing & midwifery")

# Save the file
write_rds(nm_wte,
          here("data", folder_loc, paste0(briefing_round, "_nm_wte.rds")),
          compress = "gz")


## For Scottish Ambulance Service 
sas_wte <- detailed_wte %>%
  filter (board == "Scottish Ambulance Service")

# Save the file
write_rds(sas_wte,
          here("data", folder_loc, paste0(briefing_round, "_sas_wte.rds")),
          compress = "gz")


## For The State Hospital 
statehospital_wte <- detailed_wte %>%
  filter (board == "The State Hospital")

# Save the file
write_rds(statehospital_wte,
          here("data", folder_loc, paste0(briefing_round, "_statehospital_wte.rds")),
          compress = "gz")


## For NHS24
nhs24_wte <- detailed_wte %>%
  filter (board == "NHS 24")

# Save the file
write_rds(nhs24_wte,
          here("data", folder_loc, paste0(briefing_round, "_nhs24_wte.rds")),
          compress = "gz")

