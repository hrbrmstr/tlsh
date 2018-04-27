// Generated by using Rcpp::compileAttributes() -> do not edit by hand
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <Rcpp.h>

using namespace Rcpp;

// tlsh_simple_hash_r
CharacterVector tlsh_simple_hash_r(std::vector < unsigned char> v);
RcppExport SEXP _tlsh_tlsh_simple_hash_r(SEXP vSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< std::vector < unsigned char> >::type v(vSEXP);
    rcpp_result_gen = Rcpp::wrap(tlsh_simple_hash_r(v));
    return rcpp_result_gen;
END_RCPP
}
// tlsh_simple_hash_c
CharacterVector tlsh_simple_hash_c(std::string v);
RcppExport SEXP _tlsh_tlsh_simple_hash_c(SEXP vSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< std::string >::type v(vSEXP);
    rcpp_result_gen = Rcpp::wrap(tlsh_simple_hash_c(v));
    return rcpp_result_gen;
END_RCPP
}
// tlsh_diff_fingerprints
NumericVector tlsh_diff_fingerprints(std::string hash1, std::string hash2);
RcppExport SEXP _tlsh_tlsh_diff_fingerprints(SEXP hash1SEXP, SEXP hash2SEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< std::string >::type hash1(hash1SEXP);
    Rcpp::traits::input_parameter< std::string >::type hash2(hash2SEXP);
    rcpp_result_gen = Rcpp::wrap(tlsh_diff_fingerprints(hash1, hash2));
    return rcpp_result_gen;
END_RCPP
}

static const R_CallMethodDef CallEntries[] = {
    {"_tlsh_tlsh_simple_hash_r", (DL_FUNC) &_tlsh_tlsh_simple_hash_r, 1},
    {"_tlsh_tlsh_simple_hash_c", (DL_FUNC) &_tlsh_tlsh_simple_hash_c, 1},
    {"_tlsh_tlsh_diff_fingerprints", (DL_FUNC) &_tlsh_tlsh_diff_fingerprints, 2},
    {NULL, NULL, 0}
};

RcppExport void R_init_tlsh(DllInfo *dll) {
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}