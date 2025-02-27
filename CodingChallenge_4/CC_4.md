------------------------------------------------------------------------

1.  4 pts. Explain the following

<!-- -->

1.  YAML header: It is the heading of the markdown file consisting of
    title, author, date, and output format we want(.md, pdf, html or
    word). We can also add variant as gfm for git flavored markdown.

2.  Literate programming

<!-- -->

2.  6 pts. Take the code you wrote for coding challenge 3, question 5,
    and incorporate it into your R markdown file. Some of you have
    already been doing this, which is great! Your final R markdown file
    should have the following elements. \##5. 5pts. Use geom_pwc() to
    add t.test pairwise comparisons to the three plots \#made above.
    Save each plot as a new R object, and combine them again with
    \#ggarange as you did in question 4.

``` r
datum=read.csv("MycotoxinData.csv",na.strings ="na")
```

3.  Make a separate code chunk for the figures plotting the DON data,
    15ADON, and Seedmass, and one for the three combined using
    ggarrange.

``` r
##Load data 

datum = read.csv("MycotoxinData.csv", na.strings = "na")
head(datum)
```

    ##   Treatment Cultivar BioRep MassperSeed_mg   DON X15ADON
    ## 1        Fg  Wheaton      2      10.291304 107.3       3
    ## 2        Fg  Wheaton      2      12.803226  32.6    0.85
    ## 3        Fg  Wheaton      2       2.846667 416.0     3.5
    ## 4        Fg  Wheaton      2       6.500000 211.9     3.1
    ## 5        Fg  Wheaton      2      10.179167 124.0     4.8
    ## 6        Fg  Wheaton      2      12.044444  73.1     3.3

``` r
str(datum)
```

    ## 'data.frame':    197 obs. of  6 variables:
    ##  $ Treatment     : chr  "Fg" "Fg" "Fg" "Fg" ...
    ##  $ Cultivar      : chr  "Wheaton" "Wheaton" "Wheaton" "Wheaton" ...
    ##  $ BioRep        : int  2 2 2 2 2 2 2 2 2 3 ...
    ##  $ MassperSeed_mg: num  10.29 12.8 2.85 6.5 10.18 ...
    ##  $ DON           : num  107.3 32.6 416 211.9 124 ...
    ##  $ X15ADON       : chr  "3" "0.85" "3.5" "3.1" ...

``` r
library(ggplot2)
```

    ## Warning: package 'ggplot2' was built under R version 4.3.3

``` r
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
```

    ## Warning: Removed 4 rows containing non-finite outside the scale range
    ## (`stat_boxplot()`).

    ## Warning: Removed 4 rows containing missing values or values outside the scale range
    ## (`geom_point()`).

![](CC_4_files/figure-gfm/chunk%20for%20the%20figures%20plotting%20the%20DON%20data,%2015ADON,%20and%20Seedmass-1.png)<!-- -->

``` r
##Q2.   4pts. Change the factor order level so that the treatment 
#“NTC” is first, followed by “Fg”, “Fg + 37”, “Fg + 40”, and “Fg + 70. 
unique(datum$Treatment)
```

    ## [1] "Fg"           "Fg + 37"      "Fg + 37 + 40" "Fg + 40"      "Fg + 70"     
    ## [6] "NTC"          "Non-Treated"

``` r
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
Plot_2 
```

    ## Warning: Removed 4 rows containing non-finite outside the scale range
    ## (`stat_boxplot()`).
    ## Removed 4 rows containing missing values or values outside the scale range
    ## (`geom_point()`).

![](CC_4_files/figure-gfm/chunk%20for%20the%20figures%20plotting%20the%20DON%20data,%2015ADON,%20and%20Seedmass-2.png)<!-- -->

``` r
#3. 5pts. Change the y-variable to plot X15ADON and MassperSeed_mg. 
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
Plot_3
```

![](CC_4_files/figure-gfm/chunk%20for%20the%20figures%20plotting%20the%20DON%20data,%2015ADON,%20and%20Seedmass-3.png)<!-- -->

``` r
##4.    5pts. Use ggarrange function to combine all three figures into one with three columns and one row. 
##Set the labels for the subplots as A, B and C. 
##Set the option common.legend = T within ggarage function. 
#What did the common.legend option do?
#a. HINT: I didn’t specifically cover this in the tutorial, but you can go to 
#the help page for the ggarange 
#function to figure out what the common.
#legend option does and how to control it. 
library(ggpubr)
```

    ## Warning: package 'ggpubr' was built under R version 4.3.3

``` r
library(ggrepel)
```

    ## Warning: package 'ggrepel' was built under R version 4.3.2

``` r
combined_plot = ggarrange(Plot_1, Plot_2, Plot_3, 
                           labels = c("auto"), 
                           ncol = 2, nrow = 2, 
                           common.legend = TRUE, 
                           legend = "right")
```

    ## Warning: Removed 4 rows containing non-finite outside the scale range
    ## (`stat_boxplot()`).
    ## Removed 4 rows containing missing values or values outside the scale range
    ## (`geom_point()`).

    ## Warning: Removed 4 rows containing non-finite outside the scale range
    ## (`stat_boxplot()`).

    ## Warning: Removed 4 rows containing missing values or values outside the scale range
    ## (`geom_point()`).

    ## Warning: Removed 4 rows containing non-finite outside the scale range
    ## (`stat_boxplot()`).

    ## Warning: Removed 4 rows containing missing values or values outside the scale range
    ## (`geom_point()`).

