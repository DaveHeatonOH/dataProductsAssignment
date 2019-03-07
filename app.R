library(dplyr)
library(rgdal)

# Read in the population data
popData <-read.csv("Data/gp-reg-pat-prac-all.csv")

# Read in the mapping data (Practice to CCG, STP, Region)
practiceMapping <- read.csv(("Data/gp-reg-pat-prac-map.csv"))

# Read in the postcode lat longs
latLong <- read.csv("Data/ukpostcodes.csv")

# Join to get the Practice Name
popData <- left_join(popData, practiceMapping[,c(3,4)], by = c("CODE" = "PRACTICE_CODE"))

# Join to get the CCG Name
popData <- left_join(popData, unique(practiceMapping[,c(7,8)]))

# Join to get the lat and long for each org
popData <- left_join(popData, latLong[,c(2:4)], by = c("POSTCODE" = "postcode"))