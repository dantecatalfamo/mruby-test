MRB_CONFIG = ./mruby/bin/mruby-config
CFLAGS = $(shell $(MRB_CONFIG) --cflags)
LDFLAGS = $(shell $(MRB_CONFIG) --ldflags)
LIBS = $(shell $(MRB_CONFIG) --libs)
LIBMRUBY = $(shell $(MRB_CONFIG) --libmruby-path)
CC = $(shell $(MRB_CONFIG) --cc)

test: src/test.c
	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS) $(LIBS) $(LIBMRUBY)

ccls: .ccls
	ruby ccls.rb
