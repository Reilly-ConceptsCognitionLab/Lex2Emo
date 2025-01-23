#' readText
#'
#' `myfunction` reads and formats a directory of plaintext files.
#'
#' @param folderPath A file path to a directory of .txt file containing text data.
#' @return Returns a data frame concatenating the text data of each file and using file names as document IDs.
#'
#' myfunction(1) # returns 1
#'
#' @export

readText <- function(folderPath) {
  # list each file within the folder path
  files <- list.files(folderPath, full.names = F, recursive = T, pattern = "\\.txt$")

  fullText <- sapply(files, function(fileName){
    # full file path
    filePath <- paste(folderPath, fileName, sep = "\\")
    # read all lines of file and concatenate into a single string
    paste(readLines(filePath, warn = F), collapse=" ")

  })
  CompiledTextDf <- data.frame(ID = files, Text = fullText, row.names = NULL)
  return(CompiledTextDf)
}
