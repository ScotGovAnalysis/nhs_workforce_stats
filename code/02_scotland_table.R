#######################################################
## 02_Scotland_table.R
## For the creation of Scotland table 

# This table outputs data for particular specialties based on workforce policy
# interests, which is pasted into the Excel workbook for comparison with
# other time points. 


### 0 - Setup #########################################

## Run setup scripts where libraries are loaded and output destination folder is 
## created.
## Also load in the required data here. 

source(here::here("code", "00_setup.R"))

# Read in required data
detailed_wte <- read_rds(
  here("data", folder_loc, paste0(briefing_round, "_detailed_wte.rds")),
)


### 1 - Summarize data ####

#Use the detailed_wte dataframe that was called in setup script

# For total staff
total_staff <- detailed_wte %>%
  summarise(sep2007_sum = sum(sep2007_wte),
            prevyear_sum = sum(prevyear_wte),
            prevquarter_sum = sum(prevquarter_wte),
            new_sum = sum(new_wte))
  
# For total M&D staff
md_staff <- detailed_wte %>%
  filter(job_family == "Medical & dental") %>%
  summarise(sep2007_sum = sum(sep2007_wte),
            prevyear_sum = sum(prevyear_wte),
            prevquarter_sum = sum(prevquarter_wte),
            new_sum = sum(new_wte))

# For M&D consultant
consultants <- detailed_wte %>%
  filter(job_family == "Medical & dental") %>%
  filter(band_grouping == "Consultant") %>%
  summarise(sep2007_sum = sum(sep2007_wte),
            prevyear_sum = sum(prevyear_wte),
            prevquarter_sum = sum(prevquarter_wte),
            new_sum = sum(new_wte))



# Now, For Medical consultant only

medical_consultants <- detailed_wte %>%
  filter(job_family == "Medical & dental") %>%
  filter(band_grouping == "Consultant") %>%
  filter(!subjob_family %in% dental_specialties) %>%
  summarise(sep2007_sum = sum(sep2007_wte),
            prevyear_sum = sum(prevyear_wte),
            prevquarter_sum = sum(prevquarter_wte),
            new_sum = sum(new_wte))

# For Emergency medicine consultant
emergency_consultants <- detailed_wte %>%
  filter(job_family == "Medical & dental") %>%
  filter(band_grouping == "Consultant") %>%
  filter(subjob_family == "Emergency medicine") %>%
  summarise(sep2007_sum = sum(sep2007_wte),
            prevyear_sum = sum(prevyear_wte),
            prevquarter_sum = sum(prevquarter_wte),
            new_sum = sum(new_wte))

# For Anaesthetics consultant
anaesthetics_consultants <- detailed_wte %>%
  filter(job_family == "Medical & dental") %>%
  filter(band_grouping == "Consultant") %>%
  filter(subjob_family == "Anaesthetics") %>%
  summarise(sep2007_sum = sum(sep2007_wte),
            prevyear_sum = sum(prevyear_wte),
            prevquarter_sum = sum(prevquarter_wte),
            new_sum = sum(new_wte))

# For Clinical radiology consultant
clinical_radiology_consultants <- detailed_wte %>%
  filter(job_family == "Medical & dental") %>%
  filter(band_grouping == "Consultant") %>%
  filter(subjob_family == "Clinical radiology") %>%
  summarise(sep2007_sum = sum(sep2007_wte),
            prevyear_sum = sum(prevyear_wte),
            prevquarter_sum = sum(prevquarter_wte),
            new_sum = sum(new_wte))

# For Psychiatry consultants
psychiatry_consultants <- detailed_wte %>%
  filter(job_family == "Medical & dental") %>%
  filter(band_grouping == "Consultant") %>%
  filter(subjob_family %in% c("General psychiatry", "Child & adolescent psychiatry",
                             "Forensic psychiatry", "Old age psychiatry", 
                             "Psychiatry of learning disability", "Psychotherapy")) %>%
  summarise(sep2007_sum = sum(sep2007_wte),
            prevyear_sum = sum(prevyear_wte),
            prevquarter_sum = sum(prevquarter_wte),
            new_sum = sum(new_wte))

