#' Compute TLSH hash for a character or raw vector and return hash fingerprint
#'
#' A warning will be issued if the input byte stream is <50 bytes.
#'
#' @md
#' @param x length 1 `character` or `raw` vector
#' @export
tlsh_simple_hash <- function(x) {
  if (inherits(x, "character")) {
    x <- x[1]
    if (nchar(x) < 50L) {
      warning("Byte stream minimum length is 50 bytes.")
      return(NA_character_)
    }
    tlsh_simple_hash_c(x)
  } else if (inherits(x, "raw")) {
    if (length(x) < 50L) {
      warning("Byte stream minimum length is 50 bytes.")
      return(NA_character_)
    }
    tlsh_simple_hash_r(x)
  } else {
    warning("Byte stream must be character or raw.")
    NA_character_
  }
}

#' Compute the difference between two character hashes
#'
#' @md
#' @param x,y two hash fingerprints to compare
#' @return `NA` will be returned if `x` or `y` are not valid hashes
#' @export
tlsh_simple_diff <- function(x, y) {
  if ((nchar(x) < 70) | (nchar(y) < 70)) return(NA_integer_)
  tlsh_diff_fingerprints(x, y)
}