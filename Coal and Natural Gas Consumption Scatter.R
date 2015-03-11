
#read in data
energy <- read.csv("DOE_EnergyConsumption.csv")

#should be 6980 rows
dim(energy)

#subset out the subtotals & subset the years to just 5 years, and subset out 0s
energy <- subset(energy, Region != 'None')
energy <- subset(energy, Year == 1985 | Year == 1991 | Year == 1997 | Year == 2003 | Year == 2009)
energy <- subset(energy, CoalConsumption > 0 | NaturalGasConsumption > 0)


#should be 647 rows
dim(energy)

#transform the Year variable into a factor
energy <- transform(energy, Year = factor(Year))

#get the initial scatterplot, by Coal Consumption and Natural Gas Consumption
library(ggplot2)
myGraph <- ggplot(data = energy, aes(x = CoalConsumption, y = NaturalGasConsumption))

#add the points
myGraph <- myGraph + geom_point(alpha = 1/2, size=3)

#fact by year
myGraph <- myGraph + facet_wrap(~Year)

#color by region
myGraph <- myGraph + aes(color=Region)

#log scale
myGraph <- myGraph + scale_x_log10() + scale_y_log10()

#set the background to white
myGraph <- myGraph + theme(panel.background = element_rect(fill = 'white', colour = 'gray'))

#colorblind palette courtesy of http://www.cookbook-r.com/Graphs/Colors_%28ggplot2%29/
cbPalette <- c("#000000", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")
myGraph + scale_colour_manual(values=cbPalette)



