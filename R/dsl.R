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
#' - A raw vector will be added without any further processing
#' - A single element character vector will be added without any further processing
#' - A length >1 character vector will have each vector element added via the "update"
#'   mechanism.
#'
#' @md
#' @param content Can be a URL, path, lenth 1+ character vector or raw vector.
#'        See `Details` for more info
#' @return `tlsh` object
#' @export
#' @examples
#' doc1 <- as.character(xml2::read_html(system.file("extdat", "index.html", package="tlsh")))
#'
#' tlsh() %>%
#'   tlsh_update(doc1) %>%
#'   tlsh_finalize() -> x
#'
#' tlsh_hash(x)
#'
#' x
tlsh <- function(content = NULL) {

  list(
    lsh = new(Tlsh$tlsh_r)
  ) -> out

  class(out) <- c("tlsh")

  if (!is.null(content)) out <- tlsh_update(out, content)

  invisible(out)

}

#' Update the `tlsh` object with content
#'
#' @md
#' @param x a `tlsh` object
#' @param content contet to add. See `content` parameter of [tlsh()] for possible values
#'        and how they are interpreted.
#' @return `tlsh` object
#' @export
#' @examples
#' doc1 <- as.character(xml2::read_html(system.file("extdat", "index.html", package="tlsh")))
#'
#' tlsh() %>%
#'   tlsh_update(doc1) %>%
#'   tlsh_finalize() -> x
#'
#' tlsh_hash(x)
#'
#' x
tlsh_update <- function(x, content) {

  if (inherits(content, "character")) {
    for (i in 1:length(content)) x$lsh$update(charToRaw(content[i]))
  } else if (inherits(content, "raw")) {
    x$lsh$update(content)
  } else {
    warning("'content' is neither a character or raw vector. skipping update.")
  }

  invisible(x)

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
#' @return `tlsh` object
#' @export
#' @examples
#' doc1 <- as.character(xml2::read_html(system.file("extdat", "index.html", package="tlsh")))
#'
#' tlsh() %>%
#'   tlsh_update(doc1) %>%
#'   tlsh_finalize() -> x
#'
#' tlsh_hash(x)
#'
#' x
tlsh_finalize <- function(x, force=FALSE) {

  x$lsh$final(as.integer(force))

  invisible(x)

}

#' Test if a `tlsh` hash object is valid
#'
#' @md
#' @param x a `tlsh` object
#' @return `logical`
#' @export
#' @examples
#' doc1 <- as.character(xml2::read_html(system.file("extdat", "index.html", package="tlsh")))
#'
#' tlsh() %>%
#'   tlsh_update(doc1) %>%
#'   tlsh_finalize() -> x
#'
#' tlsh_is_valid(x)
tlsh_is_valid <- function(x) {
  x$lsh$is_valid()
}

#' Clear content and hash computation from a `tlsh` object
#'
#' Modestly lower-cost function that creating a new object.
#'
#' @md
#' @param x a `tlsh` object
#' @export
#' @examples
#' doc1 <- as.character(xml2::read_html(system.file("extdat", "index.html", package="tlsh")))
#'
#' tlsh() %>%
#'   tlsh_update(doc1) %>%
#'   tlsh_finalize() -> x
#'
#' tlsh_hash(x)
#'
#' x <- tlsh_reset(x)
tlsh_reset <- function(x) {
  x$lsh$reset()
  invisible(x)
}

#' Return a data frame of lvalue and q1/2 ratios from a `tlsh` object
#'
#' @md
#' @param x a `tlsh` object
#' @return data frame
#' @export
#' @examples
#' doc1 <- as.character(xml2::read_html(system.file("extdat", "index.html", package="tlsh")))
#'
#' tlsh() %>%
#'   tlsh_update(doc1) %>%
#'   tlsh_finalize() -> x
#'
#' tlsh_hash(x)
#'
#' tlsh_stats(x)
tlsh_stats <- function(x) {
  data.frame(
  l_value = x$lsh$l_value(),
  q1_ratio = x$lsh$q1_ratio(),
  q2_ratio  = x$lsh$q2_ratio(),
  stringsAsFactors = FALSE
  ) -> xdf

  class(xdf) <- c("tbl_df", "tbl", "data.frame")

  xdf

}

#' Retrieve the hex-encoded hash string for a `tlsh` object
#'
#' @md
#' @param x a `tlsh` object
#' @return length 1 character vector
#' @export
#' @examples
#' doc1 <- as.character(xml2::read_html(system.file("extdat", "index.html", package="tlsh")))
#'
#' tlsh() %>%
#'   tlsh_update(doc1) %>%
#'   tlsh_finalize() -> x
#'
#' tlsh_hash(x)
tlsh_hash <- function(x) {
  x$lsh$get_hash()
}

#' Compute distance between two TLSH objects
#'
#' @param x,y TLSH hash objects
#' @return distance value
#' @export
#' @examples
#' doc1 <- as.character(xml2::read_html(system.file("extdat", "index.html", package="tlsh")))
#' doc2 <- charToRaw(as.character(xml2::read_html(system.file("extdat", "index1.html", package="tlsh"))))
#'
#' x <- tlsh(doc1) %>% tlsh_finalize()
#' y <- tlsh(doc2) %>% tlsh_finalize()
#'
#' tlsh_dist(x, y)
tlsh_dist <- function(x, y) {
  tlsh_diff_fingerprints(x$lsh$get_hash(), y$lsh$get_hash())
}

#' @noRd
#' @param x tlsh object
#' @param ... unused
#' @export
print.tlsh <- function(x, ...) {
  cat("<tlsh object created under version ", x$lsh$lib_version(), ">\n", sep="")
}
