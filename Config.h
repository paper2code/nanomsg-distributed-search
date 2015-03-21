#ifndef SEARCH_CONFIG_H
#define SEARCH_CONFIG_H

#include <ios>
#include <locale>
#include <vector>
#include <string>

namespace Config {

void init() noexcept {
  std::locale::global(std::locale(""));
  std::ios_base::sync_with_stdio(false);
}

std::vector<std::string> args(int argc, char** argv) {
  return {argv, argv + argc};
}

}

#endif
