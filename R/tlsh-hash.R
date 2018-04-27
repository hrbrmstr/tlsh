#' Compute TLSH hash for a character or raw vector and return hash fingerprint
#'
#' @md
#' @param x length 1 `character` or `raw` vector
#' @export
tlsh_simple_hash <- function(x) {
  if (inherits(x, "character")) {
    x <- x[1]
    if (nchar(x) < 50L) stop("Byte stream minimum length is 50 bytes", call.=FALSE)
    tlsh_simple_hash_c(x)
  } else if (inherits(x, "raw")) {
    if (length(x) < 50L) stop("Byte stream minimum length is 50 bytes", call.=FALSE)
    tlsh_simple_hash_r(x)
  } else {
    NULL
  }
}

#' @md
#' @rdname tlsh_simple_hash
#' @param x,y two hash fingerprints to compare
#' @export
tlsh_simple_diff <- function(x, y) {
  tlsh_diff_fingerprints(x, y)
}