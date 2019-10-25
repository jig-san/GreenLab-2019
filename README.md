# CSS Prefixes - GreenLab-2019

Vendor prefixes or CSS Prefixes are set of browser specific commands attached to the CSS attributes to make webpages adapt  to settings even when different browsers are used. This experiment is focused on finding out about the performance and energy consumption of the css prefixes.

## Installation Notes to Replicate the Experiment:

1. Download the repository and extract the contents onto a folder. Also download the androidrunner from the below link:
<pre>                                      <https://github.com/S2-group/android-runner>   </pre>
2. Open the Prefixes_files folder which contains the python scripts for Adding/Removing prefixes. All the Subjects used in the    experiment are placed in a drive location which is shared in the Repository.
3. Keep two seperate folders and copy the subjects onto both the folders. Place the ```addPrefixes.py``` in one folder and the          ```removePrefixes.py``` in another folder. Execute them from the command line in order to have two sets of subjects with and          without prefixes. Follow the below command:<br/>
   <pre>                        python2.7 addPrefixes.py 
                           python2.7 removePrefixes.py </pre>
4. The loadtime.js javascript used to calculate the loadtime has already been appended to the subjects.
5. Start the localserver to host the subjects for carrying out the experiments using the following command:<br/>
   <pre>                        python3 -m http.server                                  </pre>
6. Start another localserver by running the ```RecordDataServer.py``` kept in the prefixes_files folder. The python script will be      used to   capture the load time and write it onto a CSV file.<br/>
   <pre>                        python2.7 RecordDataServer.py                            </pre>
7. Now the prerequisites are met to start the experiment. The config.json of Androidrunner for running the experiments is          placed   in the repository and should be used. The laptop's IP should be used to connect the websites through the Android      device. 
8. Every run takes place for 20 seconds and its followed by a 2 minute cooling period. Android and Batterystats are the            profilers used.
9. Upon completion of the experiment ,run the ```csv_merge.py``` script present in the Profiler_Output folder. Ensure the path is        modified to the output folder in the script. This script is used to merge the different outputs into two csv files - Joules    csv and cpu usage csv.<br/>
   <pre>                         python2.7 csv_merge.py                                      </pre>

