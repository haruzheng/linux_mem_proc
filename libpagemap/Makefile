################################################################################
# The MIT License
# Copyright (C) 2021 Haru Zheng
# Authors:
#	Haru Zheng	<towwy321+linux@gmail.com>
#
################################################################################

prefix =
target = libpagemap
src = $(wildcard *.c)
deps = $(wildcard *.h)
obj = $(patsubst %.c,%.o,$(src))

$(target): $(obj)
	$(prefix)ar rcs $(target).a $^

%.o: %.c $(deps)
	$(prefix)gcc -c $< -o $@ -Wall -D_LARGEFILE64_SOURCE -Iinclude/

.PHONY:clean
clean:
	-rm -rf $(target).a $(obj)