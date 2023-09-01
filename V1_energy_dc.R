rm(list=ls())
library(tidyverse)

## 
url <- "https://nyc3.digitaloceanspaces.com/owid-public/data/energy/owid-energy-data.csv"
df <- url %>%
  read_csv()

list <- c("Norway", "Sweden", "Denmark", "Finland", "Iceland")

## TEKST 1 

df %>%

  filter(country %in% list) %>% 
  
  filter(year >= 1985) %>%
  
  ggplot(aes(x=year, y=wind_share_elec, color = country)) %>%
  
  + geom_line(size = 1.5) %>%
  
  + labs(title = "Wind power share of electricity generation",
         subtitle = "Percent. 1985-2022. Source: Our World In Data",
         y = "Wind power share", 
         x = "Year",
         color = "Country") %>%
  
  + theme_bw() %>%
  
  + theme(panel.grid.major = element_line(color = "black",
                                        size = 0.25,
                                        linetype = 3))

#########################################################
# la oss endre legenden til Norsk

translation <- c("Norway" = "Norge", 
                 "Sweden" = "Sverige", 
                 "Denmark" = "Danmark", 
                 "Finland" = "Finland",  
                 "Iceland" = "Island")


df %>%
  filter(country %in% list) %>% 
  filter(year >= 1985) %>%
  ggplot(aes(x=year, y=wind_share_elec, color = country)) +
  geom_line(size = 1.5) +
  labs(title = "Wind power share of electricity generation",
       subtitle = "Percent. 1985-2022. Source: Our World In Data",
       y = "Wind power share", 
       x = "Year",
       color = "Land") + # endre tittel på legenden
  theme_bw() +
  scale_color_discrete(labels = translation) # endre tekst i legenden

############################################################
# Påstand: Island bruker 0?

df %>%
  filter(country == "Iceland") %>% 
  filter(year >= 1985) %>%
  ggplot(aes(x=year, y=wind_share_elec, color = country)) +
  geom_line(size = 1.5) +
  labs(title = "Wind power share of electricity generation",
       subtitle = "Percent. 1985-2022. Source: Our World In Data",
       y = "Wind power share", 
       x = "Year",
       color = "Land") + # endre tittel på legenden
  theme_bw() +
  scale_color_discrete(labels = translation) # endre tekst i legenden

#############################################################



## TEKST 2

df %>%
  
  filter(country %in% list) %>% 
  
  filter(year >= 1990) %>%
  
  mutate(import_demand = electricity_demand - electricity_generation) %>%
  
  ggplot(aes(x=year, y=import_demand, color = country)) %>%
  
  + geom_point() %>%
  
#  + geom_smooth(se = FALSE) %>%
  
  + labs(title = "Net electricity imports.",
         subtitle = "TWh per year. Domestic electricity demand less generation. 
1990-2022.Source: Our World In Data",
         y = "Electricty demand - generation", 
         x = "Year",
         color = "Country") %>%
  
  + theme_bw() %>%
  
  + theme(panel.grid.major = element_line(color = "black",
                                          size = 0.25,
                                          linetype = 3))


###############################################################

# TEKST 3

df %>%
  
  filter(country %in% c("Japan", "Germany")) %>% 
  
  filter(year >= 1985) %>%
  
  ggplot(aes(y=low_carbon_share_elec, x=year, size=nuclear_share_elec, color = country)) %>%
  
  + geom_line() %>%
  
  + labs(title = "Low-carbon share of electricity generation.",
         subtitle = "Percent. Marker size proportional to nuclear power share of 
electricity generation. 1985-2022. Source: Our World In Data",
         y = "Low-carbon share", 
         x = "Year",
         color = "Country",
         size = "Nuclear share") %>%
  
  + theme_bw() %>%
  
  + ylim(0,60) %>%
  
  + theme(panel.grid.major = element_line(color = "black",
                                          size = 0.25,
                                          linetype = 3))

# prøv på en klarere fremstilling

# størrelse på punkter istedenfor linjetykkelse

df %>%
  
  filter(country %in% c("Japan", "Germany")) %>% 
  
  filter(year >= 1985) %>%
  
  ggplot(aes(y=low_carbon_share_elec, x=year, color = country)) %>%
  
  + geom_line() %>%
  
  + geom_point(aes(size = nuclear_share_elec), alpha = 0.7) %>%
  
  + labs(title = "Low-carbon share of electricity generation.",
         subtitle = "Percent. Marker size proportional to nuclear power share of 
electricity generation. 1985-2022. Source: Our World In Data",
         y = "Low-carbon share", 
         x = "Year",
         color = "Country",
         size = "Nuclear share") %>%
  
  + theme_bw() %>%
  
  + ylim(0,60) %>%
  
  + theme(panel.grid.major = element_line(color = "black",
                                          size = 0.25,
                                          linetype = 3))

