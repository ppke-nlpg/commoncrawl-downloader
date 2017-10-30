# CommonCrawl Downloader

Simple Python command line tools for retrieving a list of urls and specific files in bulk

## Overview

With this tool you can query the CommonCrawl index and download pages to the local machine anonymously.
It optionally uses [JusText](http://corpus.tools/wiki/Justext) to remove boilerplate content and only keep real text.
Using this tool one can create raw text corpora from web (CommonCrawl) easily.

This repository also contains the fixed version of [cdx-index-client](https://github.com/ikreymer/cdx-index-client/tree/1ae1301ae4fb8416f10bed97d4c7c96ba5ab4dc7).

## Install
    
    # Python 2.7.x required
    pip install -r requirements.txt

## Examples
    # Dowload index for specfic condition
    ./get_indexfiles.sh CONDITION OUTPUT_DIR
    # Download pages for index to pages dir
    ./download_pages.py OUTPUT_DIR [boilerplate removal with justext for no 1 for yes (default)]
    # Extract domain for urls and count robots.txt
    ./get_domain_for_urls.py OUTPUT_DIR

## Licence

GNU LGPL 3.0 or any later version
