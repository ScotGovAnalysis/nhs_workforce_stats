#######################################################
## 04_render_markdowns.R
## To render markdowns that produce lines for workforce ministerial briefing, 
## core brief, and the FMQs. 

######################################################

# To produce Ministerial briefing
render(here::here("markdown", "Ministerial_briefing_NHS_workforce.Rmd"),
       output_dir = here::here("output", folder_loc))    

# To produce the workforce core brief
render(here::here("markdown", "Workforce_core_brief.Rmd"),
       output_dir = here::here("output", folder_loc))


# Now, to produce the FMQs

# FMQ NHS workforce 
render(here::here("markdown", "FMQ_NHS_workforce.Rmd"),
       output_dir = here::here("output", folder_loc))

# FMQ A&E 
render(here::here("markdown", "FMQ_A_E.Rmd"),
       output_dir = here::here("output", folder_loc))

# FMQ Cancer 
render(here::here("markdown", "FMQ_Cancer.Rmd"),
       output_dir = here::here("output", folder_loc))

# FMQ Maternity 
render(here::here("markdown", "FMQ_Maternity.Rmd"),
       output_dir = here::here("output", folder_loc))

# FMQ NHS 24 
render(here::here("markdown", "FMQ_NHS24.Rmd"),
       output_dir = here::here("output", folder_loc))

# FMQ Scottish Ambulance Service
render(here::here("markdown", "FMQ_SAS.Rmd"),
       output_dir = here::here("output", folder_loc))

# FMQ State Hospital 
render(here::here("markdown", "FMQ_State_Hospital.Rmd"),
       output_dir = here::here("output", folder_loc))