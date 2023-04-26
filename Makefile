# makefile for the FreeBSD mkuzip utility compiled for Linux.

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

.c.o:
	gcc $(INCLUDE) $(DEFINE) $(CFLAGS) -c $< -o $@

all: $(OBJ)
	gcc $(CFLAGS) $(LDFLAGS) $(OBJ) $(LIBS) -o $(OUTPUT)

clean:
	-rm $(OBJ)
	-rm $(OUTPUT)
