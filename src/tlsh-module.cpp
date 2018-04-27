#include <Rcpp.h>

#include "tlsh.h"
#include "tlsh-module.h"

using namespace Rcpp;

tlsh_r::tlsh_r() {
  tlsh_obj = new Tlsh();
  tlsh_obj->reset();
};

tlsh_r::~tlsh_r() {
  delete tlsh_obj;
};

std::string tlsh_r::all_in_one(std::vector < unsigned char > buffer) {

  unsigned char *p_buf = (unsigned char *)&*buffer.begin();

  tlsh_obj->reset();
  tlsh_obj->update(p_buf, buffer.size());
  tlsh_obj->final();

  return(std::string(tlsh_obj->getHash()));

}

void tlsh_r::update(std::vector < unsigned char > buffer) {
  unsigned char *p_buf = (unsigned char *)&*buffer.begin();
  tlsh_obj->update(p_buf, buffer.size());
}

void tlsh_r::final(int force_option = 0) {
  tlsh_obj->final(0, 0, force_option);
}

std::string tlsh_r::get_hash() {
  return(std::string(tlsh_obj->getHash()));
}

bool tlsh_r::is_valid() { return(tlsh_obj->isValid()); }

std::string tlsh_r::lib_version() { return(std::string(tlsh_obj->version())); }

void tlsh_r::reset() { tlsh_obj->reset(); }

int tlsh_r::l_value() { return(tlsh_obj->Lvalue()); }

int tlsh_r::q1_ratio() { return(tlsh_obj->Q1ratio()); }

int tlsh_r::q2_ratio() { return(tlsh_obj->Q2ratio()); }

void tlsh_r::from_tlsh_hash_string(std::string hash_string) {
  tlsh_obj->reset();
  int ret = tlsh_obj->fromTlshStr(hash_string.c_str());
  if (ret != 0) Rcpp::warning("Character hash not valid.");
}

RCPP_MODULE(TLSH) {

  using namespace Rcpp;

  class_<tlsh_r>("tlsh_r")
    .constructor()
    .method("all_in_one", &tlsh_r::all_in_one, "Add content to a TLSH object, compute the hash and return the hash hex string")
    .method("update", &tlsh_r::update, "Add data in multiple iterations")
    .method("final", &tlsh_r::final, "No more data to be added")
    .method("get_hash", &tlsh_r::get_hash, "Retrieve hex-encoded hash")
    .method("is_valid", &tlsh_r::is_valid, "Is the hash structure valid?")
    .method("lib_version", &tlsh_r::lib_version, "Get the library build info")
    .method("reset", &tlsh_r::reset, "Reset the object.")
    .method("l_value", &tlsh_r::l_value, "Hash diagnostics")
    .method("q1_ratio", &tlsh_r::q1_ratio, "Hash diagnostics")
    .method("q2_ratio", &tlsh_r::q2_ratio, "Hash diagnostics")
    // .method("compute_difference", &tlsh_r::compute_difference, "Calcuate the difference metric between two TLSH hashes")
    .method("from_tlsh_hash_string", &tlsh_r::from_tlsh_hash_string, "Turn a TLSH hash string into an object value")
 ;

}