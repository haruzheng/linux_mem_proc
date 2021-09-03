################################################################################
# The MIT License
# Copyright (C) 2021 Haru Zheng
# Authors:
#	Haru Zheng	<towwy321+linux@gmail.com>
#
################################################################################

# Default C compiler prefix name
CC =
# ARM32 C compiler prefix name
A32CC = arm-linux-gnueabi-
# ARM64 C compiler prefix name
A64CC = aarch64-linux-gnu-

# Output Variable
DESTDIR = $(PWD)/bin				# Output folder path

help:
	@echo "make help - Show help message."
	@echo "make all [CC=GCC_COMPILER] [DESTDIR=OUTPUT_PATH] - Build default gcc arch binary."
	@echo "make arm [A32CC=ARM_GCC_COMPILER] [DESTDIR=OUTPUT_PATH] - Build ARM aarch32 gcc binary."
	@echo "make arm32 [A32CC=ARM_GCC_COMPILER] [DESTDIR=OUTPUT_PATH] - Build ARM aarch32 gcc binary."
	@echo "make arm64 [A64CC=ARM_GCC_COMPILER] [DESTDIR=OUTPUT_PATH] - Build ARM aarch64 gcc binary."

checkfolder:
ifeq "$(wildcard ${DESTDIR})" ""
	@mkdir ${DESTDIR} | echo 'Create folder Done.'
endif

clean:
	@rm -rf ${DESTDIR}
	@find . -name "*.o" -exec rm -rf {} \;
	@find . -name "*.a" -exec rm -rf {} \;

.PHONY: libpagemap
libpagemap:
	$(MAKE) -C libpagemap clean
	$(MAKE) -C libpagemap prefix=${CC}

.PHONY: procmem
procmem:
	$(MAKE) -C procmem clean
	$(MAKE) -C procmem prefix=${CC} outdir=${DESTDIR}

.PHONY: procrank
procrank:
	$(MAKE) -C procrank clean
	$(MAKE) -C procrank prefix=${CC} outdir=${DESTDIR}

all: checkfolder
	$(MAKE) libpagemap
	$(MAKE) procmem
	$(MAKE) procrank

arm: checkfolder
	$(MAKE) libpagemap CC=${A32CC}
	$(MAKE) procmem CC=${A32CC}
	$(MAKE) procrank CC=${A32CC}

arm32: arm

arm64: checkfolder
	$(MAKE) libpagemap CC=${A64CC}
	$(MAKE) procmem CC=${A64CC}
	$(MAKE) procrank CC=${A64CC}