# For General Psychiatry consultant
general_psychiatry_consultants <- detailed_wte %>%
  filter(job_family == "Medical & dental") %>%
  filter(band_grouping == "Consultant") %>%
  filter(subjob_family == "General psychiatry") %>%
  summarise(sep2007_sum = sum(sep2007_wte),
            prevyear_sum = sum(prevyear_wte),
            prevquarter_sum = sum(prevquarter_wte),
            new_sum = sum(new_wte))

# For general surgery consultant only
general_surgery_consultants <- detailed_wte %>%
  filter(job_family == "Medical & dental") %>%
  filter(band_grouping == "Consultant") %>%
  filter(subjob_family == "General surgery") %>%
  summarise(sep2007_sum = sum(sep2007_wte),
            prevyear_sum = sum(prevyear_wte),
            prevquarter_sum = sum(prevquarter_wte),
            new_sum = sum(new_wte))

# For Paediatrics consultant
paediatrics_consultants <- detailed_wte %>%
  filter(job_family == "Medical & dental") %>%
  filter(band_grouping == "Consultant") %>%
  filter(subjob_family == "Paediatrics") %>%
  summarise(sep2007_sum = sum(sep2007_wte),
            prevyear_sum = sum(prevyear_wte),
            prevquarter_sum = sum(prevquarter_wte),
            new_sum = sum(new_wte))

# For Geriatric medicine consultant
geriatric_medicine_consultants <- detailed_wte %>%
  filter(job_family == "Medical & dental") %>%
  filter(band_grouping == "Consultant") %>%
  filter(subjob_family == "Geriatric medicine") %>%
  summarise(sep2007_sum = sum(sep2007_wte),
            prevyear_sum = sum(prevyear_wte),
            prevquarter_sum = sum(prevquarter_wte),
            new_sum = sum(new_wte))

# For Clinical and medical oncology consultant
clinical_medical_oncology_consultants <- detailed_wte %>%
  filter(job_family == "Medical & dental") %>%
  filter(band_grouping == "Consultant") %>%
  filter(subjob_family %in% c("Clinical oncology", "Medical oncology")) %>%
  summarise(sep2007_sum = sum(sep2007_wte),
            prevyear_sum = sum(prevyear_wte),
            prevquarter_sum = sum(prevquarter_wte),
            new_sum = sum(new_wte))

# For M&D support staff
md_support <- detailed_wte %>%
  filter(job_family == "Medical & dental support") %>%
  summarise(sep2007_sum = sum(sep2007_wte),
            prevyear_sum = sum(prevyear_wte),
            prevquarter_sum = sum(prevquarter_wte),
            new_sum = sum(new_wte))


### For N&M staff

# For all N&M staff
nm_staff <- detailed_wte %>%
  filter(job_family == "Nursing & midwifery") %>%
  summarise(sep2007_sum = sum(sep2007_wte),
            prevyear_sum = sum(prevyear_wte),
            prevquarter_sum = sum(prevquarter_wte),
            new_sum = sum(new_wte))


# Have to first create a midwifery vector so that they can be excluded from 
# nursing.

# For nursing staff only
nursing_staff <- detailed_wte %>%
  filter(job_family == "Nursing & midwifery") %>%
  filter(!subjob_family %in% c(midwifery_specialties, "Not assimilated / not known")) %>%
  summarise(sep2007_sum = sum(sep2007_wte),
            prevyear_sum = sum(prevyear_wte),
            prevquarter_sum = sum(prevquarter_wte),
            new_sum = sum(new_wte))


