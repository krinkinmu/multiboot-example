OUTPUT_FORMAT("elf32-i386", "elf32-i386", "elf32-i386")
OUTPUT_ARCH(i386)
ENTRY(start)

SECTIONS
{
	. = 1M + SIZEOF_HEADERS;

	.bootstrap : { *(.bootstrap) }
	.test : { *(.text) *(.text.*) }
	.rodata : { *(.rodata) *(.rodata.*) }
	.data : { *(.data) *(.data.*) }
	.bss : { *(.bss) *(.bss.*) }
}
