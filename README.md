---
title: "NHS Scotland Official Statistics RAP"
author: "Workforce and Pay Analytics"
date: "`r format(Sys.Date(), '%d %B %Y')`"
output: word_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = FALSE)
```


```{r colours, include=TRUE}
```


## Official Statistics for NHS Scotland workforce

This project contains the codes and outputs for the quarterly official statistics of NHS Scotland Workforce published by NES on Turas dashboards. 

## Data sources

The following data tables are used for analysis: 

- [Detailed employment (WTE)](https://turasdata.nes.nhs.scot/data-and-reports/national-workforce-planning-and-analysis/employment-and-vacancy-time-series-from-2006/?pageid=7850)
- [WTE and headcount by jobfamily and board](https://turasdata.nes.nhs.scot/data-and-reports/national-workforce-planning-and-analysis/employment-and-vacancy-time-series-from-2006/?pageid=7850)
- [Data table - employment](https://turasdata.nes.nhs.scot/data-and-reports/official-workforce-statistics/all-official-statistics-publications/?pageid=1302)


## Code layout

### 00_setup.R
Script to setup environment for running the quarterly official workforce stats.
Script requires manual updates before running others.
Loads in libraries required in all scripts.
Creates sub-folders for the output and markdown folders.

### 01_prepare_data.R
Script reads, cleans and saves out data, which are subsequently used in all other codes, particularly for briefing & FMQ markdowns.

### 02_Scotland_table.R
For the creation of Scotland table. 
This table outputs data for particular specialties based on workforce policy interests, which is pasted into the Excel workbook for comparison with other time points. 

### 03_territorial_board_table.R
For the creation of Territorial board table/workbook and FMQ territorial board (copied from workbook).
This table outputs data for particular consultant specialties, nursing and midwifery (N&M), doctors in training, other M&D staff grades and allied health profession (AHP). 
This is based on workforce policy interests.
Output is pasted into and used for the territorial board workbook for comparisons with previous year and 2006.
The workbook is used for territorial board FMQ populated by workforce policy.

### 04_render_markdowns.R
To output and save markdown in the appropriate folder.

### Workforce_core_brief.Rmd
This markdown produces a word document that contains data lines that can be pasted into the core brief provided by workforce policy colleagues. 


### Ministerial_briefing_NHS_workforce.Rmd
This markdown produces a word document that contains the "Main facts & statistics" section of the ministerial briefing. 


### FMQs.Rmd
For the creation of word documents created from markdowns. 
The FMQs include: 

- FMQ A&E
- FMQ Cancer
- FMQ Maternity
- FMQ NHS24
- FMQ NHS workforce
- FMQ Scottish Ambulance Service
- FMQ State Hospital

These documents are sent to the relevant policy colleagues. 


### Master script
This script would run all other scripts and markdowns. 

