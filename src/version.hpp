#pragma once

#include <string_view>

namespace gamebeer {
  [[nodiscard]] auto version() -> std::string_view;
  [[nodiscard]] auto sha() -> std::string_view;
}  // namespace gamebeer
