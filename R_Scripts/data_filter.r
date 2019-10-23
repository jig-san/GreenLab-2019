#Setting the working directory
setwd('/home/kailainathan/Documents/Profiler_Output')

##Installing the necessary packages - ggplot2 & reshape
install.packages('ggplot2')
install.packages('reshape')
library(ggplot2)
library(reshape)
library(plyr)

#Loading the CSV files - Joules, CPU usage and Load time
joule_data<-read.csv(file = 'Joule_results_combined.csv',head=TRUE,sep=",")
cpu_usage_data<-read.csv(file = 'CPU_results_combined.csv', head=TRUE,sep=",")
load_time_data<-read.csv(file = 'Timing.csv',head=TRUE,sep=",")


##Filtering the data into two seperate sets based on data for with prefixes 
##and data for without prefixes 

joule_without_data<-joule_data[grep("without_prefix",joule_data$filename),]
joule_with_data<-joule_data[grep("with_prefix",joule_data$filename),]
cpu_with_usage_data<-cpu_usage_data[grep("with_prefix",cpu_usage_data$subject),]
cpu_without_usage_data<-cpu_usage_data[grep("without_prefix",cpu_usage_data$subject),]
load_with_time_data<-load_time_data[grep("with_prefix",load_time_data$filename),]
load_without_time_data<-load_time_data[grep("without_prefix",load_time_data$filename),]

##Grouping the subjects and obtain mean for each subject.
joule_mean_without_data<- aggregate(joule_without_data[, 1], list(joule_without_data$filename), mean)
joule_mean_with_data<-  aggregate(joule_with_data[, 1], list(joule_with_data$filename), mean)
cpu_mean_without_data<-  aggregate(cpu_without_usage_data[, 4], list(cpu_without_usage_data$subject), mean)
cpu_mean_with_data<-  aggregate(cpu_with_usage_data[, 4], list(cpu_with_usage_data$subject), mean)
loadtime_mean_without_data<- aggregate(load_without_time_data[, 1], list(load_without_time_data$filename), mean)
loadtime_mean_with_data<- aggregate(load_with_time_data[, 1], list(load_with_time_data$filename), mean)

