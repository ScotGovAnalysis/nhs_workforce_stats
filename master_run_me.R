#######################################
# master_run_me.R
# Script to produce all the products produced by RAP - quarterly official workforce stats 

######################################

# Run to prepare data required for all analysis
source(here::here("code", "01_prepare_data.R"))


# Run to produce the Scotland table template
source(here::here("code", "02_scotland_table.R"))


# Run to produce the territorial board table
source(here::here("code", "03_territorial_board_table.R"))


# Run to produce the markdowns
source(here::here("code", "04_render_markdowns.R"))
