## code to prepare `internal_data` dataset goes here


# set affect lookup and omissions as internal data

#affPath <- r"(C:\Users\tun27424\OneDrive - Temple University\Ben R\Lex2Emo_Total\Lex2Emo_Development\lookup_data\Lex2EmoLookup22.rda)"

affPath <- r"(C:\Users\tun27424\GitHub\Gaslighting\data\affvec_22dim.rda)"
omPath <- r"(C:\Users\tun27424\OneDrive - Temple University\Ben R\Lex2Emo_Total\Lex2Emo_Development\lookup_data\omissions_dyads23.rda)"

load(affPath)
load(omPath)

Lex2EmoLookup22 <- affvec_22dim
omissionsDyads23 <- omissions_dyads23

usethis::use_data(omissionsDyads23, Lex2EmoLookup22,
                  overwrite = T, compress = "xz", internal = T)


#devtools::install("../Lex2Emo")


