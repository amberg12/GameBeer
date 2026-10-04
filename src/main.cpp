#include <print>

#include "version.hpp"

auto main() -> int {
  std::println("Hello, {} {}", gamebeer::version(), gamebeer::sha());
}
