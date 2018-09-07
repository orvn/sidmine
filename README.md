# sidmine
A series of mining scripts for scraping metadata from URLs right in the Shell

***

Currently this shell script is tested in the Bourne Shell. It uses `gawk`, `curl` and unix regex.
Runs on bash 3.2 and above.

Run it as a shell script: `./sidemine.sh`


### Roadmap

- [] Better error handling
- [] Option to deal with multiple matches per page
- [] Parse through an array of URLs from an input source
- [] Option to extract attributes
- [] Reference an external file like a sitemap
- [] Reference a series of nested sitemaps
- [] Improve memory use and performance by refactoring without pipes
- [] Accept content with any character encoding
