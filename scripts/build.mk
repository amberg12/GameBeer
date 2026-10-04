.RECIPEPREFIX = >

ifndef NOT_CALLED
$(error Do not call this file directly, use the top-level Makefile)
endif

ifeq ($(TYPE),native)
    CXXFLAGS := -O3 -march=native
else ifeq ($(TYPE),release)
    CXXFLAGS := -O3 -march=x86-64
else ifeq ($(TYPE),debug)
    CXXFLAGS := -O1 -flto -g -fsanitize=address,undefined
else
    $(error Unknown TYPE '$(TYPE)', expected native, release or debug)
endif

CXXFLAGS += \
    -std=c++26 \
    -Wextra \
    -Wall \
    -Werror \
    -Wpedantic

SRCS := \
    src/main.cpp

VERSION_SRC := \
    src/version.cpp

BUILD_DIR := build/$(TYPE)

OBJS        := $(SRCS:%.cpp=$(BUILD_DIR)/%.o)
VERSION_OBJ := $(VERSION_SRC:%.cpp=$(BUILD_DIR)/%.o)
DEPS        := $(OBJS:.o=.d) $(VERSION_OBJ:.o=.d)

VERSION_STAMP := $(BUILD_DIR)/version.stamp

.PHONY: default FORCE

default: $(BUILD_DIR)/$(EXE)

$(BUILD_DIR)/$(EXE): $(OBJS) $(VERSION_OBJ)
> $(CXX) $(CXXFLAGS) $^ -o $@
> cp $@ $(notdir $@)

$(BUILD_DIR)/%.o: %.cpp
> @mkdir -p $(dir $@)
> $(CXX) $(CXXFLAGS) -MMD -MP -c $< -o $@

$(VERSION_OBJ): CXXFLAGS += -DGAMEBEER_VERSION='"$(VERSION)"' -DGAMEBEER_SHA='"$(GIT_SHA)"'
$(VERSION_OBJ): $(VERSION_STAMP)

$(VERSION_STAMP): FORCE
> @mkdir -p $(dir $@)
> @echo '$(VERSION) $(GIT_SHA)' | cmp -s - $@ || echo '$(VERSION) $(GIT_SHA)' > $@

FORCE:

-include $(DEPS)