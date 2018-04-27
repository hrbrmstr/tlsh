#include <Rcpp.h>

#include "tlsh.h"

using namespace Rcpp;

// [[Rcpp::export]]
CharacterVector tlsh_simple_hash_r(std::vector < unsigned char> v) {

  unsigned char *p_buf = (unsigned char *)&*v.begin();

  Tlsh tlsh;
  tlsh.update(p_buf, v.size());
  tlsh.final();

  return(CharacterVector::create(tlsh.getHash()));

}

// [[Rcpp::export]]
CharacterVector tlsh_simple_hash_c(std::string v) {

  unsigned char *p_buf = (unsigned char *)&*v.begin();

  Tlsh tlsh;
  tlsh.update(p_buf, v.length());
  tlsh.final();

  return(CharacterVector::create(tlsh.getHash()));

}

// [[Rcpp::export]]
NumericVector tlsh_diff_fingerprints(std::string hash1, std::string hash2) {

  Tlsh tlsh1, tlsh2;

  if (tlsh1.fromTlshStr(hash1.c_str()) != 0) {
    Rcpp::warning("First hash string is not valid.");
    return(NA_REAL);
  }

  if (tlsh2.fromTlshStr(hash2.c_str()) != 0) {
    Rcpp::warning("Second hash string is not valid.");
    return(NA_REAL);
  }

  return(NumericVector::create(tlsh1.totalDiff(&tlsh2)));

}

