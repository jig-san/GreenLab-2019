from bash import bash

list = bash("find  -name '*.css'").stdout.split('\n')
print("Obtained the list of all the css files")
#bash("npm i postcss-cli-simple")
#bash("npm i postcss-cli")
#bash("npm i -g postcss-remove-prefixes")

print("installed the needed packages")

for infile in list:
    ### Removing prefixes from the file
    #postcss = './node_modules/.bin/remove-prefixes  %(infile)s %(outfile)s'
    #bash(postcss %{"outfile":infile, "infile":infile})
    postcss = 'remove-prefixes %(infile)s %(outfile)s'	
    bash(postcss %{"outfile":infile,"infile":infile})
    print("removed prefixes to the file at "+infile)
