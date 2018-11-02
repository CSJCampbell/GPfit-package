
#### Config ####

pack <- "GPfit"

#### Tools ####

#' @title Lazy Installer
#' @description Install package when missing
#' @param pkgs character vector of packages to install
#' @param repo single character elements of pkgs are 'CRAN' or 'Github'.
#' @return NULL as a side effect packages may be installed
#' to the default library
#' @examples
#' lazy_install("MASS")
lazy_install <- function(pkgs, repo = c("CRAN", "Github")) {
    installer <- switch(match.arg(repo),
        CRAN = function(pkg) install.packages(pkg,
            verbose = FALSE, quiet = TRUE),
        Github = function(pkg) devtools::install_github(pkg, quiet = TRUE))
    for (pk in pkgs) {
        pkname <- gsub(pattern = ".*/", replacement = "", x = pk)
        if (!suppressWarnings(
            require(pkname, quietly = TRUE, warn.conflicts = FALSE,
                character.only = TRUE))) {
            installer(pkg = pk)
        }
        # check success
        library(pkname,
            quietly = FALSE,
            warn.conflicts = FALSE,
            character.only = TRUE)
    }
    invisible(NULL)
}

#### Environment ####

lazy_install(
    pkgs = c(
        "git2r", "backports", 
        "mime", "curl", 
        "openssl", "assertthat", 
        "crayon", "rprojroot", 
        "jsonlite", "R6", 
        "httr", "digest", 
        "memoise", "whisker", 
        "rstudioapi", "withr", 
        "brew", "desc", 
        "commonmark", "Rcpp", 
        "xml2", "devtools", 
        "roxygen2", "cli", 
        "praise", "rlang", 
        "testthat", "lattice", 
        "lhs"))

#### Build ####

library(devtools)
document(pack)
check(pack)
build(pack)
install(pack)

#### Test ####

test(pack)

