.RECIPEPREFIX = >

.PHONY: release debug help clean format

ifeq ($(OS), Windows_NT)
    override DETECTED_OS := Windows
else
    override DETECTED_OS := $(shell uname -s)
endif

export DETECTED_OS

ifeq ($(DETECTED_OS),Darwin)
    override VERSION := $(shell cat src/version.txt)
else
    override VERSION := $(file < src/version.txt)
endif

export VERSION

CXX := clang++
export CXX

GIT_SHA := $(shell git rev-parse --short HEAD)
export GIT_SHA

ifeq ($(DETECTED_OS),Windows)
	EXE := GameBeer.exe
else
	EXE := GameBeer
endif

export EXE

native:
> $(MAKE) -f scripts/build.mk TYPE=$@ NOT_CALLED=1

release:
> $(MAKE) -f scripts/build.mk TYPE=$@ NOT_CALLED=1

debug:
> $(MAKE) -f scripts/build.mk TYPE=$@ NOT_CALLED=1


format:
> clang-format -i $(shell find src -name '*.hpp' -o -name '*.cpp')

clean:
> rm -rf build
> rm $(EXE)