``` r
combined_plot #display combined plot
```

![](CC_4_files/figure-gfm/chunk%20for%20the%20figures%20plotting%20the%20DON%20data,%2015ADON,%20and%20Seedmass-4.png)<!-- -->

``` r
##The common.legend = TRUE option in ggarrange() gives a unfied legend to all 
##the subplots
##helps reduce redundcancy

##5.    5pts. Use geom_pwc() to add t.test pairwise comparisons to the three plots 
#made above. Save each plot as a new R object, and combine them again with 
#ggarange as you did in question 4. 

library(ggpubr)
##add t_test pairwise comaparison to Plot_1 using geom_pwc
Plot_1_pwc <- Plot_1 +
  geom_pwc(aes(group=Treatment), method ="t_test", label = "p.adj.signif") 


Plot_1_pwc #display pairwise comparison plot for Plot_1
```

    ## Warning: Removed 4 rows containing non-finite outside the scale range
    ## (`stat_boxplot()`).

    ## Warning: Removed 4 rows containing non-finite outside the scale range
    ## (`stat_pwc()`).

    ## Warning: Removed 4 rows containing missing values or values outside the scale range
    ## (`geom_point()`).

![](CC_4_files/figure-gfm/chunk%20for%20the%20figures%20plotting%20the%20DON%20data,%2015ADON,%20and%20Seedmass-5.png)<!-- -->

``` r
##add t_test pairwise comaparison to Plot_2 using geom_pwc 
Plot_2_pwc <- Plot_2 +
  geom_pwc(aes(group=Treatment), method = "t_test", label ="p.adj.signif")

Plot_2_pwc
```

    ## Warning: Removed 4 rows containing non-finite outside the scale range
    ## (`stat_boxplot()`).

    ## Warning: Removed 4 rows containing non-finite outside the scale range
    ## (`stat_pwc()`).

    ## Warning: Removed 4 rows containing missing values or values outside the scale range
    ## (`geom_point()`).

![](CC_4_files/figure-gfm/chunk%20for%20the%20figures%20plotting%20the%20DON%20data,%2015ADON,%20and%20Seedmass-6.png)<!-- -->

``` r
##add t_test pairwise comaparison to Plot_3 using geom_pwc 
Plot_3_pwc <- Plot_3 +
  geom_pwc(aes(group=Treatment), method = "t_test", label ="p.adj.signif")

Plot_3_pwc
```

![](CC_4_files/figure-gfm/chunk%20for%20the%20figures%20plotting%20the%20DON%20data,%2015ADON,%20and%20Seedmass-7.png)<!-- -->

``` r
# Create a combined plot using ggarrange abd labe plots as auto for naming the 
##panels and add common legend for variety
combined_pwc_plot <- ggarrange(Plot_1_pwc, Plot_2_pwc, Plot_3_pwc, 
                               labels = c("auto"), 
                               ncol = 3, nrow = 1, 
                               common.legend = TRUE, 
                               legend = "right")  # Place common legend on the 
```

    ## Warning: Removed 4 rows containing non-finite outside the scale range
    ## (`stat_boxplot()`).

    ## Warning: Removed 4 rows containing non-finite outside the scale range
    ## (`stat_pwc()`).

    ## Warning: Removed 4 rows containing missing values or values outside the scale range
    ## (`geom_point()`).

    ## Warning: Removed 4 rows containing non-finite outside the scale range
    ## (`stat_boxplot()`).

    ## Warning: Removed 4 rows containing non-finite outside the scale range
    ## (`stat_pwc()`).

    ## Warning: Removed 4 rows containing missing values or values outside the scale range
    ## (`geom_point()`).

    ## Warning: Removed 4 rows containing non-finite outside the scale range
    ## (`stat_boxplot()`).

    ## Warning: Removed 4 rows containing non-finite outside the scale range
    ## (`stat_pwc()`).

    ## Warning: Removed 4 rows containing missing values or values outside the scale range
    ## (`geom_point()`).

``` r
                                                  #right

# Display the combined plot with pairwise comparisons
combined_pwc_plot
```

![](CC_4_files/figure-gfm/chunk%20for%20the%20figures%20plotting%20the%20DON%20data,%2015ADON,%20and%20Seedmass-8.png)<!-- -->

3.  6 pts. Knit your document together in the following formats:

<!-- -->

1.  .docx (word document) OR .pdf with a table of contents
2.  GitHub flavored markdown (.md file).

<!-- -->

4.  2 pts. Push the .docx or .pdf and .md files to GitHub inside a
    directory called Coding Challenge 4.

5.  6 pts. Now edit, commit, and push the README file for your
    repository and include the following elements.

<!-- -->

1.  A clickable link in your README to your GitHub flavored .md file
2.  A file tree of your GitHub repository.

<!-- -->

6.  1 pt. Please provide me a clickable link to your GitHub
