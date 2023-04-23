# helpers.R

library(shiny)
library(tidyverse)
library(plotly)
library(shinyWidgets)


game_sales <- CodeClanData::game_sales

genre_list <- game_sales %>% 
  distinct(genre) %>% 
  pull() %>% 
  sort()
