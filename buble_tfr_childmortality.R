# World map is available in the maps package
library(maps)
library(geosphere)
library(tidyverse)
library(gapminder)
library(ggplot2)
library(gganimate)
library(ggdark)
library(viridisLite)
library(viridis)
library(readxl)

data <- read_excel("C:/Users/Anup Kumar/Desktop/R-Code/Data_Visualization/buble_chart/Child_Mortality_TFR.xlsx")
#data = data %>% filter(continent == "Asia" |continent == "Africa"| continent == "Europe")
# Make a ggplot, but add frame=year: one image per year
b_anim=ggplot(data, aes(child_mortality,tfr, size = population, color = continent)) +
  geom_point(alpha= 0.8) +
  scale_x_log10() +
  scale_size(range = c(2,40),guide = "none")+
  guides(color = guide_legend(override.aes = list(size = 7), title = "Continents"))+
  dark_theme_classic()+
  labs(title = 'Average number of children vs. child mortality | Year:{frame_time}',
       x = 'Child Mortality', 
       y = 'Children per woman',
       subtitle = "Child mortality measures the share of children that die before their fifth birthday.",
       caption = "Source: United Nations, World Population Prospects (2022)"
  ) +
  theme(plot.title = element_text(size = 15,color = "lightblue"),
        plot.subtitle = element_text(size = 10))+
  geom_text(label = as.integer(data$year), x = min(log(data$population)),
            y = max(data$tfr), hjust = 0, vjust = 1, size = 12,
            color = "black")+
  transition_time(as.integer(year))
b_anim
buble_anim=animate(b_anim)

#Save animated graph
anim_save("C:/Users/Anup Kumar/Desktop/R-Code/Data_Visualization/buble_chart/tfr.gif",)

