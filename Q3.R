## Question 3

# Loading dplyr and ggplot2 libraries
library(dplyr)
library(ggplot2)


SCCFile <- "C:/Users/200062/Downloads/exdata_data_NEI_data/Source_Classification_Code.rds"
summarySCC_PM25File <- "C:/Users/200062/Downloads/exdata_data_NEI_data/summarySCC_PM25.rds"

# Read files
NEI <- readRDS(summarySCC_PM25File)
SCC <- readRDS(SCCFile)

# Fetch data of Baltimore City
CityofBaltimore <- subset(NEI, fips == "24510")

# Calculate the sum of emission by the type variable from 1999 to 2008.
typeofB <- CityofBaltimore %>% select (year, type, Emissions) %>% 
  group_by(year, type) %>% 
  summarise_each(funs(sum))

# Using the plot system to show the answer
qplot(year, Emissions, data = typeofB, color = type, geom = "line") +
  ggtitle(expression("Baltimore City" ~ PM[2.5] ~ "Emissions by Source Type and Year")) +
  xlab("Year") +
  ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tons)"))

#Plot 3.png 
dev.copy(device = png, filename = 'plot3.png', width = 500, height = 400)
