#define MB_HEADER_MAGIC	0x1BADB002
/* we don't need anything special from multiboot
 * bootloader so can leave this 0 */
#define MB_HEADER_FLAGS	0x00000000

	.section ".bootstrap", "ax"
	.code32
	.global start
	.extern main

	.align 16
start:
	jmp	1f

	.align 4
multiboot_header:
	.long MB_HEADER_MAGIC
	.long MB_HEADER_FLAGS
	.long -(MB_HEADER_MAGIC - MB_HEADER_FLAGS)

1:
	movl	$stack_top, %esp
	cld
	call	main

	cli
1:	hlt
	jmp	1b

	.bss
	.space	0x1000
stack_top:
