#######################################################
## 03_territorial_board_table.R
## For the creation of Territorial board table 

# This table outputs data for particular consultant specialties, nursing and 
# midwifery (N&M), doctors in training, other M&D staff grades and  
# allied health profession (AHP). 
# This is based on workforce policy interests
# Output is pasted into and used for the territorial board workbook for 
# comparisons with previous year and 2006.
# The workbook is used for territorial board FMQ populated by workforce policy.


### 0 - Setup #########################################

## Run setup scripts where libraries are loaded and output destination folder is 
## created.
## Also load in the required data here. 

source(here::here("code", "00_setup.R"))

# Read in required data
detailed_wte <- read_rds(
  here("data", folder_loc, paste0(briefing_round, "_detailed_wte.rds")),
)




### 1.1 - Summarize data for territorial boards for new quarter

# For all staff
allstaff_board <- detailed_wte %>%
  filter(board %in% territorialboards) %>%
  group_by(board) %>%
  summarise(allstaff = sum(new_wte))


# For consultants
consultants_board <- detailed_wte %>%
  filter(board %in% territorialboards) %>%
  filter(job_family == "Medical & dental") %>%
  filter(band_grouping == "Consultant") %>%
  group_by(board) %>%
  summarise(consultants = sum(new_wte))


# For Emergency medicine consultant
emergency_board <- detailed_wte %>%
  filter(board %in% territorialboards) %>%
  filter(job_family == "Medical & dental") %>%
  filter(band_grouping == "Consultant") %>%
  filter(subjob_family == "Emergency medicine") %>%
  group_by(board) %>%
  summarise(emergency = sum(new_wte))


# For Anaesthetics consultant
anaesthetics_board <- detailed_wte %>%
  filter(board %in% territorialboards) %>%
  filter(job_family == "Medical & dental") %>%
  filter(band_grouping == "Consultant") %>%
  filter(subjob_family == "Anaesthetics") %>%
  group_by(board) %>%
  summarise(anaesthetics = sum(new_wte))


# For General (internal) medicine consultant
internal_medicine_board <- detailed_wte %>%
  filter(board %in% territorialboards) %>%
  filter(job_family == "Medical & dental") %>%
  filter(band_grouping == "Consultant") %>%
  filter(subjob_family == "General (internal) medicine") %>%
  group_by(board) %>%
  summarise(internal_medicine = sum(new_wte))


# For Obstetrics & gynaecology consultant
obstetrics_gynaecology_board <- detailed_wte %>%
  filter(board %in% territorialboards) %>%
  filter(job_family == "Medical & dental") %>%
  filter(band_grouping == "Consultant") %>%
  filter(subjob_family == "Obstetrics & gynaecology") %>%
  group_by(board) %>%
  summarise(obstetrics_gynaecology = sum(new_wte))


# For Paediatrics consultant
paediatrics_board <- detailed_wte %>%
  filter(board %in% territorialboards) %>%
  filter(job_family == "Medical & dental") %>%
  filter(band_grouping == "Consultant") %>%
  filter(subjob_family == "Paediatrics") %>%
  group_by(board) %>%
  summarise(paediatrics = sum(new_wte))


# For Clinical radiology consultant
clinical_radiology_board <- detailed_wte %>%
  filter(board %in% territorialboards) %>%
  filter(job_family == "Medical & dental") %>%
  filter(band_grouping == "Consultant") %>%
  filter(subjob_family == "Clinical radiology") %>%
  group_by(board) %>%
  summarise(clinical_radiology = sum(new_wte))


# For psychiatry consultants
psychiatry_board <- detailed_wte %>%
  filter(board %in% territorialboards) %>%
  filter(job_family == "Medical & dental") %>%
  filter(band_grouping == "Consultant") %>%
  filter(subjob_family %in% c("General psychiatry", "Child & adolescent psychiatry",
                              "Forensic psychiatry", "Old age psychiatry", 
                              "Psychiatry of learning disability", "Psychotherapy")) %>%
  group_by(board) %>%
  summarise(psychiatry = sum(new_wte))


# For Other trained doctors
other_trained_doctors_board <- detailed_wte %>%
  filter(board %in% territorialboards) %>%
  filter(job_family == "Medical & dental") %>%
  filter(!band_grouping %in% c("Doctor in training", "Consultant")) %>%
  group_by(board) %>%
  summarise(other_trained_doctors = sum(new_wte))


# For Doctors in training
doctors_in_training_board <- detailed_wte %>%
  filter(board %in% territorialboards) %>%
  filter(band_grouping == "Doctor in training") %>%
  group_by(board) %>%
  summarise(doctor_in_training = sum(new_wte))


# For Qualified nurses and midwives
qualified_nurses_midwives_board <- detailed_wte %>%
  filter(board %in% territorialboards) %>%
  filter(job_family == "Nursing & midwifery") %>%
  filter(band_grouping == "Qualified") %>%
  group_by(board) %>%
  summarise(qualified_nurses_midwives = sum(new_wte))


# For Allied Health Professions
ahp_board <- detailed_wte %>%
  filter(board %in% territorialboards) %>%
  filter(job_family == "Allied health professions") %>%
  group_by(board) %>%
  summarise(ahp = sum(new_wte))



### Section 1.2 - Summarize for previous year ####

# For all staff
prevyear_allstaff_board <- detailed_wte %>%
  filter(board %in% territorialboards) %>%
  group_by(board) %>%
  summarise(prevyear_allstaff = sum(prevyear_wte))



### 2.1 Join dataframes into table ####

territorial_board_new <- allstaff_board %>% 
  full_join(consultants_board) %>%
  full_join(emergency_board) %>%
  full_join(anaesthetics_board) %>%
  full_join(internal_medicine_board) %>%
  full_join(obstetrics_gynaecology_board) %>%
  full_join(paediatrics_board) %>%
  full_join(clinical_radiology_board) %>%
  full_join(psychiatry_board) %>%
  full_join(other_trained_doctors_board) %>%
  full_join(doctors_in_training_board) %>%
  full_join(qualified_nurses_midwives_board) %>%
  full_join(ahp_board) %>%
  # transform table to long format
  pivot_longer(-c(board), names_to="staff") %>%
  # then transform to wide format
  pivot_wider(names_from = board)


# For previous year
territorial_board_prevyear <- prevyear_allstaff_board %>%
  # transform table to long format
  pivot_longer(-c(board), names_to="staff") %>%
  # then transform to wide format
  pivot_wider(names_from = board)


### 3.1 Save tables in excel ###########

# create a list of the tables
df_list <-list(territorial_board_new = territorial_board_new, 
               territorial_board_prevyear = territorial_board_prevyear)


write.xlsx(df_list, 
           here("output",folder_loc,
                paste(briefing_round, "territorial board table.xlsx")))
