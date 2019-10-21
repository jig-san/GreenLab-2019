'''
Python Script to remove the CSS Prefixes from the CSS files of a website using the postcss-remove-prefixes tool.
'''
from bash import bash
#To find the CSS files in the Current Directory.
list = bash("find  -name '*.css'").stdout.split('\n')
print("Obtained the list of all the css files")
#Installing the packages of postcss-remove-prefixes
bash("npm i postcss-cli-simple")
bash("npm i postcss-cli")
bash("npm i -g postcss-remove-prefixes")

print("installed the needed packages")

for infile in list:
    #Removing prefixes from the file
    postcss = 'remove-prefixes %(infile)s %(outfile)s'
    bash(postcss %{"outfile":infile,"infile":infile})
    print("removed prefixes to the file at "+infile)
