library(dplyr)
library(ggplot2)

water <- read.csv("./water2.csv")
gbd <- read.csv("./IHME-GBD_2017_DATA-1bf0d925-1.csv")

#Find countries with the lowest levels of clean water, the bottom 10%
poor_water <- water %>% 
  select(location = Geographic.Area,
         limited_dwater = X2017_Proportion.of.population.using.limited.drinking.water.services,
         unimproved_dwater = X2017_Proportion.of.population.using.unimproved.drinking.water.sources
  ) %>% 
  filter(!is.na(limited_dwater), !is.na(unimproved_dwater)) 

worst_water <- poor_water %>%
  top_n(floor(nrow(poor_water) * .10))

#Filter 
gbd_dalys <- gbd %>%
  filter(measure == "DALYs (Disability-Adjusted Life Years)", 
         metric == "Rate", 
         cause != "All causes") %>%
  select(location, cause, metric, val, upper, lower) %>% 
  filter(location %in% worst_water$location) %>% 
  group_by(location) %>%
  top_n(n = 10, wt = val)

cause_count = gbd_dalys %>%
  group_by(cause) %>% 
  tally()

#order the data
cause_count = cause_count[order(cause_count$n),]

#Create a historgram that counts that diseases prevalent in each country
common_causes <- ggplot(cause_count, aes(x = reorder(cause, n), y = n)) + 
  geom_bar(stat = "identity") + 
  coord_flip() + 
  labs(x = "Cause of Health Burden", y = "Number of Countries with cause") + 
  ggtitle(label = "Causes & Unimproved Drinking Water")
