'''
Python to script to Add all the available prefixes to the CSS files of a website
using the Autoprefixer tool.
'''
from bash import bash

#ADD BROWESER LIST FROM
#https://github.com/browserslist/browserslist
#Defaults will add all available CSS prefixes
browser = "defaults"
#To find the CSS files in the directory.
list = bash("find  -name '*.css'").stdout.split('\n')
print("Obtained the list of all the css files")
#Installing the Autoprefixer tool.
bash("npm i postcss-cli-simple")
bash("npm i postcss-cli")
bash("npm i autoprefixer")

print("installed the needed packages")

for infile in list:
    ### Adding prefixes to the files
    postcss = 'postcss --use autoprefixer --autoprefixer.browsers "%(browser)s" -o %(outfile)s %(infile)s'
    bash(postcss %{"browser": browser, "outfile":infile, "infile":infile})
    print("Added prefixes to the file at "+infile)
