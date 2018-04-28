#' Create a new `tlsh` object
#'
#' An alternative to the simple interface when you need more control over
#' the hashing (e.g. reading in a large file chunk-by-chunk). The mini-DSL
#' is created with the concept of piping (i.e. use of `%>%`) in mind.
#'
#' At a minimum, a new, empty `tlsh` object will be created and returned. By
#' specifying `content`, the caller can pre-populate the hash with content.
#' Tests will performed on `content` and the behaviour will be different depending on
#' what is passed in:
#'
#' - Single element character vectors will be checked to see if they are a URL
#'   or a path to a valid, reachable file. If either the URL or file case matches
#'   the content will be read in and added to the hash object. Larger files
#'   will (eventually) be chunked in via the _update_ ability of `tlsh` objects.
#' - Single element character vectors that are not URLs or files will be
#'   added in a text content provided they are >50 characters (a limitation of
#'   `tlsh` objects and the underlying algorithm).
#' - Length 1+ character vectors will have each element added in via the `update`
#'   mechanism noted above.
#' - A raw vector will be added as would normally be through other DSL methods
#'
#' @md
#' @param content Can be a URL, path, lenth 1+ character vector or raw vector.
#'        See `Details` for more info
#' @return `tlsh` object
#' @export
tlsh <- function(content = NULL) {

  list(
    lsh = new(Tlsh$tlsh_r)
  ) -> out


  class(out) <- c("tlsh")
  out
}

#' Update the `tlsh` object with content
#'
#' @md
#' @param x a `tlsh` object
#' @param content contet to add. See `content` parameter of [tlsh()] for possible values
#'        and how they are interpreted.
#' @export
tlsh_update <- function(x, content) {

}

#' Finalize a `tlsh` object hash
#'
#' Calling this "finalizes" the `tlsh` object, which means the actual hash value
#' for all the content added to it is computed. This should be the the last call
#' after all _update_s.
#'
#' @md
#' @param x a `tlsh` object
#' @param force if `TRUE` an attempt will be made to forego minimum content-length
#'        and content-body requirements when computing the hash. **Not recommended**.
#'        Default: `FALSE`
#' @export
tlsh_finalize <- function(x, force=FALSE) {

}

#' Test if a `tlsh` hash object is valid
#'
#' @md
#' @param x a `tlsh` object
#' @export
tlsh_is_valid <- function(x) {

}

#' Clear content and hash computation from a `tlsh` object
#'
#' Modestly lower-cost function that creating a new object.
#'
#' @md
#' @param x a `tlsh` object
#' @export
tlsh_reset <- function(x) {

}

#' Return a data frame of lvalue and q1/2 ratios from a `tlsh` object
#'
#' @md
#' @param x a `tlsh` object
#' @return data frame
#' @export
tlsh_stats <- function(x) {

}

#' Retrieve the hex-encoded hash string for a `tlsh` object
#'
#' @md
#' @param x a `tlsh` object
#' @return length 1 character vector
#' @export
tlsh_hash <- function(x) {

}

#' Compute distance between two TLSH objects
#'
#' @param x,y TLSH hash objects
#' @return distance value
#' @export
tlsh_dist <- function(x, y) {
  stopifnot(inherits(x, "Rcpp_tlsh_r"))
  stopifnot(inherits(y, "Rcpp_tlsh_r"))
 tlsh_diff_fingerprints(x$get_hash(), y$get_hash())
}