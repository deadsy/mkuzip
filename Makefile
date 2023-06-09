# Makefile for the FreeBSD mkuzip utility compiled for Linux and MacOS.

OUTPUT = mkuzip

SRC = mkuz_blk.c \
	mkuz_blockcache.c \
	mkuz_conveyor.c \
	mkuz_fqueue.c \
	mkuz_insize.c \
	mkuzip.c \
	mkuz_lzma.c \
	mkuz_time.c \
	mkuz_zlib.c \
	mkuz_zstd.c \
	strlcpy.c \
	md5.c \

OBJ = $(patsubst %.c, %.o, $(SRC))

CFLAGS = -Wall -Werror -Wextra -Wstrict-prototypes
CFLAGS += -O2

DEFINE = -D'__FBSDID(x)='

LIBS = -lpthread -lz -llzma -lzstd

# MacOS include/library paths
HOMEBREW = /opt/homebrew
ifneq "$(wildcard $(HOMEBREW))" ""
  INCLUDE += -I$(HOMEBREW)/include
  LDFLAGS += -L$(HOMEBREW)/lib
endif

# user installed include/library paths
LOCAL = $(HOME)/usr/local
ifneq "$(wildcard $(LOCAL))" ""
  INCLUDE += -I$(LOCAL)/include
  LDFLAGS += -L$(LOCAL)/lib
endif

.c.o:
	gcc $(INCLUDE) $(DEFINE) $(CFLAGS) -c $< -o $@

.PHONY: all
all: $(OBJ)
	gcc $(CFLAGS) $(LDFLAGS) $(OBJ) $(LIBS) -o $(OUTPUT)

.PHONY: install
install: $(OUTPUT)
	cp $(OUTPUT) /usr/local/bin

.PHONY: clean
clean:
	-rm $(OBJ)
	-rm $(OUTPUT)