# For midwifery staff only
midwifery_staff <- detailed_wte %>%
  filter(job_family == "Nursing & midwifery") %>%
  filter(subjob_family %in% midwifery_specialties) %>%
  summarise(sep2007_sum = sum(sep2007_wte),
            prevyear_sum = sum(prevyear_wte),
            prevquarter_sum = sum(prevquarter_wte),
            new_sum = sum(new_wte))


# For qualified N&M staff only

qualified_nm_staff <- detailed_wte %>%
  filter(job_family == "Nursing & midwifery") %>%
  filter(band_grouping == "Qualified") %>%
  summarise(sep2007_sum = sum(sep2007_wte),
            prevyear_sum = sum(prevyear_wte),
            prevquarter_sum = sum(prevquarter_wte),
            new_sum = sum(new_wte))

# For qualified nurses only
qualified_nurses <- detailed_wte %>%
  filter(job_family == "Nursing & midwifery") %>%
  filter(!subjob_family %in% midwifery_specialties) %>%
  filter(band_grouping == "Qualified") %>%
  summarise(sep2007_sum = sum(sep2007_wte),
            prevyear_sum = sum(prevyear_wte),
            prevquarter_sum = sum(prevquarter_wte),
            new_sum = sum(new_wte))

# For qualified midwives only
qualified_midwives <- detailed_wte %>%
  filter(job_family == "Nursing & midwifery") %>%
  filter(subjob_family %in% midwifery_specialties) %>%
  filter(band_grouping == "Qualified") %>%
  summarise(sep2007_sum = sum(sep2007_wte),
            prevyear_sum = sum(prevyear_wte),
            prevquarter_sum = sum(prevquarter_wte),
            new_sum = sum(new_wte))


# For support N&M staff only
support_nm_staff <- detailed_wte %>%
  filter(job_family == "Nursing & midwifery") %>%
  filter(band_grouping == "Support") %>%
  summarise(sep2007_sum = sum(sep2007_wte),
            prevyear_sum = sum(prevyear_wte),
            prevquarter_sum = sum(prevquarter_wte),
            new_sum = sum(new_wte))

# For Not-assimilated/Not known N&M staff
not_assimilated_nm_staff <- detailed_wte %>%
  filter(job_family == "Nursing & midwifery") %>%
  filter(subjob_family == "Not assimilated / not known") %>%
  filter(band_grouping == "Not assimilated / not known") %>% #to avoid overcounting
  summarise(sep2007_sum = sum(sep2007_wte),
            prevyear_sum = sum(prevyear_wte),
            prevquarter_sum = sum(prevquarter_wte),
            new_sum = sum(new_wte))


# For all AHP staff

ahp_staff <- detailed_wte %>%
  filter(job_family == "Allied health professions") %>%
  summarise(sep2007_sum = sum(sep2007_wte),
            prevyear_sum = sum(prevyear_wte),
            prevquarter_sum = sum(prevquarter_wte),
            new_sum = sum(new_wte))


# For AHP excluding paramedics
ahp_excl_paramedics <- detailed_wte %>%
  filter(job_family == "Allied health professions") %>%
  filter(!subjob_family =="Paramedics") %>%
  summarise(sep2007_sum = sum(sep2007_wte),
            prevyear_sum = sum(prevyear_wte),
            prevquarter_sum = sum(prevquarter_wte),
            new_sum = sum(new_wte))



# For Other therapeutic staff

other_therapeutic_staff <- detailed_wte %>%
  filter(job_family == "Other therapeutic services") %>%
  summarise(sep2007_sum = sum(sep2007_wte),
            prevyear_sum = sum(prevyear_wte),
            prevquarter_sum = sum(prevquarter_wte),
            new_sum = sum(new_wte))

# For Personal and social care staff

personal_social_care_staff <- detailed_wte %>%
  filter(job_family == "Personal & social care") %>%
  summarise(sep2007_sum = sum(sep2007_wte),
            prevyear_sum = sum(prevyear_wte),
            prevquarter_sum = sum(prevquarter_wte),
            new_sum = sum(new_wte))


