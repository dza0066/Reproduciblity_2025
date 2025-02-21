
##Load data 

datum = read.csv("MycotoxinData.csv", na.strings = "na")
head(datum)
str(datum)

library(ggplot2)

#load cbb palette
cbbPalette <- c("#000000", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")

Plot_1 = ggplot(datum, aes(x = Treatment, y = DON, fill = Cultivar)) +  
  geom_boxplot(position = position_dodge(), outlier.shape = NA, color = "black") +  # Boxplot with black outline
  geom_point(position = position_jitterdodge(dodge.width = 0.75), 
             shape = 21, color = "black", alpha = 0.6) +  # Jitter points with black outline and fill by Cultivar
  scale_fill_manual(values = c("#56B4E9", "#009E73")) +  # Manual fill colors
  ylab("DON (ppm)") +
  xlab("") +
  facet_wrap(~ Cultivar) +  # Facet by Cultivar
  theme_classic()  # Classic theme

Plot_1 ##display plot_1

##Q2.	4pts. Change the factor order level so that the treatment 
#“NTC” is first, followed by “Fg”, “Fg + 37”, “Fg + 40”, and “Fg + 70. 
unique(datum$Treatment)

datum$Treatment = factor(datum$Treatment, levels = c ("NTC","Fg","Fg + 37","Fg + 40","Fg + 70"))

Plot_2 = ggplot(datum, aes(x = Treatment, y = DON, fill = Cultivar)) +  
  geom_boxplot(position = position_dodge(), outlier.shape = NA, color = "black") +  # Boxplot with black outline
  geom_point(position = position_jitterdodge(dodge.width = 0.75), 
             shape = 21, color = "black", alpha = 0.6) +  
  scale_fill_manual(values = c("#56B4E9", "#009E73")) + #inside boxplot
  ylab("DON (ppm)") +
  xlab("") +
  facet_wrap(~ Cultivar) +  # Facet by Cultivar
  theme_classic()  # Classic theme

#3.	5pts. Change the y-variable to plot X15ADON and MassperSeed_mg. 
#The y-axis label should now be “15ADON” and “Seed Mass (mg)”. 
#Save plots made in questions 1 and 3 into three separate R objects.

Plot_3 = ggplot(datum, aes(x = Treatment, y = MassperSeed_mg, fill = Cultivar)) +  
  geom_boxplot(position = position_dodge(), outlier.shape = NA, color = "black") +  
  geom_point(position = position_jitterdodge(dodge.width = 0.75), 
             shape = 21, color = "black", alpha = 0.6) +  
  scale_fill_manual(values = c("#56B4E9", "#009E73")) +  
  ylab("Seed Mass (mg)") +
  xlab("") +
  facet_wrap(~ Cultivar) +  
  theme_classic()

##4.	5pts. Use ggarrange function to combine all three figures into one with three columns and one row. 
##Set the labels for the subplots as A, B and C. 
##Set the option common.legend = T within ggarage function. 
#What did the common.legend option do?
#a.	HINT: I didn’t specifically cover this in the tutorial, but you can go to 
#the help page for the ggarange 
#function to figure out what the common.
#legend option does and how to control it. 
library(ggpubr)
library(ggrepel)
combined_plot = ggarrange(Plot_1, Plot_2, Plot_3, 
                           labels = c("auto"), 
                           ncol = 2, nrow = 2, 
                           common.legend = TRUE, 
                           legend = "right")


combined_plot #display combined plot

##The common.legend = TRUE option in ggarrange() gives a unfied legend to all 
##the subplots
##helps reduce redundcancy

##5.	5pts. Use geom_pwc() to add t.test pairwise comparisons to the three plots 
#made above. Save each plot as a new R object, and combine them again with 
#ggarange as you did in question 4. 

library(ggpubr)
##add t_test pairwise comaparison to Plot_1 using geom_pwc
Plot_1_pwc <- Plot_1 +
  geom_pwc(aes(group=Treatment), method ="t_test", label = "p.adj.signif") 


Plot_1_pwc #display pairwise comparison plot for Plot_1

##add t_test pairwise comaparison to Plot_2 using geom_pwc 
Plot_2_pwc <- Plot_2 +
  geom_pwc(aes(group=Treatment), method = "t_test", label ="p.adj.signif")

Plot_2_pwc
##add t_test pairwise comaparison to Plot_3 using geom_pwc 
Plot_3_pwc <- Plot_3 +
  geom_pwc(aes(group=Treatment), method = "t_test", label ="p.adj.signif")

Plot_3_pwc

#6 Create a combined plot using ggarrange abd labe plots as auto for naming the 
##panels and add common legend for variety
combined_pwc_plot <- ggarrange(Plot_1_pwc, Plot_2_pwc, Plot_3_pwc, 
                               labels = c("auto"), 
                               ncol = 3, nrow = 1, 
                               common.legend = TRUE, 
                               legend = "right")  # Place common legend on the 
                                                  #right

# Display the combined plot with pairwise comparisons
combined_pwc_plot


