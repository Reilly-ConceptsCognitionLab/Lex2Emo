
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Lex2Emo

<!-- badges: start -->
<!-- badges: end -->

## Installation

You can install the current version of Lex2Emo using devtools:

``` r
devtools::install_github("https://github.com/Reilly-ConceptsCognitionLab/Lex2Emo.git")
```

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
