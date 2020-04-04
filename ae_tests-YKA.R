library(tidyverse)
library(soundecology)
library(tuneR)

?soundecology

#read audio files and assign as objects
yka3a <- readWave("data/YKA003A.wav")
yka3b <- readWave("data/YKA003B.wav")

#The above audio files are excerpts from the same site and are
# 3 minute in duration. 

#ACOUSTIC COMPLEXITY INDEX
# The results given are accumulative. 
#  Very long samples will return very large values for ACI. 
#  The developer recommends to divide by number of minutes 
#  to get a range of values easier to compare.
aci.lim <- acoustic_complexity(yka3a, min_freq = 500, max_freq = 6000, j = 5, fft_w = 512) 

aci.all <- acoustic_complexity(yka3b, min_freq = NA, max_freq = NA, j = 5, fft_w = 512)

#yka3a (10am, June 2018) 
#RESULT, min_freq = 500, max_freq 6000
# ACI (total) L: 1345.132, R: 1343.481; ACI (by minute) L: 446.99, R: 446.44
#RESULT, min_freq = N/A, max_freq = N/A
# ACI (total) L: 5601.44, R: 5586.311; ACI (by minute) L: 1861.37, R: 1856.34

#yka3b (10am, April 2019) 
#RESULT, min_freq = 500, max_freq 6000
# ACI (total) L: 1410.126, R: 1413.639; ACI (by minute) L: 468.29, R: 469.46
#RESULT, min_freq = N/A, max_freq N/A
# ACI (total) L: 5916.75, R: 5842.826; ACI (by minute) L: 1964.91, R: 1940.36 

data <- read_csv("data/output.csv")
data

?mutate

data_new <- mutate(data, ACI = (Left_ch + Right_ch) / 2)

data_new

# Include line of code to avg left and right channel observations.

data_new$Date <- as.Date(data_new$Date,format="%d/%m/%Y")

ggplot(
  data = data_new,
  mapping = aes(x = Date, y = ACI, colour = Ident)
) +
  geom_point(alpha = 0.9)
# amend scale so that this goes from zero

view(new_data)

#Q: how to save outputs from Console? R Markdown notebooks, knitr?
# Possible solution:
#cat("Tests output", file = "data/tests.txt")  # Title: this simply writes a title in the txt file
#cat("\n\n", file = "data/tests.txt", append = TRUE)      #add two new lines
#cat("ACI Test\n", file = "data/tests.txt", append = TRUE)
#capture.output(aci.lim, file = "data/tests.txt", append = TRUE")

