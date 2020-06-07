water <- read.csv("./water2.csv")
gbd <- read.csv("./IHME-GBD_2017_DATA-9836e5da-2.csv")



dalys_new <- gbd %>%
  filter(measure == "DALYs (Disability-Adjusted Life Years)") %>% 
  filter(metric == "Percent") %>% 
  arrange(-val) %>% 
  filter(cause != "All causes")

water_quality <- water %>% 
  select(location = Geographic.Area,
         limited_water = X2017_Proportion.of.population.using.limited.drinking.water.services,
         unimproved_water = X2017_Proportion.of.population.using.unimproved.drinking.water.sources
  ) %>% 
  filter(!is.na(limited_water), !is.na(unimproved_water))

burden_data <- left_join(dalys_new, water_quality, by = "location") %>% 
  filter(!is.na(limited_water), !is.na(unimproved_water))


burden_limited <- burden_data %>% 
  arrange(-X2017_Proportion.of.population.using.limited.drinking.water.services)

limited_dalys = ggplot(burden_limited, aes(x = val, y = X2017_Proportion.of.population.using.limited.drinking.water.services))+
  geom_point() +
  geom_smooth() +
  labs(x = "DALYs Percent",
       y = "Prop of pop using limited drinkg water",
       title = "DALYs Percent vs prop of limited drinking water")

burden_unimproved <- burden_data %>% 
  arrange(-X2017_Proportion.of.population.using.unimproved.drinking.water.sources)

unimproved_dalys = ggplot(burden_unimproved, aes(x = val, y = X2017_Proportion.of.population.using.unimproved.drinking.water.sources))+
  geom_point() +
  geom_smooth() +
  labs(x = "DALYs Percent",
       y = "Prop of pop using limited drinkg water",
       title = "DALYs Percent vs prop of unimproved drinking water")

