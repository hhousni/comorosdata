# 0.0 Goal ----
# This code aims to tidy the data from a messy MS excel spreadsheet

# 0.1 Libraries ---
install.packages("pacman")
library(pacman)
p_load(tidyverse, janitor, readxl)

# 1.0 Data input ----
demo_data <- read_excel("Projection démographiques 2017-2042 Inseed Comores.xlsx",
                        sheet = "Structure 2018-2042")

# 1.1 Data processing ----
demo_data$`Population by age and sex  - (Total) (Male+Female)`[2] <-  "Decoupage"

demo_datav1 <-  demo_data %>%
  filter(`Population by age and sex  - (Total) (Male+Female)`  %in% c("Decoupage","Total"))

# names first as header
names(demo_datav1) <- demo_datav1 [1,]

demo_datav1 <- demo_datav1[,2:13]

demo_datav1 [] <- lapply (demo_datav1, as.character)

new_row <- c("Total_National","Male_National","Female_National","Total_Mwali","Male_Mwali","Female_Mwali",
                                         "Total_Ndzuwani","Male_Ndzuwani","Female_Ndzuwani","Total_Ngazidja","Male_Ngazidja",
                                         "Female_Ngazidja")

demo_datav2 <- rbind(demo_datav1,new_row)

demo_datav3 <- demo_datav2[c(27,2:26),]

names(demo_datav3) <- demo_datav3[1,]
demo_datav3 <- demo_datav3[2:26,]


demo_datav4 <- pivot_longer(demo_datav3, cols = c(1:12),
                            names_to = "variable",
                            values_to = "value")


demo_datav5 <- demo_datav4 %>%
  mutate(annee = rep(c(2018:2042), each = 12)) %>%
  separate(variable, c("sex","decoupage")) %>%
  select(4,2,1,3) %>%
  mutate(value = as.numeric(value))












