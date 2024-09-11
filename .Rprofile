options("width" = 115)
options(pillar.subtle = FALSE)
options(rlang_backtrace_on_error = "none")
options(browser = "brave")
options(max.print = 1000)
## options(browser = "firefox")
## options(browser = "html_diverter.sh")

options(warnPartialMatchDollar = F)

options("languageserver.rich_documentation" = F)


fstd <- c()

base_pckgs <- c("dplyr", "data.table", "ggplot2" , "magrittr")
pckgs_avbl <- .packages(all.available = T)

pckgs_missing <- setdiff(base_pckgs, pckgs_avbl)

library(utils)

install.packages(pckgs_missing)


print_data_table <- function(x, ...) {
    ## Adapted from data.table:::as.data.frame.data.table()
    ## print('printing dt')
    ans <- x
    attr(ans, "row.names") <- .set_row_names(nrow(x))
    attr(ans, "class") <- c("tbl", "data.frame")
    attr(ans, "sorted") <- NULL
    attr(ans, ".internal.selfref") <- NULL
    print(ans, ...)
  invisible(x)
}

print.data.table <- print_data_table



library(dplyr)
## library(docstring)
library(data.table)
library(ggplot2)
library(magrittr)
## ds <- docstring
## library(countrycode)


## '%!in%' <- function(x,y)!('%in%'(x,y))
len <- length
adf <- as.data.frame
atb <- as_tibble
adt <- as.data.table
achr <- as.character
anum <- as.numeric

print(getOption("width"))

## ccd <- countrycode










