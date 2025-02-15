
##1.	5 pts. Explain the following concepts about ggplot 
#a.	What three elements do you need to produce a ggplot? Dataframe, aesthetics, Geom
#b.	What is a geom?  tells ggplot2 how you want to visualize the data. Do you want points, lines, bars, boxes, etc
#c.	What is a facet? way to create multiple plots based on different groups in your data
#d.	Explain the concept of layering. We can add different kind of elements and build the plot step by step
#e.	Where do you add x and y variables and map different shapes, colors, and other attributes to the data? Aesthetics

##Load Data and check for na
datum = read.csv("C:/Users/ASUS/Desktop/Reproduciblity_2025/DON_data.csv")
datum_1 = read.csv("C:/Users/ASUS/Desktop/Reproduciblity_2025/DON_data.csv", na.strings = c("na"))

head(datum)
str(datum)
summary(datum)
datum_1$Biorep=as.factor(datum_1$Biorep)

###Q2.	Make a boxplot using ggplot with DON as the y variable, treatment as the x variable, 
##and color mapped to the wheat cultivar. 
##Show the code you use to load the libraries you need to read in the data and make the plot. 
##Change the y label to “DON (ppm)” and make the x label blank.

library(ggplot2)

ggplot(datum_1, aes(x = Treatment, y = DON )) +
  geom_boxplot(aes(color = Biorep))+
  xlab("")+
  ylab("DON(ppm)")

##Q3 Now convert this data into a bar chart with standard-error error bars using the stat_summary() command.
ggplot(datum_1, aes(x = Treatment, y = DON ,group = Biorep)) +
  stat_summary(fun=mean,geom ="line",aes(color = Biorep)) +
  stat_summary(fun.data = mean_se, geom = "errorbar",aes(color= Biorep))+
  xlab("")+
  ylab("DON(ppm)")

##4.Add points to the foreground of the boxplot and bar chart you made in question 3 
#that show the distribution of points over the boxplots. 
#Set the shape = 21 and the outline color black (hint: use jitter_dodge).

ggplot(datum_1, aes(x = Treatment, y = DON)) +
  geom_boxplot(aes(color = Biorep)) +
  geom_point(aes(color = Biorep), 
             Position = position_jitterdodge(jitter.width = 0.2, dodge.width = 0.75),
             shape = 21, fill = "black") +
  xlab("") +
  ylab("DON(ppm)")

##barchart

ggplot(datum_1, aes(x = Treatment, y = DON, group = Biorep)) +
  stat_summary(fun = mean, geom = "line", aes(color = Biorep)) +
  stat_summary(fun.data = mean_se, geom = "errorbar", aes(color = Biorep)) +
  geom_point(aes(color = Biorep),
             position = position_jitterdodge(jitter.width = 0.2, dodge.width = 0.75),
             shape = 21, fill = "black") +
  xlab("") +
  ylab("DON(ppm)")


##5.	2 pts. Change the fill color of the points and boxplots 
# to match some colors in the following colorblind pallet.
##cbbPalette <- c("#000000", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")

##create an object cbbPalette, add scale_fill (for inside the boxplot) and scale_color but onces outside.
cbbPalette <- c("#F0E442", "#56B4E9", "#009E73")
ggplot(datum_1, aes(x = Treatment, y = DON, fill = Biorep)) +
  geom_boxplot() +
  geom_point(position = position_jitterdodge(jitter.width = 0.2, dodge.width = 0.75),
             shape = 21) +
  ylab("DON (ppm)") +
  scale_fill_manual(values = cbbPalette)

##creates a cbb palttete code for barchart 
cbbPalette2 <- c("#F0E442", "#56B4E9", "#009E73")
ggplot(datum_1, aes(x = Treatment, y = DON, group = Biorep, color = Biorep)) +
  stat_summary(fun = mean, geom = "line") +
  stat_summary(fun.data = mean_se, geom = "errorbar", width = 0.2) +
  geom_point(position = position_jitterdodge(jitter.width = 0.2, dodge.width = 0.75),
             shape = 21) +
  xlab("") +
  ylab("DON(ppm)")+
  scale_color_manual(values = cbbPalette2) 


###6.	2 pts. Add a facet to the plots based on cultivar.

#Faceting for boxplot 

cbbPalette <- c("#F0E442", "#56B4E9", "#009E73")
ggplot(datum_1, aes(x = Treatment, y = DON, fill = Biorep)) +
  geom_boxplot() +
  geom_point(position = position_jitterdodge(jitter.width = 0.2, dodge.width = 0.75),
             shape = 21) +
  ylab("DON (ppm)") +
  scale_fill_manual(values = cbbPalette) +
  facet_wrap(~ Biorep)

#Faceting Barchart

cbbPalette2 <- c("#F0E442", "#56B4E9", "#009E73")
ggplot(datum_1, aes(x = Treatment, y = DON, group = Biorep, color = Biorep)) +
  stat_summary(fun = mean, geom = "line") +
  stat_summary(fun.data = mean_se, geom = "errorbar", width = 0.2) +
  geom_point(position = position_jitterdodge(jitter.width = 0.2, dodge.width = 0.75),
             shape = 21) +
  xlab("") +
  ylab("DON(ppm)")+
  scale_color_manual(values = cbbPalette2)+
  facet_wrap(~Biorep)

###7.	2 pts. Add transparency to the points so you can still see the boxplot or bar in the background. 
##alpha is used to make it transparent, based on values between 0 and 1 
cbbPalette <- c("#F0E442", "#56B4E9", "#009E73")
ggplot(datum_1, aes(x = Treatment, y = DON, fill = Biorep)) +
  geom_boxplot() +
  geom_point(position = position_jitterdodge(jitter.width = 0.2, dodge.width = 0.75),
             shape = 21, alpha = 0.5) +
  ylab("DON (ppm)") +
  scale_fill_manual(values = cbbPalette) +
  facet_wrap(~ Biorep)

##8.	2 pts. Explore one other way to represent the same data https://ggplot2.tidyverse.org/reference/ . Plot them and show the code here. Which one would you choose to represent your data and why? 

##We use geom_violin for this using geom_violin 

ggplot(datum_1, aes(x = Treatment, y = DON, fill = Biorep)) +
  geom_violin(alpha = 0.5) + 
  geom_jitter(aes(color = Biorep), position = position_jitter(width = 0.2), shape = 16, size = 2) +
  scale_fill_manual(values = cbbPalette) +  
  scale_color_manual(values = cbbPalette) + 
  ylab("DON (ppm)") +
  xlab("") +
  theme_bw()

