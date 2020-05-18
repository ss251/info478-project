water <- read.csv("./water2.csv")
gbd <- read.csv("./IHME-GBD_2017_DATA-9836e5da-2.csv")



gbd_dalys <- gbd %>%
  filter(measure == "DALYs (Disability-Adjusted Life Years)") %>% 
  filter(metric == "Rate") %>% 
  filter(cause == "All causes") %>% 
  arrange(-val) %>% 
  top_n(10) 


compare_water <- water %>% 
  select(Geographic.Area, Sex,
        X2017_Proportion.of.population.using.limited.drinking.water.services,
        X2017_Proportion.of.population.using.unimproved.drinking.water.sources
        ) %>% 
  rename(location = Geographic.Area)

new_data <- left_join(gbd_dalys, compare_water, by = "location")

completeFun <- function(data, desiredCols) {
  completeVec <- complete.cases(data[, desiredCols])
  return(data[completeVec, ])
}

top_dalys <- completeFun(new_data, "X2017_Proportion.of.population.using.limited.drinking.water.services")

dalys_limitedwater = ggplot(top_dalys, aes(x = val, y = X2017_Proportion.of.population.using.limited.drinking.water.services))+
  geom_point() +
  geom_text(aes(label=location), size = 4)+
  labs(x = "DALYs Rate of top 8 countries",
       y = "Prop of pop using limited drinkg water",
       title = "DALYs rate vs prop of limited drinking water")

dalys_unimproved = ggplot(top_dalys, aes(x = val, y = X2017_Proportion.of.population.using.unimproved.drinking.water.sources))+
  geom_point() +
  geom_text(aes(label=location), size = 4)+
  labs(x = "DALYs Rate of top 8 countries",
       y = "Prop of pop using unimproved drinkg water",
       title = "DALYs rate vs prop of unimproved drinking water")  



