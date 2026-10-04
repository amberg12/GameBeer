#include "version.hpp"

namespace gamebeer {
  auto version() -> std::string_view {
    return GAMEBEER_VERSION;
  }

  auto sha() -> std::string_view {
    return GAMEBEER_SHA;
  }
}
