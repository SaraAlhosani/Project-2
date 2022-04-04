##Question 5


# Load the 2 libraries
library(dplyr)
library(ggplot2)


SCCFile <- "C:/Users/200062/Downloads/exdata_data_NEI_data/Source_Classification_Code.rds"
summarySCC_PM25File <- "C:/Users/200062/Downloads/exdata_data_NEI_data/summarySCC_PM25.rds"

# Read both files
NEI <- readRDS(summarySCC_PM25File)
SCC <- readRDS(SCCFile)

# Fetch data of BaltimoreCity and ON-ROAD
BaltimoreCityMV <- subset(NEI, fips == "24510" & type=="ON-ROAD")

# Calculate the sum of emission by year
B_Motor_PM25ByYear <- BaltimoreCityMV %>% select (year, Emissions) %>% 
  group_by(year) %>% 
  summarise_each(funs(sum))

# Plot the result of the emissions from the sources changed of motor vehicle in Baltimore City from the year of 1999 to the year of 2008

qplot(year, Emissions, data=B_Motor_PM25ByYear, geom="line") +
  ggtitle(expression("Baltimore City" ~ PM[2.5] ~ "Motor Vehicle Emissions by Year")) +
  xlab("Year") + 
  ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tons)"))

#Plot5.png
dev.copy(device = png, filename = 'plot5.png', width = 500, height = 400)
