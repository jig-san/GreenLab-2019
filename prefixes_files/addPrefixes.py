from bash import bash

### ADD BROWESER LIST FROM 
### https://github.com/browserslist/browserslist
FIREFOX = "Firefox > 20" #version > 20
CHROME = "last 2 Chrome versions" #last 2 chrome version

browser = CHROME

list = bash("find  -name '*.css'").stdout.split('\n')
print("Obtained the list of all the css files")
#bash("npm i postcss-cli-simple")
#bash("npm i postcss-cli")
#bash("npm i autoprefixer")

print("installed the needed packages")

for infile in list:
    ### Adding prefixes to the file
    postcss = './node_modules/.bin/postcss --use autoprefixer --autoprefixer.overrideBrowserslist "%(browser)s" -o %(outfile)s %(infile)s -m'
    bash(postcss %{"browser": browser, "outfile":infile, "infile":infile})
    print("Added prefixes to the file at "+infile)