# For Healthcare science staff

healthcare_science_staff <- detailed_wte %>%
  filter(job_family == "Healthcare science") %>%
  summarise(sep2007_sum = sum(sep2007_wte),
            prevyear_sum = sum(prevyear_wte),
            prevquarter_sum = sum(prevquarter_wte),
            new_sum = sum(new_wte))


# For Ambulance support staff

ambulance_support_staff <- detailed_wte %>%
  filter(job_family == "Ambulance support services") %>%
  summarise(sep2007_sum = sum(sep2007_wte),
            prevyear_sum = sum(prevyear_wte),
            prevquarter_sum = sum(prevquarter_wte),
            new_sum = sum(new_wte))

# For administrative services staff

admin_services_staff <- detailed_wte %>%
  filter(job_family == "Administrative services") %>%
  summarise(sep2007_sum = sum(sep2007_wte),
            prevyear_sum = sum(prevyear_wte),
            prevquarter_sum = sum(prevquarter_wte),
            new_sum = sum(new_wte))


# For support services staff

support_services_staff <- detailed_wte %>%
  filter(job_family == "Support services") %>%
  summarise(sep2007_sum = sum(sep2007_wte),
            prevyear_sum = sum(prevyear_wte),
            prevquarter_sum = sum(prevquarter_wte),
            new_sum = sum(new_wte))

# For support services staff

unknown_staff <- detailed_wte %>%
  filter(job_family == "Unallocated / not known") %>%
  summarise(sep2007_sum = sum(sep2007_wte),
            prevyear_sum = sum(prevyear_wte),
            prevquarter_sum = sum(prevquarter_wte),
            new_sum = sum(new_wte))




### Section 1.2: Join dataframes for export ####

fivedaybrief <- rbind(total_staff, md_staff, consultants, medical_consultants, 
                         emergency_consultants, anaesthetics_consultants, 
                         clinical_radiology_consultants, psychiatry_consultants,
                         general_psychiatry_consultants, general_surgery_consultants,
                         paediatrics_consultants, geriatric_medicine_consultants,
                         clinical_medical_oncology_consultants, md_support,
                         nm_staff, nursing_staff, midwifery_staff, 
                         qualified_nm_staff, qualified_nurses, qualified_midwives,
                         support_nm_staff, not_assimilated_nm_staff, ahp_staff,
                         ahp_excl_paramedics, other_therapeutic_staff, 
                         personal_social_care_staff, healthcare_science_staff,
                         ambulance_support_staff, admin_services_staff,
                         support_services_staff, unknown_staff)


fivedaybrief$staff_group <- c("total_staff", "md_staff", "consultants", 
                              "medical_consultants", "emergency_consultants", 
                              "anaesthetics_consultants", 
                              "clinical_radiology_consultants", "psychiatry_consultants",
                              "general_psychiatry_consultants", "general_surgery_consultants",
                              "paediatrics_consultants", "geriatric_medicine_consultants",
                              "clinical_medical_oncology_consultants", "md_support",
                              "nm_staff", "nursing_staff", "midwifery_staff", 
                              "qualified_nm_staff", "qualified_nurses", 
                              "qualified_midwives", "support_nm_staff", 
                              "not_assimilated_nm_staff", "ahp_staff",
                              "ahp_excl_paramedics", "other_therapeutic_staff", 
                              "personal_social_care_staff", "healthcare_science_staff",
                              "ambulance_support_staff", "admin_services_staff",
                              "support_services_staff", "unknown_staff")


# rearrange the columns to put staff group first
fivedaybrief <- fivedaybrief %>%
  select(staff_group, everything())




#### Section 2: Save this as a table as excel file. ####
write.xlsx(fivedaybrief, 
           here("output",folder_loc,
                paste(briefing_round, "fivedaybrief.xlsx")))


