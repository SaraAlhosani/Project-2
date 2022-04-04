#Question 2: Did it decreased in the Baltimore City, Maryland
## (fips == "24510") from 1999 to 2008?

# Load dplyr library
library(dplyr)



SCCFile <- "C:/Users/200062/Downloads/exdata_data_NEI_data/Source_Classification_Code.rds"
summarySCC_PM25File <- "C:/Users/200062/Downloads/exdata_data_NEI_data/summarySCC_PM25.rds"

# Read files
NEI <- readRDS(summarySCC_PM25File)
SCC <- readRDS(SCCFile)

# Fetch data of Baltimore City Maryland
BaltimoreMa<-subset(NEI, fips == "24510")

# Calculate the sum of emission by year
totalPM25BperY <- tapply(BaltimoreMa$Emissions,BalitmoreMa$year,sum)

# Using ggplot2 plotting system to plot the answer/result
plot(names(totalPM25BperY), totalPM25BperY, type = "l", xlab = "Year", 
     ylab = expression("Total" ~ PM[2.5] ~ "Emissions (tons)"), 
     main = expression("Total of Baltimore City" ~ PM[2.5] ~ "Emissions for Year"))

#Plot copied (png file)
dev.copy(device = png, filename = 'plot2.png', width = 500, height = 400)
