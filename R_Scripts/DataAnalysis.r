#=========================================================
# LOAD LIBRARIES AND DATASETS
#=========================================================
install.packages("dplyr")
require("ggplot2")
require("car")
require("dplyr")

# Load datasets
timing_data <- read.csv(file="data/timing.csv",head=TRUE,sep=",")
joule_data<-read.csv(file = 'data/Joule_results_combined.csv',head=TRUE,sep=",")
cpu_data<-read.csv(file = 'data/CPU_results_combined.csv', head=TRUE,sep=",")

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
# Tests for a single page
#=========================================================

joule_quora_without <- joule_data[106:120,]
timing_quora_without <- timing_data[703:716,]
timing_twitter_without <- timing_data[30:44,]

min(timing_quora_without[,1])
max(timing_quora_without[,1])

min(timing_twitter_without[,1])
max(timing_twitter_without[,1])

sd(timing_quora_without[,1])

par(mar=c(4,4,1,1))

hist(timing_quora_without[,1],
     main="Page load time for Quora without prefixes",
     xlab="Pae load time, ms",
     ylab="Number of pages",
     col="lightblue",
     breaks=13
)

joule_bitly_without <- joule_data[631:645,]
sd(joule_bitly_without[,1])

View(cpu_data_without)

min(joule_bitly_without[,1])
max(joule_bitly_without[,1])

min(joule_quora_without[,1])
max(joule_quora_without[,1])

hist(joule_bitly_without[,1],
     main="Energy consumption for Bitly without prefixes",
     xlab="Energy consumption, Joules",
     ylab="Number of pages",
     col="lightblue",
     breaks=13
)

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

#std dev
sd(timing_data_with_mean[,2])
sd(cpu_data_with_mean[,2])
sd(joule_data_with_mean[,2])

sd(timing_data_without_mean[,2])
sd(cpu_data_without_mean[,2])
sd(joule_data_without_mean[,2])

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
#=========================================================
# Correlation
#=========================================================

plot(cpu, memory, grid())
abline(lm(cpu~memory), col='red')

cor.test(x=cpu, y=memory, method="spearman" , conf.int=TRUE, exact = FALSE)

cor.test(x=cpu, y=memory, method="pearson" , conf.int=TRUE)
