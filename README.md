
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Lex2Emo

<!-- badges: start -->
<!-- badges: end -->

## Installation

You can install the current version of Lex2Emo using devtools:

    #> Using GitHub PAT from the git credential store.
    #> Downloading GitHub repo Reilly-ConceptsCognitionLab/Lex2Emo@HEAD
    #> data.table (1.16.2   -> 1.16.4  ) [CRAN]
    #> cpp11      (0.5.0    -> 0.5.1   ) [CRAN]
    #> pillar     (1.9.0    -> 1.10.1  ) [CRAN]
    #> rlang      (1.1.4    -> 1.1.5   ) [CRAN]
    #> Rcpp       (1.0.13-1 -> 1.0.14  ) [CRAN]
    #> fastmatch  (1.1-4    -> 1.1-6   ) [CRAN]
    #> quanteda   (4.1.0    -> 4.2.0   ) [CRAN]
    #> BH         (1.84.0-0 -> 1.87.0-1) [CRAN]
    #> Installing 8 packages: data.table, cpp11, pillar, rlang, Rcpp, fastmatch, quanteda, BH
    #> Installing packages into 'C:/Users/tun27424/AppData/Local/Temp/RtmpaYzE7E/temp_libpath5100466263ff'
    #> (as 'lib' is unspecified)
    #> package 'data.table' successfully unpacked and MD5 sums checked
    #> package 'cpp11' successfully unpacked and MD5 sums checked
    #> package 'pillar' successfully unpacked and MD5 sums checked
    #> package 'rlang' successfully unpacked and MD5 sums checked
    #> package 'Rcpp' successfully unpacked and MD5 sums checked
    #> package 'fastmatch' successfully unpacked and MD5 sums checked
    #> package 'quanteda' successfully unpacked and MD5 sums checked
    #> package 'BH' successfully unpacked and MD5 sums checked
    #> 
    #> The downloaded binary packages are in
    #>  C:\Users\tun27424\AppData\Local\Temp\RtmpgvSQ9K\downloaded_packages
    #> ── R CMD build ─────────────────────────────────────────────────────────────────
    #>       ✔  checking for file 'C:\Users\tun27424\AppData\Local\Temp\RtmpgvSQ9K\remotes424c316128b7\Reilly-ConceptsCognitionLab-Lex2Emo-a1297f8/DESCRIPTION'
    #>       ─  preparing 'Lex2Emo':
    #>    checking DESCRIPTION meta-information ...     checking DESCRIPTION meta-information ...Warning in person1(given = given[[i]], family = family[[i]], middle = middle[[i]],  :  ─  checking DESCRIPTION meta-information ...Warning in person1(given = given[[i]], family = family[[i]], middle = middle[[i]],  :
    #>      It is recommended to use 'given' instead of 'middle'.
    #>           OK
    #>   Warning in person1(given = given[[i]], family = family[[i]], middle = middle[[i]],  :     Warning in person1(given = given[[i]], family = family[[i]], middle = middle[[i]],  :
    #>      It is recommended to use 'given' instead of 'middle'.
    #>       ─  checking for LF line-endings in source and make files and shell scripts
    #>   ─  checking for empty or unneeded directories
    #>      Omitted 'LazyData' from DESCRIPTION
    #>       ─  building 'Lex2Emo_0.0.0.9000.tar.gz'
    #>      
    #> 
    #> Installing package into 'C:/Users/tun27424/AppData/Local/Temp/RtmpaYzE7E/temp_libpath5100466263ff'
    #> (as 'lib' is unspecified)

## Reading in a directory of .txt files

Emo2Lex provides a method (readText) that allows users to concatonate a
directory of .txt files into a single data frame meeting the format
requirements for the next stage. Each file is read in as a single string
of text, with only newlines removed, however non-alphanumeric characters
are removed in the next stage.

## Requirements for dataframe input

Data frame inputs must at the least contain a column with text data
called ‘Text’ and an ID column (called ‘ID’) used to differentiate each
text sample. Currently, an ID column is required even if a single text
sample is provided. Lex2Emo will treat any data outside of the ‘Text’
and ‘ID’ columns as metadata and preserve the first entry for each
document ID when aggregated.

### Basic example of data frame for input into transformText()

|  ID | Text                       | Length |
|----:|:---------------------------|-------:|
|   1 | A description of something |     55 |
|   2 | The entirety of a book     |  80000 |
|   3 | A whole conversation       |    700 |

## Using transformText()

transformText() transforms each word in each text sample into it’s
associated ratings (if available) on 22 emotional dimensions.

``` r
library(Lex2Emo)
# example of transformText() calls to output aggregated data
aggTextData <- transformText(textData = exampleData, returnFullData = F)

# example of transformText() calls to output non-aggregated data
aggTextData <- transformText(textData = exampleData, returnFullData = T)
```
