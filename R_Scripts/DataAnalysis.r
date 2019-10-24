#=========================================================
# LOAD LIBRARIES AND DATASETS
#=========================================================
install.packages("ggplot2")
install.packages("car")
require("ggplot2")
require("car")

# Load datasets

timing_data <- read.csv(file="Timing.csv",head=TRUE,sep=",")
joule_data<-read.csv(file = 'Joule_results_combined.csv',head=TRUE,sep=",")
cpu_data<-read.csv(file = 'CPU_results_combined.csv', head=TRUE,sep=",")

##Filtering the data into two seperate sets based on data for with prefixes 
##and data for without prefixes 

colnames(joule_data) <- c("joule", "filename")
joule_data_without<-joule_data[grep("without_prefix",joule_data$filename),]
joule_data_with<-joule_data[grep("with_prefix",joule_data$filename),]

cpu_data_without<-cpu_data[grep("without_prefix",cpu_data$subject),]
cpu_data_with<-cpu_data[grep("with_prefix",cpu_data$subject),]

colnames(timing_data) <- c("loadtime", "filename")
timing_data_without<-timing_data[grep("without_prefix",timing_data$filename),]
timing_data_with<-timing_data[grep("with_prefix",timing_data$filename),]

# aggregate as mean for each website
timing_data_without_mean<- aggregate(timing_data_without[, 1], list(timing_data_without$filename), mean)
timing_data_with_mean<-  aggregate(timing_data_with[, 1], list(timing_data_with$filename), mean)

cpu_data_without_mean<-  aggregate(cpu_data_without[, 4], list(cpu_data_without$subject), mean)
cpu_data_with_mean<-  aggregate(cpu_data_with[, 4], list(cpu_data_with$subject), mean)

joule_data_without_mean<- aggregate(joule_data_without[, 1], list(joule_data_without$filename), mean)
joule_data_with_mean<- aggregate(joule_data_with[, 1], list(joule_data_with$filename), mean)

#=========================================================
# Plotting
#=========================================================

# combine dataframes for plotting histograms and boxplots

# change to timing_data_with_mean, cpu_data_with_mean or joule_data_with_mean
vals_with_prefixes <- data.frame(joule_data_with_mean[,2])

# change to timing_data_with_mean, cpu_data_with_mean or joule_data_with_mean
vals_without_prefixes <- data.frame(joule_data_without_mean[,2])

# manipulations for plotting
colnames(vals_without_prefixes) <-c("values")
colnames(vals_with_prefixes) <-c("values")

vals_with_prefixes$prefixes <- "with prefixes"
vals_without_prefixes$prefixes <- "without prefixes"

df_aggregated <- rbind(vals_with_prefixes, vals_without_prefixes)

# histograms with+without prefixes comparison
ggplot(df_aggregated, aes(values, fill = prefixes, color = prefixes)) + 
  geom_histogram(bins=35, alpha=0.5) + 
  labs(title="Energy consumption with and without CSS prefixes", x="Energy consumption, Joules", y = "Webpages count") + 
  theme(legend.title = element_blank()) + theme(
    legend.justification = c("left"),
    legend.position = c(0.7, 0.75),
  )

# boxplots with+without prefixes comparison
ggplot(df_aggregated, aes(x=prefixes, y=values, color = prefixes)) + 
  geom_boxplot() + coord_flip() + 
  labs(title="Boxplots for energy consumption with and without CSS prefixes", y="Energy consumption, Joules") + 
  theme(axis.title.y = element_blank(),
        axis.text.y = element_blank(),
        legend.title = element_blank(),
        legend.position = c(0.8, 0.5))

#=========================================================
# Statistical analysis
#=========================================================

# mean 
mean(timing_data_with_mean[,2])
mean(cpu_data_with_mean[,2])
mean(joule_data_with_mean[,2])

mean(timing_data_without_mean[,2])
mean(cpu_data_without_mean[,2])
mean(joule_data_without_mean[,2])

# median 
median(timing_data_with_mean[,2])
median(cpu_data_with_mean[,2])
median(joule_data_with_mean[,2])

median(timing_data_without_mean[,2])
median(cpu_data_without_mean[,2])
median(joule_data_without_mean[,2])

# minimum
min(timing_data_with_mean[,2])
min(cpu_data_with_mean[,2])
min(joule_data_with_mean[,2])

min(timing_data_without_mean[,2])
min(cpu_data_without_mean[,2])
min(joule_data_without_mean[,2])

# maximum 
max(timing_data_with_mean[,2])
max(cpu_data_with_mean[,2])
max(joule_data_with_mean[,2])

max(timing_data_without_mean[,2])
max(cpu_data_without_mean[,2])
max(joule_data_without_mean[,2])

#=========================================================
# Hypotesis Testing
#=========================================================

# check for normality

# not normal (page loading time)
qqPlot(timing_data_without_mean[,2], col = "red", id=FALSE,
       xlab="Normal theoretical quantiles", ylab="Sample quantiles, ms", main="QQplot (Page load time)")
shapiro.test(timing_data_without_mean[,2])

# normal log(page loading time)
qqPlot(log(timing_data_without_mean[,2]), col = "red", id=FALSE,
       xlab="Normal theoretical quantiles", ylab="Sample quantiles, ms", main="QQplot (Page load time)")
shapiro.test(log(timing_data_without_mean[,2]))

# normal (CPU usage)
qqPlot(cpu_data_without_mean[,2], col = "red", id=FALSE,
       xlab="Normal theoretical quantiles", ylab="Sample quantiles, %", main="QQplot (CPU usage)")
shapiro.test((cpu_data_without_mean[,2])^2)

# not normal (energy consumption)
qqPlot(joule_data_without_mean[,2], col = "red", id=FALSE,
       xlab="Normal theoretical quantiles", ylab="Sample quantiles, Joules", main="QQplot (energy consumption)")
shapiro.test(joule_data_without_mean[,2])

# Paired t-test

#log of page loading time
# p-value = 0.9671
t.test(x=log(timing_data_without_mean[,2]), 
       y=log(timing_data_with_mean[,2]), 
       paired=TRUE)

# CPU usage
# p-value = 0.4374
t.test(x=cpu_data_without_mean[,2], 
       y=cpu_data_with_mean[,2], 
       paired=TRUE)

# Wilcoxon rank sum test with continuity correction
# p-value = 0.6262
wilcox.test(x=joule_data_with_mean[,2], 
            y=joule_data_without_mean[,2], 
            paired = FALSE)