# prøv å dele figuren i 2 vha facet_wrap

df %>%
  
  filter(country %in% c("Japan", "Germany")) %>% 
  
  filter(year >= 1985) %>%
  
  ggplot(aes(y=low_carbon_share_elec, x=year, size=nuclear_share_elec, color = country)) %>%
  
  + geom_line() %>%
  
  + facet_wrap(~country) %>% 
  
  + labs(title = "Low-carbon share of electricity generation.",
         subtitle = "Percent. Marker size proportional to nuclear power share of 
electricity generation. 1985-2022. Source: Our World In Data",
         y = "Low-carbon share", 
         x = "Year",
         color = "Country",
         size = "Nuclear share") %>%
  
  + theme_bw() %>%
  
  + ylim(0,60) %>%
  
  + theme(panel.grid.major = element_line(color = "black",
                                          size = 0.25,
                                          linetype = 3))



# del opp informasjon i flere linjer



df %>%
  filter(country %in% c("Japan", "Germany")) %>%
  
  filter(year >= 1985) %>%
  
  ggplot(aes(x = year)) %>% 
  
  + geom_line(aes(y = low_carbon_share_elec, color = country, linetype = "Low-carbon share")) %>% 
  
  + geom_line(aes(y = nuclear_share_elec, color = country, linetype = "Nuclear share")) %>% 
  
  + labs(title = "Low-carbon and nuclear share of electricity generation.",
       subtitle = "1985-2022. Source: Our World In Data",
       x = "Year",
       y = "Percentage Share",
       color = "Country") %>% 
  
  + scale_linetype_manual(name = "Energy source", values = c("Low-carbon share" = "solid", "Nuclear share" = "dashed")) %>% 
  
  + theme_bw() %>% 
  
  + ylim(0, 60) %>% 
  
  + theme(panel.grid.major = element_line(color = "black", size = 0.25, linetype = 3))


#############################################################

# TEKST 4

df %>%
  
  filter(country %in% c("United States", "China", "European Union (27)")) %>% 
  
  filter(year >= 2008) %>%
  
  ggplot(aes(y=solar_electricity, x=year, size = solar_share_elec, color = country)) %>%
  
  + geom_line() %>%
  
  + labs(title = "Solar electricity generation.",
         subtitle = "tWh per year. 2008-2022. Source: Our World In Data",
         y = "Solar power tWh", 
         x = "Year",
         color = "Country",
         size = "Share") %>%
  
  + theme_bw() %>%
  
  + theme(panel.grid.major = element_line(color = "black",
                                          size = 0.25,
                                          linetype = 3))

###################################

# hvordan ser andelen ut?

#er 2, 4 , 6 rimelig?


subset_data <- df %>%
  filter(country %in% c("United States", "China", "European Union (27)")) %>%
  filter(year>=2008) %>% 
  select(country, solar_share_elec)

print(subset_data, n=Inf)

df %>%
  
  filter(country %in% c("United States", "China", "European Union (27)")) %>% 
  
  filter(year >= 2008) %>%
  
  ggplot(aes(y=solar_electricity, x=year, size = solar_share_elec, color = country)) %>%
  
  + geom_line() %>%
  
  + labs(title = "Solar electricity generation.",
         subtitle = "tWh per year. 2008-2022. Source: Our World In Data",
         y = "Solar power tWh", 
         x = "Year",
         color = "Country",
         size = "Share") %>%
  
  + scale_size_continuous(breaks=c(0.5, 1, 2, 3, 4, 5, 6, 7)) %>% # velger inndeling selv
  
  + theme_bw() %>%
  
  + theme(panel.grid.major = element_line(color = "black",
                                          size = 0.25,
                                          linetype = 3))



############

# prøv å fremstille på en annen måte vha tidligere kode

df %>%
  
  filter(country %in% c("United States", "China", "European Union (27)")) %>% 
  
  filter(year >= 2008) %>%
  
  ggplot(aes(y=solar_electricity, x=year,  color = country)) %>%
  
  + geom_line() %>%
  
  + geom_point(aes(size = solar_share_elec), alpha = 0.7) %>% # punkter som angir størrelse
  
  + facet_wrap(~country) %>% # del inn i land
  
  + labs(title = "Solar electricity generation.",
         subtitle = "tWh per year. 2008-2022. Source: Our World In Data",
         y = "Solar power tWh", 
         x = "Year",
         color = "Country",
         size = "Share") %>%
  
  + scale_size_continuous(breaks=c(0.5, 1, 2, 3, 4, 5, 6, 7)) %>% 
  
  + theme_bw() %>%
  
  + theme(panel.grid.major = element_line(color = "black",
                                          size = 0.25, linetype = 3))





