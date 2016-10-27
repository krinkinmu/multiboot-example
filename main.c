#include <stddef.h>

static char * const VIDEO = (char *)0xb8000;
static const unsigned ROWS = 25;
static const unsigned COLS = 80;
static const unsigned ATTR = 15;

static unsigned row;
static unsigned col;


static void *memset(void *dst, int data, size_t size)
{
	char *buf = dst;
	size_t i;

	for (i = 0; i != size; ++i)
		buf[i] = data;
	return dst;
}

static void putchar(int c)
{
	if ('\n' == c || COLS == col) {
		row = (row + 1) % ROWS;
		col = 0;
		memset(VIDEO + row * COLS * 2, 0, COLS * 2);
		return;
	}
	VIDEO[(col + row * COLS) * 2] = c;
	VIDEO[1 + (col + row * COLS) * 2] = ATTR;
	++col;
}

static void clrscr(void)
{
	memset(VIDEO, 0, COLS * ROWS * 2);
	col = row = 0;
}

static void puts(const char *str)
{
	while (*str)
		putchar(*str++);
	putchar('\n');
}

void main(void)
{
	clrscr();
	puts("Hello!");
}
