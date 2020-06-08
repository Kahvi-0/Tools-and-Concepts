# Webpage scraper

Web page scrape is meant to scrape webpages from a file for information that could be useful for pentesting.

Downloading all the script files from BURP makes collecting info from website scripts easy.

## TO DO: 

- Add function to intake webpage list, make requests and scrape that. 

## Usage

    scraper.sh <input file> <mode>
    
    Mode: 
    
        webpage: Input file will be a list of URLs to be scraped. The script will then request, save, and run the scrape function against the result of webpages. 
        
        script: Input file will be a script or file with multiple scripts (such as those exported from BURP). This will then be parsed with the scrape function.

















