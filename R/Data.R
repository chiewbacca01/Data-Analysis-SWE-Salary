library(ggplot2)
library(tidyverse)
theme_set(theme_bw())

# rename columns
names(ds_salaries)[3] <- "Experience Level"
names(ds_salaries)[8] <- "Salary in USD"
names(ds_salaries)[12] <- "Company Size"

# rename values
ds_salaries$experience_level[ds_salaries$`Experience Level` == "EN"] <- "Entry"
ds_salaries$experience_level[ds_salaries$`Experience Level` == "EX"] <- "Executive"
ds_salaries$experience_level[ds_salaries$`Experience Level` == "MI"] <- "Mid"
ds_salaries$experience_level[ds_salaries$`Experience Level` == "SE"] <- "Senior"
ds_salaries$`Company Size`[ds_salaries$`Company Size` == "M"] <- "Medium"
ds_salaries$`Company Size`[ds_salaries$`Company Size` == "S"] <- "Small"
ds_salaries$`Company Size`[ds_salaries$`Company Size` == "L"] <- "Large"

# Stats
median_large <- median(ds_salaries[ds_salaries$`Company Size` == "Large", "Salary in USD"])
median_med <- median(ds_salaries[ds_salaries$`Company Size` == "Medium", "Salary in USD"])
median_small <- median(ds_salaries[ds_salaries$`Company Size` == "Small", "Salary in USD"])
median_all <- c(median_large,median_med,median_small)
colnames(median_all) <- c("Large", "Medium", "small")
median_all

# plots
ggplot(ds_salaries, aes(x = `Experience Level` , y = `Salary in USD`)) + geom_boxplot() + scale_y_continuous(limits = quantile(ds_salaries$salary, c(0.1, 0.91)))
ggplot(ds_salaries, aes(x = `Company Size`)) + geom_bar()
ggplot(data=ds_salaries) + geom_bar(aes(x = `Company Size`, y = `Salary in USD`, fill = `Company Size`), stat = "summary", fun = "median")


