'''
Python script to combine the seperate joules csv's and the aggregated android results csv's.
Output file will be Joule_results_combined for the joule results obtained from batterystats and CPU_results_combined for the cpu usage results from android profiler.
'''
import os
from glob import glob
import pandas as pd

#Function to merge the csv files depending on the filename and extension being passed.

def merge_csv(path,file_extension):
    #List which obtains all the filenames from the directory.
    csv_input = [file for path, subdir, files in os.walk(path)
                 for file in glob(os.path.join(path, file_extension))]
    print('Number of records:', len(csv_input))
    #Reads each csv file's contents as per the values in the list.
    file_data_csv = [pd.read_csv(file) for file in csv_input]
    #Adding filename as a column to the output csv.
    for dataframe, filename in zip(file_data_csv,csv_input):
        dataframe['filename'] = filename
    #Merging the dataframes together
    merged_dataframe = pd.concat(file_data_csv, ignore_index=True)
    if file_extension == "Joule_*.csv":
        #writing the merged output to a csv
        merged_dataframe.to_csv("Joule_results_combined.csv", index=False, encoding='utf-8-sig')
        print('Joule results written to csv file')
    else:
        # writing the merged output to a csv
        merged_dataframe.to_csv("CPU_results_combined.csv", index=False, encoding='utf-8-sig')
        print('CPU results written to csv file')


if __name__ == '__main__':
    path = '/home/kailainathan/Documents/output'
    os.chdir(path)
    print('Merging files')
    #Passing the file extension names and the path
    merge_csv(path,'Joule_*.csv')
    merge_csv(path,'Aggregated_Results_*.csv')
    print('Merging of files is complete')