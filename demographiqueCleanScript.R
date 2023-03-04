# 0.0 Goal ----
# This code aims to tidy the data from a messy MS excel spreadsheet

# 0.1 Libraries ---
# install.packages("pacman")
library(pacman)
p_load(tidyverse, janitor, readxl, tmap, nycflights13,leaflet, sp, sf,leaflet.extras)

# # Read in the data
# demo_data <- read_excel("Projection démographiques 2017-2042 Inseed Comores.xlsx", sheet = "Structure 2018-2042")
#
# # Filter the data
# filtered_data <- demo_data %>%
#   filter(`Population by age and sex  - (Total) (Male+Female)` %in% c("Decoupage", "Total"))
#
# # Use meaningful variable names
# filtered_data <- select(filtered_data, 2:13)
#
# # Convert columns to character
# demo_data_v2 <- as.data.frame(lapply(filtered_data, as.character))
#
# # Add new row
# new_row <- c("Total_National", "Male_National", "Female_National", "Total_Mohéli", "Male_Mohéli", "Female_Mohéli",
#              "Total_Anjouan", "Male_Anjouan", "Female_Anjouan", "Total_Grande Comore", "Male_Grande Comore", "Female_Grande Comore")
#
#
# demo_data_v3 <- rbind(demo_data_v2, new_row)
#
# # Subset demo_data_v3 and assign column names
# demo_data_v4 <- setNames(demo_data_v3[1:25, ], demo_data_v3[26, ])
#
# # Convert to long format
# demo_data_v5 <- pivot_longer(demo_data_v4, cols = c(1:12),
#                              names_to = "variable",
#                              values_to = "value")
#
# demo_datav6 <- demo_data_v5 %>%
#   mutate(annee = rep(c(2018:2042), each = 12)) %>%
#   separate(variable, c("sex", "decoupage"), sep = "_") %>%
#   select(4,2,1,3) %>%
#   mutate(value = as.numeric(value))
#
#
# kmDemoData <- demo_datav6
#
# save(kmDemoData, file = "kmDemoData.Rdata")

load("kmDemoData.Rdata")

# select data for 2023

kmData2023 <- kmDemoData %>%
  filter(annee == 2023)


# usage of comoros maps
library(comorosmaps)

map <- comoros("island")

population_stDB <- map %>%
  left_join(kmData2023, by = c("name" = "decoupage")) %>%
  pivot_wider(id_cols = c("name", "annee", "geometry"),
              names_from = "sex",
              values_from = "value")


tmap_mode("view") # in order to set tmap interactive
try <- tm_shape(population_stDB ) +
  tm_fill()




# using Leaflet
# poly_centroid <- st_centroid(population_stDB) %>%
#   mutate(lng = st_coordinates(.)[1],
#          lat = st_coordinates(.)[2]) %>%
#   mutate(value_formatted = format(value, big.mark = " "))
#
# try_leaflet <- tmap_leaflet(try) %>%
#   addMarkers(data = poly_centroid,
#              label = paste(poly_centroid$name, "<br>",
#                            poly_centroid$value_formatted, "habitants") %>%
#                lapply(htmltools::HTML))



library(tidyr)

# create a sample data frame
df <- data.frame(id = c(1, 2, 3),
                 category = c("A", "B", "C"),
                 value = c(10, 20, 30))

# reshape the data frame from long to wide for the "category" column
df_wide <- pivot_wider(df, id_cols = id, names_from = category, values_from = value)








