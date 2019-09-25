
##Python Script to Select top 50 websites with domain name as .com

import pandas as pd
load_data=pd.read_csv('/home/kailainathan/Documents/top-1m.csv')  ##Loading the Tranco list of 1m websites
filter_data=load_data[load_data['website'].str.contains('.com')]  ##Filtering the dataset to find out the websites with the domain name .com
final_dataset=filter_data[filer_data['id']<=50] ##Further filtering the dataset to get the Top 50 websites

## writing the results to a CSV file

final_data=final_dataset.to_csv(r'/home/kailainathan/Documents/android-runner-master/dataset_population.csv')
 
quit()
