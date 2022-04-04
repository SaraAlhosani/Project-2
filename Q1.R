## Question 1: From 1999 to 2008, Have total emissions from PM2.5 DECREASED in US? 
#Plot 1 use based plotting system
# Plot the total US PM2.5 Emissions by Year 1999, 2002, 2005 ,2008.

  dir.create("data")
  download.file(fileURL, zipFilePath, method="curl")
  unzip(zipFilePath, exdir = subdirectory) 

SCCFile <- "C:/Users/200062/Downloads/exdata_data_NEI_data/Source_Classification_Code.rds"
summarySCC_PM25File <- "C:/Users/200062/Downloads/exdata_data_NEI_data/summarySCC_PM25.rds"

# Reading files
NEI <- readRDS(summarySCC_PM25File)
SCC <- readRDS(SCCFile)

# Calculate the sum of emission per year and assigned it to totalPM25ByYear
totalPM25ByYear <- tapply(NEI$Emissions, NEI$year, sum)

# Plotting the results
plot(names(totalPM25ByYear), totalPM25ByYear, type = "l",
     xlab = "Year", ylab = expression("Total" ~ PM[2.5] ~ "Emissions (tons)"),
     main = expression("Total US" ~ PM[2.5] ~ "Emissions by Year"))

# Copy Plot in png-file
dev.copy(device = png, filename = 'plot1.png', width = 500, height = 400)


