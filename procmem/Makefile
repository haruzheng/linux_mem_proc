################################################################################
# The MIT License
# Copyright (C) 2021 Haru Zheng
# Authors:
#	Haru Zheng	<towwy321+linux@gmail.com>
#
################################################################################

prefix =
outdir = .
target = procmem
lib = -lc -L../libpagemap/
src = $(wildcard *.c)
deps = $(wildcard *.h)
obj = $(patsubst %.c,%.o,$(src))

$(target): $(obj)
	$(prefix)gcc $^ -o $(outdir)/$@ -Wall $(lib) ../libpagemap/libpagemap.a --static

%.o: %.c $(deps)
	$(prefix)gcc -c $< -o $@ -Wall -I../libpagemap/include/

.PHONY:clean
clean:
	-rm -rf $(target) $(obj)