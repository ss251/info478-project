library(dplyr)
library(ggplot2)
library(plotly)
library(tidyr)
library(stringr)

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
  ggtitle(label = "Causes & Unimproved Drinking Water in the Bottom 10% of Countries")

# By country / grouped 
countries <- unique(gbd_dalys$location)

percent_contr <- data.frame()

for (i in countries) {
  country_gbd_dalys <- gbd %>% filter(location == i)
  
  total_dalys = sum(country_gbd_dalys$val) 
  
  country_gbd_dalys <- country_gbd_dalys %>% 
    mutate(percentage_contribution = val / total_dalys) 
  percent_contr = rbind(percent_contr, country_gbd_dalys)
}
  
concerned_causes <- cause_count$cause 
water_damage <- filter(percent_contr, cause %in% concerned_causes) %>%
  select(location, cause, percentage_contribution)

temp_set <- water_damage %>% filter(cause == "Malaria", location %in% countries)
temp_set2 <- water_damage %>% filter(cause == "Neonatal disorders", location %in% countries)

fig <- plot_ly(temp_set, x=~location, y=~percentage_contribution, type ="bar", name = "Malaria") %>%
  add_trace(temp_set2, x=~location, y=~percentage_contribution, name = "Neonatal")%>%
  layout(yaxis = countries, barmode = "stack")

water_damage_pivot <- pivot_wider(water_damage, names_from = cause, values_from = percentage_contribution)
names(water_damage_pivot)<-str_replace_all(names(water_damage_pivot), c(" " = "." , "," = "" ))
concerned_causes <- str_replace_all(concerned_causes, c(" " = "." , "," = "" ))

concerned_causes = c("Diabetes.and.kidney.diseases", 
                     "Diabetes.mellitus", 
                     "Diabetes.mellitus.type.2", 
                     "Cardiovascular.diseases", 
                     "Diarrheal.diseases", 
                     "Malaria", 
                     "Enteric.infections", 
                     "Lower.respiratory.infections", 
                     "Respiratory.infections.and.tuberculosis", 
                     "Communicable.maternal.neonatal.and.nutritional.diseases", 
                     "Neonatal.disorders", 
                     "Maternal.and.neonatal.disorders", 
                     "Non-communicable.diseases"
                     )

fig <- plot_ly(water_damage_pivot, x = ~location, y = water_damage_pivot$Malaria, type = 'bar', name = 'Malaria') 
for (i in concerned_causes) {
  temp =  water_damage_pivot[[i]]
  fig <- fig %>% add_trace(y = temp, name = i) 
}
fig <- fig %>% layout(title = "Common Water Related Health Burdens & DALY Proportions", xaxis = list(title = 'Country', autorange = TRUE), yaxis = list(title = 'Total DALY Proportion', autorange = TRUE), barmode = 'stack')


# Calculate percent for every country
countries <- unique(gbd$location)

percent_contr <- data.frame()

for (i in countries) {
  country_gbd_dalys <- gbd %>% filter(location == i)
  
  total_dalys = sum(country_gbd_dalys$val) 
  
  country_gbd_dalys <- country_gbd_dalys %>% 
    mutate(percentage_contribution = val / total_dalys) 
  percent_contr = rbind(percent_contr, country_gbd_dalys)
}
