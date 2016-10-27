CC ?= gcc

CFLAGS := -g -m32 -Wall -Wextra -Werror -pedantic -ansi -ffreestanding
LFLAGS := -nostdlib -z max-page-size=0x1000

ASM := $(shell find . -name '*.S')
SRC := $(shell find . -name '*.c')
OBJ := $(ASM:.S=.o) $(SRC:.c=.o)
DEP := $(OBJ:.o=.d)

all: multiboot

multiboot: $(OBJ) linker.ld
	$(CC) $(LFLAGS) -T linker.ld -o $@ $(OBJ)

%.o: %.c
	$(CC) $(CFLAGS) -MD -c $< -o $@

%.o: %.S
	$(CC) -m32 -g -MD -c $< -o $@

-include $(DEP)

.PHONY: clean
clean:
	rm -rf $(DEP) $(OBJ) multiboot
