
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

OBJ = $(patsubst %.c, %.o, $(SRC))

CFLAGS = -Wall -Werror -Wextra -Wstrict-prototypes
CFLAGS += -O2

INCLUDE = -I./bsd

DEFINE = -D'__FBSDID(x)='

.c.o:
	gcc $(INCLUDE) $(DEFINE) $(CFLAGS) -c $< -o $@

all: $(OBJ)
	gcc $(CFLAGS) $(LDFLAGS) $(OBJ) $(LIBS) -o $(OUTPUT)

clean:
	-rm $(OBJ)
