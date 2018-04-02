
include site-config.mk

WITH_ALUCELL ?= off
WITH_FREEFEM ?= off
WITH_GMSH    ?= off

ifeq ($(WITH_ALUCELL),on)
  MODULES += -DENABLE_ALUCELL
endif

ifeq ($(WITH_FREEFEM),on)
  MODULES += -DENABLE_FREEFEM
endif

ifeq ($(WITH_GMSH),on)
  MODULES += -DENABLE_GMSH
endif


export OMPI_CXX = clang++

CXX = mpicxx
DEPS_BIN = g++

DEPSFLAGS = -std=c++11 -I$(SITE_INCLUDE_DIR) -I$(SITE_PETSC_INCLUDE_DIR) -I$(SITE_LAPACK_INCLUDE_DIR) \
	    $(shell mpicxx --showme:compile)
CXXFLAGS += -std=c++11 -Wall -Wextra -Wno-unused-parameter -std=c++11 \
            -I$(SITE_INCLUDE_DIR) -I$(SITE_PETSC_INCLUDE_DIR) -I$(SITE_LAPACK_INCLUDE_DIR) \
	    $(MODULES)
LDFLAGS += -Wall -Wextra \
	   -L$(SITE_PETSC_LIB_DIR) -L$(SITE_LAPACK_LIB_DIR) -L./lib/ -L$(SITE_LIB_DIR)
LDLIB = -lpetsc -llapacke -ltfel -lalucelldb
AR = ar
ARFLAGS = rc
MKDIR = mkdir
MKDIRFLAGS = -p

PREFIX = ~/.local/
BIN_DIR = bin/
INCLUDE_DIR = include/
LIB_DIR = lib/

PKG_NAME = pkg-name

SOURCES = \
	src/double_sided_driven_cavity.cpp


# exemple: HEADERS = include/pkg-name/test.hpp
HEADERS = 

BIN = bin/double_sided_driven_cavity


#bin/...: ...
bin/double_sided_driven_cavity: build/src/double_sided_driven_cavity.o

# exemple: LIB = lib/libtest.a
LIB = 

# exemple: lib/libtest.a: build/src/test.o
#lib/...: ...
