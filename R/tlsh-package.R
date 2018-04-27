#' Local Sensitivity Hashing Using the 'Trend Micro' 'TLSH' Implementation
#'
#' 'Trend Micro' provides an open source library <https://github.com/trendmicro/tlsh/>
#'  for local sensitivity hashing. Methods are provided to compute and compare
#'  hashes from character/byte streams.
#'
#' @md
#' @name tlsh
#' @docType package
#' @author Bob Rudis (bob@@rud.is)
#' @useDynLib tlsh
#' @importFrom Rcpp sourceCpp
#' @references
#' - Jonathan Oliver, Chun Cheng and Yanggui Chen,
#'    "[TLSH - A Locality Sensitive Hash](https://github.com/trendmicro/tlsh/blob/master/TLSH_CTC_final.pdf)"
#'    4th Cybercrime and Trustworthy Computing Workshop, Sydney, November 2013
#' - Jonathan Oliver, Scott Forman and Chun Cheng,
#'   "[Using Randomization to Attack Similarity Digests](https://github.com/trendmicro/tlsh/blob/master/Attacking_LSH_and_Sim_Dig.pdf)"
#'   Applications and Techniques in Information Security. Springer Berlin Heidelberg, 2014. 199-210.
#' - Jonathan Oliver and Jayson Pryde's
#'    [Trend Micro Blog Post](http://blog.trendmicro.com/trendlabs-security-intelligence/smart-whitelisting-using-locality-sensitive-hashing/)
NULL