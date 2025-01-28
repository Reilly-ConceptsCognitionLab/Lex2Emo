#' transformText
#'
#' `transformText` aligns each text sample with associated values on 22 emotional dimensions
#'
#' @name transformText
#' @param textData Data frame with at least two rows: ID, a unique ID for each text sample and Text, the text samples. Column names must match exactly.
#' @param returnFullData Should result data frame report individual word ratings (T) or averaged by sample (F)
#'
#' @importFrom dplyr select
#' @importFrom textclean replace_contraction
#' @importFrom dplyr group_by
#' @importFrom tm stripWhitespace
#' @importFrom tm removeWords
#' @importFrom dplyr mutate
#' @importFrom stringr str_squish
#' @importFrom textstem lemmatize_strings
#' @importFrom tidyr separate_longer_delim
#' @importFrom dplyr left_join
#' @importFrom dplyr summarize
#' @importFrom dplyr across
#' @importFrom dplyr first
#' @importFrom tidyr pivot_longer
#'
#' @return A dataframe with ratings for 22 emotional dimensions bound to each text sample.
#'
#' @export
#'
transformText <- function(textData, returnFullData=F) {
  # to stop R CMD notes - bind variables to function locally (rec here: https://www.r-bloggers.com/2019/08/no-visible-binding-for-global-variable/)
  Text <- ID <- ID <- cleanTargetText <- NULL
  textData$ID <- as.factor(textData$ID)
  # internal function for cleaning text
  cleanme <- function(x){ # clean text
    x <- tolower(x)
    x <- gsub("\"", " ", x)
    x <- gsub("\n", " ", x)
    x <- gsub("`", "'", x)  # replaces tick marks with apostrophe for contractions
    x <- textclean::replace_contraction(x) #replace contractions
    x <- gsub("[^a-zA-Z]", " ", x) #omit non-alphabetic characters
    x <- gsub("-", " ", x)
    x <- gsub("\\s+s\\s+", " ", x) #omit s when in isolation
    x <- gsub("\\s+be\\s+", " ", x) #omit be when in isolation surrounded by spaces
    x <- tm::removeWords(x, ReillyLab_Stopwords_25$word)
    x <- textstem::lemmatize_strings(x) #lemmatize
    x <- tm::stripWhitespace(x)
    x <- stringr::str_squish(x)
  }


  cleanData <- textData %>%
    dplyr::mutate(cleanTargetText = cleanme(Text)) %>%
    select(!Text)
  # tokenize each text sample by individual words
  tokenData <- cleanData %>%
    tidyr::separate_longer_delim(cleanTargetText, delim = " ")

  # align affective dimensions to tokenized text
  dimData <- tokenData %>%
    dplyr::left_join(Lex2EmoLookup22, by = c("cleanTargetText" = "word"))

  if (returnFullData) { # if selected, return the data prior to averaging
    return(dimData)
  }

  # and average scores, first of each metadata dim
  averageData <- dimData %>%
    dplyr::group_by(ID) %>%
    dplyr::summarize(dplyr::across(colnames(Lex2EmoLookup22[,-1]), ~ mean(.x, na.rm = TRUE)),
                     dplyr::across(-colnames(Lex2EmoLookup22[,-1]) & -cleanTargetText, dplyr::first),
                     .groups = "drop")

  # pivot data longer by 22 dimensions
  longData <- averageData %>%
    tidyr::pivot_longer(cols=c(colnames(Lex2EmoLookup22[,-1])),
                        names_to="Dimension", values_to="Factor_Score")
  # convert NaN to Na
  longData[is.nan(longData$Factor_Score), "Factor_Score"] <- NA
  #reorder levels of factor in descending magnitude of factor score from base gaslighting vector
  longData$Dimension <- as.factor(longData$Dimension)

  return(longData)
}
