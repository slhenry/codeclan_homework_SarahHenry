library(tidyverse)
library(janitor)
library(stringr)
library(assertr)

# read in data 
meteorite_data <- read_csv("data/meteorite_landings.csv")

# view data 
glimpse(meteorite_data)
head(meteorite_data)
names(meteorite_data)

# clean up column names to standard format
meteroite_data_clean <- clean_names(meteorite_data)

# split geo_location column into 2 new columns (latitute and longitude)
meteroite_data_new_col <- meteroite_data_clean %>% 
  separate(geo_location, c("latitude", "longitude"), sep = ", ")

# clean up brackets in the new columns
meteorite_data_long_lat <- meteroite_data_new_col %>% 
  mutate(latitude = str_sub(latitude, start = 2, end = -1),
         longitude = str_sub(longitude, end = -2),
         latitude = as.numeric(latitude),
         longitude = as.numeric(longitude))


# Replace any missing values in latitude and longitude with zeros.
meteoite_no_nas <- meteorite_data_long_lat %>%
  mutate(latitude = coalesce(latitude, 0, na.rm = TRUE),
         longitude = coalesce(longitude, 0, na.rm = TRUE))

# check no remaining NAs in latitude or longitude
meteoite_no_nas %>% 
  filter(is.na(latitude))

# remove meteorites weighing less than 1000g from the data set
meteorite_1kg_above <- meteoite_no_nas %>% 
  filter(mass_g > 1000)

# order the data by the year of discovery
meteorite_data_clean <- meteorite_1kg_above %>% 
  arrange(year)

# verify the data to check range of values for latitude and longitude are valid
meteorite_data_clean %>% 
  verify(latitude >= -90 & latitude <= 90) %>% 
  verify(longitude >= -180 & longitude <= 180)

meteorite_data_clean %>% 
  distinct(fall)

# write meteorite_data_clean into csv file and save
write_csv(meteorite_data_clean, "data/meteorite_data_clean.csv", append = FALSE)
         


