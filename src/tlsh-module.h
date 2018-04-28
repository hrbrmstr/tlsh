#ifndef TLSH_MODULE_H
#define TLSH_MODULE_H

#include <Rcpp.h>

#include "tlsh.h"

using namespace Rcpp;

//' @export
class tlsh_r {

protected:

  Tlsh *tlsh_obj;

public:

  tlsh_r();

  ~tlsh_r();

  std::string all_in_one(std::vector < unsigned char >);

  void update(std::vector < unsigned char >);

  void final(int);

  std::string get_hash();

  bool is_valid();

  std::string lib_version();

  void reset();

  int l_value();

  int q1_ratio();

  int q2_ratio();

  void from_tlsh_hash_string(std::string);

  Tlsh *get_obj();

};

#endif // TLSH_MODULE_H
