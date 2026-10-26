
/Users/antonkrutov/Desktop/Forest/localization/probes/ru-20261026-39/game/UnityPlayer.dll:	file format coff-x86-64

Disassembly of section .text:

0000000180539bd0 <UnityMain>:
1808c7880: 48 89 5c 24 08              	movq	%rbx, 0x8(%rsp)
1808c7885: 4c 89 44 24 18              	movq	%r8, 0x18(%rsp)
1808c788a: 48 89 54 24 10              	movq	%rdx, 0x10(%rsp)
1808c788f: 55                          	pushq	%rbp
1808c7890: 56                          	pushq	%rsi
1808c7891: 57                          	pushq	%rdi
1808c7892: 41 54                       	pushq	%r12
1808c7894: 41 55                       	pushq	%r13
1808c7896: 41 56                       	pushq	%r14
1808c7898: 41 57                       	pushq	%r15
1808c789a: 48 8d 6c 24 e9              	leaq	-0x17(%rsp), %rbp
1808c789f: 48 81 ec e0 00 00 00        	subq	$0xe0, %rsp
1808c78a6: 48 8b fa                    	movq	%rdx, %rdi
1808c78a9: 48 8b d9                    	movq	%rcx, %rbx
1808c78ac: 33 d2                       	xorl	%edx, %edx
1808c78ae: 48 8d 0d 63 c7 dd 00        	leaq	0xddc763(%rip), %rcx    # 0x1816a4018
1808c78b5: 45 8b e9                    	movl	%r9d, %r13d
1808c78b8: 4d 8b e0                    	movq	%r8, %r12
1808c78bb: e8 10 c3 cc ff              	callq	0x180593bd0 <UnityMain+0x5a000>
1808c78c0: 45 33 f6                    	xorl	%r14d, %r14d
1808c78c3: 48 85 c0                    	testq	%rax, %rax
1808c78c6: 74 0d                       	je	0x1808c78d5 <UnityMain+0x38dd05>
1808c78c8: 48 8b c8                    	movq	%rax, %rcx
1808c78cb: e8 00 7f cb 00              	callq	0x18157f7d0 <UnityMain+0x1045c00>
1808c78d0: 44 8b f8                    	movl	%eax, %r15d
1808c78d3: eb 03                       	jmp	0x1808c78d8 <UnityMain+0x38dd08>
1808c78d5: 45 8b fe                    	movl	%r14d, %r15d
1808c78d8: 48 8d 0d 41 eb ff ff        	leaq	-0x14bf(%rip), %rcx     # 0x1808c6420 <UnityMain+0x38c850>
1808c78df: ff 15 bb 71 16 01           	callq	*0x11671bb(%rip)        # 0x181a2eaa0 ; mono_set_find_plugin_callback
1808c78e5: 48 8d 4d 8f                 	leaq	-0x71(%rbp), %rcx
1808c78e9: e8 12 5f eb ff              	callq	0x18077d800 <UnityMain+0x243c30>
1808c78ee: 48 8b 08                    	movq	(%rax), %rcx
1808c78f1: 48 85 c9                    	testq	%rcx, %rcx
1808c78f4: 75 04                       	jne	0x1808c78fa <UnityMain+0x38dd2a>
1808c78f6: 48 8d 48 08                 	leaq	0x8(%rax), %rcx
1808c78fa: e8 f9 d3 cb 00              	callq	0x181584cf8 <UnityMain+0x104b128>
1808c78ff: 48 8d 4d 8f                 	leaq	-0x71(%rbp), %rcx
1808c7903: 48 89 05 7e 6c 16 01        	movq	%rax, 0x1166c7e(%rip)   # 0x181a2e588
1808c790a: e8 e1 d9 7c ff              	callq	0x1800952f0 <.text+0x942f0>
1808c790f: 45 33 c9                    	xorl	%r9d, %r9d
1808c7912: 4c 8d 05 67 4a 00 00        	leaq	0x4a67(%rip), %r8       # 0x1808cc380 <UnityMain+0x3927b0>
1808c7919: 48 8d 15 40 4d 00 00        	leaq	0x4d40(%rip), %rdx      # 0x1808cc660 <UnityMain+0x392a90>
1808c7920: 48 8d 0d 79 4a 00 00        	leaq	0x4a79(%rip), %rcx      # 0x1808cc3a0 <UnityMain+0x3927d0>
1808c7927: ff 15 33 75 16 01           	callq	*0x1167533(%rip)        # 0x181a2ee60 ; mono_dl_fallback_register
1808c792d: ff 15 1d 6f 16 01           	callq	*0x1166f1d(%rip)        # 0x181a2e850 ; mono_class_get_userdata_offset
1808c7933: 45 33 c9                    	xorl	%r9d, %r9d
1808c7936: c7 44 24 28 d1 08 00 00     	movl	$0x8d1, 0x28(%rsp)      # imm = 0x8D1
1808c793e: ba 04 00 00 00              	movl	$0x4, %edx
1808c7943: 89 05 83 8f 16 01           	movl	%eax, 0x1168f83(%rip)   # 0x181a308cc
1808c7949: 48 8d 35 b4 d6 cf 00        	leaq	0xcfd6b4(%rip), %rsi    # 0x1815c5004
1808c7950: 8b ca                       	movl	%edx, %ecx
1808c7952: 48 89 74 24 20              	movq	%rsi, 0x20(%rsp)
1808c7957: 45 8d 41 35                 	leal	0x35(%r9), %r8d
1808c795b: e8 90 64 cb ff              	callq	0x18057ddf0 <UnityMain+0x44220>
1808c7960: 8b 15 56 bc dd 00           	movl	0xddbc56(%rip), %edx    # 0x1816a35bc
1808c7966: 41 b8 08 00 00 00           	movl	$0x8, %r8d
1808c796c: 4c 8b ce                    	movq	%rsi, %r9
1808c796f: c7 44 24 20 eb 01 00 00     	movl	$0x1eb, 0x20(%rsp)      # imm = 0x1EB
1808c7977: c7 00 35 00 00 00           	movl	$0x35, (%rax)
1808c797d: 41 8d 48 18                 	leal	0x18(%r8), %ecx
1808c7981: 48 89 05 f8 6b 16 01        	movq	%rax, 0x1166bf8(%rip)   # 0x181a2e580
1808c7988: e8 53 2e cb ff              	callq	0x18057a7e0 <UnityMain+0x40c10>
1808c798d: 48 85 c0                    	testq	%rax, %rax
1808c7990: 74 18                       	je	0x1808c79aa <UnityMain+0x38ddda>
1808c7992: 4c 89 30                    	movq	%r14, (%rax)
1808c7995: c7 40 08 4b 00 00 00        	movl	$0x4b, 0x8(%rax)
1808c799c: 4c 89 70 10                 	movq	%r14, 0x10(%rax)
1808c79a0: 48 c7 40 18 01 00 00 00     	movq	$0x1, 0x18(%rax)
1808c79a8: eb 03                       	jmp	0x1808c79ad <UnityMain+0x38dddd>
1808c79aa: 49 8b c6                    	movq	%r14, %rax
1808c79ad: 48 89 05 dc 6b 16 01        	movq	%rax, 0x1166bdc(%rip)   # 0x181a2e590
1808c79b4: 48 89 75 b7                 	movq	%rsi, -0x49(%rbp)
1808c79b8: e8 d3 51 ea ff              	callq	0x18076cb90 <UnityMain+0x232fc0>
1808c79bd: 49 8b c6                    	movq	%r14, %rax
1808c79c0: 48 8d 0d 41 c4 dd 00        	leaq	0xddc441(%rip), %rcx    # 0x1816a3e08
1808c79c7: 44 38 34 08                 	cmpb	%r14b, (%rax,%rcx)
1808c79cb: 74 0e                       	je	0x1808c79db <UnityMain+0x38de0b>
1808c79cd: 48 ff c0                    	incq	%rax
1808c79d0: 48 83 f8 17                 	cmpq	$0x17, %rax
1808c79d4: 72 f1                       	jb	0x1808c79c7 <UnityMain+0x38ddf7>
1808c79d6: b8 17 00 00 00              	movl	$0x17, %eax
1808c79db: 48 89 4c 24 30              	movq	%rcx, 0x30(%rsp)
1808c79e0: 48 8d 54 24 30              	leaq	0x30(%rsp), %rdx
1808c79e5: 48 8d 4d bf                 	leaq	-0x41(%rbp), %rcx
1808c79e9: 48 89 44 24 38              	movq	%rax, 0x38(%rsp)
1808c79ee: e8 8d 08 f5 ff              	callq	0x180818280 <UnityMain+0x2de6b0>
1808c79f3: 48 8b 55 d7                 	movq	-0x29(%rbp), %rdx
1808c79f7: 48 85 d2                    	testq	%rdx, %rdx
1808c79fa: 0f 84 58 01 00 00           	je	0x1808c7b58 <UnityMain+0x38df88>
1808c7a00: 48 8b 45 bf                 	movq	-0x41(%rbp), %rax
1808c7a04: 48 8d 4d c7                 	leaq	-0x39(%rbp), %rcx
1808c7a08: 48 85 c0                    	testq	%rax, %rax
1808c7a0b: 48 89 54 24 38              	movq	%rdx, 0x38(%rsp)
1808c7a10: 48 0f 45 c8                 	cmovneq	%rax, %rcx
1808c7a14: 48 89 4c 24 30              	movq	%rcx, 0x30(%rsp)
1808c7a19: 48 8d 4c 24 30              	leaq	0x30(%rsp), %rcx
1808c7a1e: e8 4d e6 f4 ff              	callq	0x180816070 <UnityMain+0x2dc4a0>
1808c7a23: 84 c0                       	testb	%al, %al
1808c7a25: 0f 84 2d 01 00 00           	je	0x1808c7b58 <UnityMain+0x38df88>
1808c7a2b: 48 8b 43 10                 	movq	0x10(%rbx), %rax
1808c7a2f: 41 b8 01 00 00 00           	movl	$0x1, %r8d
1808c7a35: 4c 89 74 24 30              	movq	%r14, 0x30(%rsp)
1808c7a3a: 4c 89 74 24 40              	movq	%r14, 0x40(%rsp)
1808c7a3f: 4c 8b 33                    	movq	(%rbx), %r14
1808c7a42: 48 8d 0c 80                 	leaq	(%rax,%rax,4), %rcx
1808c7a46: c7 44 24 38 01 00 00 00     	movl	$0x1, 0x38(%rsp)
1808c7a4e: 48 b8 67 66 66 66 66 66 66 66       	movabsq	$0x6666666666666667, %rax # imm = 0x6666666666666667
1808c7a58: 4c 89 44 24 48              	movq	%r8, 0x48(%rsp)
1808c7a5d: 49 8d 14 ce                 	leaq	(%r14,%rcx,8), %rdx
1808c7a61: 49 2b d6                    	subq	%r14, %rdx
1808c7a64: 48 f7 ea                    	imulq	%rdx
1808c7a67: 48 8b f2                    	movq	%rdx, %rsi
1808c7a6a: 48 c1 fe 04                 	sarq	$0x4, %rsi
1808c7a6e: 48 8b c6                    	movq	%rsi, %rax
1808c7a71: 48 c1 e8 3f                 	shrq	$0x3f, %rax
1808c7a75: 48 03 f0                    	addq	%rax, %rsi
1808c7a78: 74 18                       	je	0x1808c7a92 <UnityMain+0x38dec2>
1808c7a7a: 48 8b d6                    	movq	%rsi, %rdx
1808c7a7d: 48 8d 4c 24 30              	leaq	0x30(%rsp), %rcx
1808c7a82: e8 b9 59 80 ff              	callq	0x1800cd440 <.text+0xcc440>
1808c7a87: 8b 5c 24 38                 	movl	0x38(%rsp), %ebx
1808c7a8b: 48 89 74 24 40              	movq	%rsi, 0x40(%rsp)
1808c7a90: eb 0d                       	jmp	0x1808c7a9f <UnityMain+0x38decf>
1808c7a92: 48 89 74 24 40              	movq	%rsi, 0x40(%rsp)
1808c7a97: 41 8b d8                    	movl	%r8d, %ebx
1808c7a9a: 48 85 f6                    	testq	%rsi, %rsi
1808c7a9d: 74 40                       	je	0x1808c7adf <UnityMain+0x38df0f>
1808c7a9f: 48 8b 7c 24 30              	movq	0x30(%rsp), %rdi
1808c7aa4: 48 85 ff                    	testq	%rdi, %rdi
1808c7aa7: 74 1a                       	je	0x1808c7ac3 <UnityMain+0x38def3>
1808c7aa9: 33 c0                       	xorl	%eax, %eax
1808c7aab: 89 5f 20                    	movl	%ebx, 0x20(%rdi)
1808c7aae: 48 89 07                    	movq	%rax, (%rdi)
1808c7ab1: 49 8b d6                    	movq	%r14, %rdx
1808c7ab4: 48 89 47 18                 	movq	%rax, 0x18(%rdi)
1808c7ab8: 48 8b cf                    	movq	%rdi, %rcx
1808c7abb: 88 47 08                    	movb	%al, 0x8(%rdi)
1808c7abe: e8 cd d6 7c ff              	callq	0x180095190 <.text+0x94190>
1808c7ac3: 49 83 c6 28                 	addq	$0x28, %r14
1808c7ac7: 48 83 c7 28                 	addq	$0x28, %rdi
1808c7acb: 48 83 ee 01                 	subq	$0x1, %rsi
1808c7acf: 75 d3                       	jne	0x1808c7aa4 <UnityMain+0x38ded4>
1808c7ad1: 4c 8b 44 24 48              	movq	0x48(%rsp), %r8
1808c7ad6: 48 8b 74 24 40              	movq	0x40(%rsp), %rsi
1808c7adb: 48 8b 7d 5f                 	movq	0x5f(%rbp), %rdi
1808c7adf: 48 8d 5e 01                 	leaq	0x1(%rsi), %rbx
1808c7ae3: 49 d1 e8                    	shrq	%r8
1808c7ae6: 49 3b d8                    	cmpq	%r8, %rbx
1808c7ae9: 76 10                       	jbe	0x1808c7afb <UnityMain+0x38df2b>
1808c7aeb: 45 33 c0                    	xorl	%r8d, %r8d
1808c7aee: 48 8d 4c 24 30              	leaq	0x30(%rsp), %rcx
1808c7af3: 48 8b d3                    	movq	%rbx, %rdx
1808c7af6: e8 45 59 80 ff              	callq	0x1800cd440 <.text+0xcc440>
1808c7afb: 48 89 5c 24 40              	movq	%rbx, 0x40(%rsp)
1808c7b00: 4c 8d 04 b6                 	leaq	(%rsi,%rsi,4), %r8
1808c7b04: 48 8b 5c 24 30              	movq	0x30(%rsp), %rbx
1808c7b09: 49 c1 e0 03                 	shlq	$0x3, %r8
1808c7b0d: 48 8b d3                    	movq	%rbx, %rdx
1808c7b10: 48 8d 4b 28                 	leaq	0x28(%rbx), %rcx
1808c7b14: e8 67 88 ca 00              	callq	0x181570380 <UnityMain+0x10367b0>
1808c7b19: 8b 44 24 38                 	movl	0x38(%rsp), %eax
1808c7b1d: 45 33 f6                    	xorl	%r14d, %r14d
1808c7b20: 48 85 db                    	testq	%rbx, %rbx
1808c7b23: 74 1a                       	je	0x1808c7b3f <UnityMain+0x38df6f>
1808c7b25: 4c 89 33                    	movq	%r14, (%rbx)
1808c7b28: 48 8d 55 bf                 	leaq	-0x41(%rbp), %rdx
1808c7b2c: 4c 89 73 18                 	movq	%r14, 0x18(%rbx)
1808c7b30: 48 8b cb                    	movq	%rbx, %rcx
1808c7b33: 89 43 20                    	movl	%eax, 0x20(%rbx)
1808c7b36: 44 88 73 08                 	movb	%r14b, 0x8(%rbx)
1808c7b3a: e8 51 d6 7c ff              	callq	0x180095190 <.text+0x94190>
1808c7b3f: 48 8b d7                    	movq	%rdi, %rdx
1808c7b42: 48 8d 4c 24 30              	leaq	0x30(%rsp), %rcx
1808c7b47: e8 64 2d 00 00              	callq	0x1808ca8b0 <UnityMain+0x390ce0>
1808c7b4c: 48 8d 4c 24 30              	leaq	0x30(%rsp), %rcx
1808c7b51: e8 aa 02 81 ff              	callq	0x1800d7e00 <.text+0xd6e00>
1808c7b56: eb 0b                       	jmp	0x1808c7b63 <UnityMain+0x38df93>
1808c7b58: 48 8b d7                    	movq	%rdi, %rdx
1808c7b5b: 48 8b cb                    	movq	%rbx, %rcx
1808c7b5e: e8 4d 2d 00 00              	callq	0x1808ca8b0 <UnityMain+0x390ce0>
1808c7b63: ba 01 00 00 00              	movl	$0x1, %edx
1808c7b68: 33 c9                       	xorl	%ecx, %ecx
1808c7b6a: e8 79 6e cb 00              	callq	0x18157e9e8 <UnityMain+0x1044e18>
1808c7b6f: 48 8d 15 fa f9 ff ff        	leaq	-0x606(%rip), %rdx      # 0x1808c7570 <UnityMain+0x38d9a0>
1808c7b76: b9 16 00 00 00              	movl	$0x16, %ecx
1808c7b7b: e8 44 75 cc 00              	callq	0x18158f0c4 <UnityMain+0x10554f4>
1808c7b80: 48 8d 15 e9 f9 ff ff        	leaq	-0x617(%rip), %rdx      # 0x1808c7570 <UnityMain+0x38d9a0>
1808c7b87: b9 0b 00 00 00              	movl	$0xb, %ecx
1808c7b8c: e8 33 75 cc 00              	callq	0x18158f0c4 <UnityMain+0x10554f4>
1808c7b91: b9 01 00 00 00              	movl	$0x1, %ecx
1808c7b96: ff 15 04 6d 16 01           	callq	*0x1166d04(%rip)        # 0x181a2e8a0 ; mono_set_signal_chaining
1808c7b9c: 48 8b 05 75 73 16 01        	movq	0x1167375(%rip), %rax   # 0x181a2ef18
1808c7ba3: 48 85 c0                    	testq	%rax, %rax
1808c7ba6: 74 07                       	je	0x1808c7baf <UnityMain+0x38dfdf>
1808c7ba8: b9 01 00 00 00              	movl	$0x1, %ecx
1808c7bad: ff d0                       	callq	*%rax
1808c7baf: 48 8b 05 fa 71 16 01        	movq	0x11671fa(%rip), %rax   # 0x181a2edb0 ; mono_parse_default_optimizations
1808c7bb6: 33 c9                       	xorl	%ecx, %ecx
1808c7bb8: ff d0                       	callq	*%rax
1808c7bba: 8b d0                       	movl	%eax, %edx
1808c7bbc: 33 c9                       	xorl	%ecx, %ecx
1808c7bbe: ff 15 f4 71 16 01           	callq	*0x11671f4(%rip)        # 0x181a2edb8 ; mono_set_defaults
1808c7bc4: 45 85 ff                    	testl	%r15d, %r15d
1808c7bc7: 74 40                       	je	0x1808c7c09 <UnityMain+0x38e039>
1808c7bc9: 45 8b c7                    	movl	%r15d, %r8d
1808c7bcc: 48 8d 15 5d c4 dd 00        	leaq	0xddc45d(%rip), %rdx    # 0x1816a4030
1808c7bd3: 48 8d 4d 8f                 	leaq	-0x71(%rbp), %rcx
1808c7bd7: e8 b4 62 f4 ff              	callq	0x18080de90 <UnityMain+0x2d42c0>
1808c7bdc: 48 8b 45 8f                 	movq	-0x71(%rbp), %rax
1808c7be0: 48 8d 55 97                 	leaq	-0x69(%rbp), %rdx
1808c7be4: 48 85 c0                    	testq	%rax, %rax
1808c7be7: b9 01 00 00 00              	movl	$0x1, %ecx
1808c7bec: 48 0f 45 d0                 	cmovneq	%rax, %rdx
1808c7bf0: 48 89 54 24 30              	movq	%rdx, 0x30(%rsp)
1808c7bf5: 48 8d 54 24 30              	leaq	0x30(%rsp), %rdx
1808c7bfa: ff 15 e0 71 16 01           	callq	*0x11671e0(%rip)        # 0x181a2ede0 ; mono_jit_parse_options
1808c7c00: 48 8d 4d 8f                 	leaq	-0x71(%rbp), %rcx
1808c7c04: e8 e7 d6 7c ff              	callq	0x1800952f0 <.text+0x942f0>
1808c7c09: 48 83 3d ff 72 16 01 00     	cmpq	$0x0, 0x11672ff(%rip)   # 0x181a2ef10
1808c7c11: 74 61                       	je	0x1808c7c74 <UnityMain+0x38e0a4>
1808c7c13: 49 8b c6                    	movq	%r14, %rax
1808c7c16: 48 8d 0d 33 c4 dd 00        	leaq	0xddc433(%rip), %rcx    # 0x1816a4050
1808c7c1d: 0f 1f 00                    	nopl	(%rax)
1808c7c20: 80 3c 08 00                 	cmpb	$0x0, (%rax,%rcx)
1808c7c24: 74 0e                       	je	0x1808c7c34 <UnityMain+0x38e064>
1808c7c26: 48 ff c0                    	incq	%rax
1808c7c29: 48 83 f8 0d                 	cmpq	$0xd, %rax
1808c7c2d: 72 f1                       	jb	0x1808c7c20 <UnityMain+0x38e050>
1808c7c2f: b8 0d 00 00 00              	movl	$0xd, %eax
1808c7c34: 48 89 4c 24 30              	movq	%rcx, 0x30(%rsp)
1808c7c39: 48 8d 54 24 30              	leaq	0x30(%rsp), %rdx
1808c7c3e: 48 8d 4d 8f                 	leaq	-0x71(%rbp), %rcx
1808c7c42: 48 89 44 24 38              	movq	%rax, 0x38(%rsp)
1808c7c47: e8 34 06 f5 ff              	callq	0x180818280 <UnityMain+0x2de6b0>
1808c7c4c: 48 83 7d a7 00              	cmpq	$0x0, -0x59(%rbp)
1808c7c51: 74 18                       	je	0x1808c7c6b <UnityMain+0x38e09b>
1808c7c53: 48 8b 45 8f                 	movq	-0x71(%rbp), %rax
1808c7c57: 48 8d 4d 97                 	leaq	-0x69(%rbp), %rcx
1808c7c5b: 48 8b 15 ae 72 16 01        	movq	0x11672ae(%rip), %rdx   # 0x181a2ef10
1808c7c62: 48 85 c0                    	testq	%rax, %rax
1808c7c65: 48 0f 45 c8                 	cmovneq	%rax, %rcx
1808c7c69: ff d2                       	callq	*%rdx
1808c7c6b: 48 8d 4d 8f                 	leaq	-0x71(%rbp), %rcx
1808c7c6f: e8 7c d6 7c ff              	callq	0x1800952f0 <.text+0x942f0>
1808c7c74: 48 8b 45 77                 	movq	0x77(%rbp), %rax
1808c7c78: 48 8d 55 b7                 	leaq	-0x49(%rbp), %rdx
1808c7c7c: 48 85 c0                    	testq	%rax, %rax
1808c7c7f: 41 8b cd                    	movl	%r13d, %ecx
1808c7c82: 48 0f 45 d0                 	cmovneq	%rax, %rdx
1808c7c86: ff 15 1c 6c 16 01           	callq	*0x1166c1c(%rip)        # 0x181a2e8a8 ; mono_unity_runtime_set_main_args
1808c7c8c: 49 8b 0c 24                 	movq	(%r12), %rcx
1808c7c90: 48 8b 05 b1 71 16 01        	movq	0x11671b1(%rip), %rax   # 0x181a2ee48 ; mono_unity_set_data_dir
1808c7c97: 48 85 c9                    	testq	%rcx, %rcx
1808c7c9a: 75 05                       	jne	0x1808c7ca1 <UnityMain+0x38e0d1>
1808c7c9c: 49 8d 4c 24 08              	leaq	0x8(%r12), %rcx
1808c7ca1: ff d0                       	callq	*%rax
1808c7ca3: e8 a8 5c 01 00              	callq	0x1808dd950 <UnityMain+0x3a3d80>
1808c7ca8: 48 8b 05 09 6b 16 01        	movq	0x1166b09(%rip), %rax   # 0x181a2e7b8 ; mono_jit_init_version
1808c7caf: 48 8d 15 aa c3 dd 00        	leaq	0xddc3aa(%rip), %rdx    # 0x1816a4060
1808c7cb6: 48 8d 0d b3 c3 dd 00        	leaq	0xddc3b3(%rip), %rcx    # 0x1816a4070
1808c7cbd: ff d0                       	callq	*%rax
1808c7cbf: 48 8b d8                    	movq	%rax, %rbx
1808c7cc2: 48 85 c0                    	testq	%rax, %rax
1808c7cc5: 75 20                       	jne	0x1808c7ce7 <UnityMain+0x38e117>
1808c7cc7: 48 8d 4d bf                 	leaq	-0x41(%rbp), %rcx
1808c7ccb: e8 20 d6 7c ff              	callq	0x1800952f0 <.text+0x942f0>
1808c7cd0: 48 8b cf                    	movq	%rdi, %rcx
1808c7cd3: e8 18 d6 7c ff              	callq	0x1800952f0 <.text+0x942f0>
1808c7cd8: 49 8b cc                    	movq	%r12, %rcx
1808c7cdb: e8 10 d6 7c ff              	callq	0x1800952f0 <.text+0x942f0>
1808c7ce0: 32 c0                       	xorb	%al, %al
1808c7ce2: e9 c0 02 00 00              	jmp	0x1808c7fa7 <UnityMain+0x38e3d7>
1808c7ce7: 33 c9                       	xorl	%ecx, %ecx
1808c7ce9: ff 15 d1 70 16 01           	callq	*0x11670d1(%rip)        # 0x181a2edc0 ; mono_config_parse
1808c7cef: 48 8b 3d a2 6d 16 01        	movq	0x1166da2(%rip), %rdi   # 0x181a2ea98 ; mono_thread_set_main
1808c7cf6: 48 8d 4c 24 30              	leaq	0x30(%rsp), %rcx
1808c7cfb: e8 a0 9e 01 00              	callq	0x1808e1ba0 <UnityMain+0x3a7fd0>
1808c7d00: 48 8d 55 77                 	leaq	0x77(%rbp), %rdx
1808c7d04: 33 c9                       	xorl	%ecx, %ecx
1808c7d06: 4c 8b 00                    	movq	(%rax), %r8
1808c7d09: ff 15 29 73 16 01           	callq	*0x1167329(%rip)        # 0x181a2f038 ; mono_gc_wbarrier_set_field
1808c7d0f: 48 8b 4d 77                 	movq	0x77(%rbp), %rcx
1808c7d13: ff d7                       	callq	*%rdi
1808c7d15: 48 8b 05 54 70 16 01        	movq	0x1167054(%rip), %rax   # 0x181a2ed70 ; mono_unity_domain_set_config
1808c7d1c: 48 8d 4d e7                 	leaq	-0x19(%rbp), %rcx
1808c7d20: 48 89 45 77                 	movq	%rax, 0x77(%rbp)
1808c7d24: e8 07 05 f5 ff              	callq	0x180818230 <UnityMain+0x2de660>
1808c7d29: 4c 8b f8                    	movq	%rax, %r15
1808c7d2c: 49 8b f6                    	movq	%r14, %rsi
1808c7d2f: 49 8b fe                    	movq	%r14, %rdi
1808c7d32: 8b 48 20                    	movl	0x20(%rax), %ecx
1808c7d35: 4c 89 74 24 30              	movq	%r14, 0x30(%rsp)
1808c7d3a: 4c 89 74 24 48              	movq	%r14, 0x48(%rsp)
1808c7d3f: 89 4d 87                    	movl	%ecx, -0x79(%rbp)
1808c7d42: c6 44 24 38 00              	movb	$0x0, 0x38(%rsp)
1808c7d47: 48 8b 50 18                 	movq	0x18(%rax), %rdx
1808c7d4b: 48 83 c2 07                 	addq	$0x7, %rdx
1808c7d4f: 48 83 fa 0f                 	cmpq	$0xf, %rdx
1808c7d53: 72 14                       	jb	0x1808c7d69 <UnityMain+0x38e199>
1808c7d55: 48 8d 4c 24 30              	leaq	0x30(%rsp), %rcx
1808c7d5a: e8 11 bd 7f ff              	callq	0x1800c3a70 <.text+0xc2a70>
1808c7d5f: 48 8b 7c 24 48              	movq	0x48(%rsp), %rdi
1808c7d64: 48 8b 74 24 30              	movq	0x30(%rsp), %rsi
1808c7d69: 48 8d 44 24 30              	leaq	0x30(%rsp), %rax
1808c7d6e: 41 bd 0f 00 00 00           	movl	$0xf, %r13d
1808c7d74: 49 3b c7                    	cmpq	%r15, %rax
1808c7d77: 0f 84 ee 00 00 00           	je	0x1808c7e6b <UnityMain+0x38e29b>
1808c7d7d: 49 83 7f 08 00              	cmpq	$0x0, 0x8(%r15)
1808c7d82: 4d 8d 67 08                 	leaq	0x8(%r15), %r12
1808c7d86: 77 2b                       	ja	0x1808c7db3 <UnityMain+0x38e1e3>
1808c7d88: 49 83 3f 00                 	cmpq	$0x0, (%r15)
1808c7d8c: 74 25                       	je	0x1808c7db3 <UnityMain+0x38e1e3>
1808c7d8e: 49 8b 7f 18                 	movq	0x18(%r15), %rdi
1808c7d92: 48 8d 4c 24 30              	leaq	0x30(%rsp), %rcx
1808c7d97: 49 8b 37                    	movq	(%r15), %rsi
1808c7d9a: e8 51 d5 7c ff              	callq	0x1800952f0 <.text+0x942f0>
1808c7d9f: 48 89 74 24 30              	movq	%rsi, 0x30(%rsp)
1808c7da4: 48 89 7c 24 48              	movq	%rdi, 0x48(%rsp)
1808c7da9: 4c 89 74 24 38              	movq	%r14, 0x38(%rsp)
1808c7dae: e9 b4 00 00 00              	jmp	0x1808c7e67 <UnityMain+0x38e297>
1808c7db3: 49 8b 07                    	movq	(%r15), %rax
1808c7db6: 4c 8d 74 24 38              	leaq	0x38(%rsp), %r14
1808c7dbb: 4d 8b 7f 18                 	movq	0x18(%r15), %r15
1808c7dbf: 48 85 c0                    	testq	%rax, %rax
1808c7dc2: 4c 0f 45 e0                 	cmovneq	%rax, %r12
1808c7dc6: 48 85 f6                    	testq	%rsi, %rsi
1808c7dc9: 4c 0f 45 f6                 	cmovneq	%rsi, %r14
1808c7dcd: 4d 3b e6                    	cmpq	%r14, %r12
1808c7dd0: 72 28                       	jb	0x1808c7dfa <UnityMain+0x38e22a>
1808c7dd2: 4a 8d 04 37                 	leaq	(%rdi,%r14), %rax
1808c7dd6: 4c 3b e0                    	cmpq	%rax, %r12
1808c7dd9: 73 1f                       	jae	0x1808c7dfa <UnityMain+0x38e22a>
1808c7ddb: 4c 3b ff                    	cmpq	%rdi, %r15
1808c7dde: 4c 0f 47 ff                 	cmovaq	%rdi, %r15
1808c7de2: 49 8b ff                    	movq	%r15, %rdi
1808c7de5: 4d 3b f4                    	cmpq	%r12, %r14
1808c7de8: 74 6e                       	je	0x1808c7e58 <UnityMain+0x38e288>
1808c7dea: 4d 8b c7                    	movq	%r15, %r8
1808c7ded: 49 8b d4                    	movq	%r12, %rdx
1808c7df0: 49 8b ce                    	movq	%r14, %rcx
1808c7df3: e8 88 85 ca 00              	callq	0x181570380 <UnityMain+0x10367b0>
1808c7df8: eb 5e                       	jmp	0x1808c7e58 <UnityMain+0x38e288>
1808c7dfa: 48 8b 44 24 38              	movq	0x38(%rsp), %rax
1808c7dff: 48 85 c0                    	testq	%rax, %rax
1808c7e02: 75 05                       	jne	0x1808c7e09 <UnityMain+0x38e239>
1808c7e04: 48 85 f6                    	testq	%rsi, %rsi
1808c7e07: 75 16                       	jne	0x1808c7e1f <UnityMain+0x38e24f>
1808c7e09: 48 85 f6                    	testq	%rsi, %rsi
1808c7e0c: 75 05                       	jne	0x1808c7e13 <UnityMain+0x38e243>
1808c7e0e: 49 8b fd                    	movq	%r13, %rdi
1808c7e11: eb 07                       	jmp	0x1808c7e1a <UnityMain+0x38e24a>
1808c7e13: 48 85 c0                    	testq	%rax, %rax
1808c7e16: 48 0f 45 f8                 	cmovneq	%rax, %rdi
1808c7e1a: 4c 3b ff                    	cmpq	%rdi, %r15
1808c7e1d: 76 28                       	jbe	0x1808c7e47 <UnityMain+0x38e277>
1808c7e1f: 48 8d 4c 24 30              	leaq	0x30(%rsp), %rcx
1808c7e24: e8 c7 d4 7c ff              	callq	0x1800952f0 <.text+0x942f0>
1808c7e29: 49 8b d7                    	movq	%r15, %rdx
1808c7e2c: 48 8d 4c 24 30              	leaq	0x30(%rsp), %rcx
1808c7e31: e8 ea d2 7c ff              	callq	0x180095120 <.text+0x94120>
1808c7e36: 48 8b 44 24 30              	movq	0x30(%rsp), %rax
1808c7e3b: 4c 8d 74 24 38              	leaq	0x38(%rsp), %r14
1808c7e40: 48 85 c0                    	testq	%rax, %rax
1808c7e43: 4c 0f 45 f0                 	cmovneq	%rax, %r14
1808c7e47: 4d 8b c7                    	movq	%r15, %r8
1808c7e4a: 49 8b d4                    	movq	%r12, %rdx
1808c7e4d: 49 8b ce                    	movq	%r14, %rcx
1808c7e50: e8 2b 85 ca 00              	callq	0x181570380 <UnityMain+0x10367b0>
1808c7e55: 49 8b ff                    	movq	%r15, %rdi
1808c7e58: 43 c6 04 3e 00              	movb	$0x0, (%r14,%r15)
1808c7e5d: 48 8b 74 24 30              	movq	0x30(%rsp), %rsi
1808c7e62: 4c 89 7c 24 48              	movq	%r15, 0x48(%rsp)
1808c7e67: 4c 8b 65 67                 	movq	0x67(%rbp), %r12
1808c7e6b: 48 85 f6                    	testq	%rsi, %rsi
1808c7e6e: 4c 8d 74 24 38              	leaq	0x38(%rsp), %r14
1808c7e73: 4c 8d 7f 07                 	leaq	0x7(%rdi), %r15
1808c7e77: 4c 0f 45 f6                 	cmovneq	%rsi, %r14
1808c7e7b: 74 0f                       	je	0x1808c7e8c <UnityMain+0x38e2bc>
1808c7e7d: 48 8b 44 24 38              	movq	0x38(%rsp), %rax
1808c7e82: 4c 8b ef                    	movq	%rdi, %r13
1808c7e85: 48 85 c0                    	testq	%rax, %rax
1808c7e88: 4c 0f 45 e8                 	cmovneq	%rax, %r13
1808c7e8c: 4d 3b fd                    	cmpq	%r13, %r15
1808c7e8f: 76 21                       	jbe	0x1808c7eb2 <UnityMain+0x38e2e2>
1808c7e91: 4a 8d 04 6d 00 00 00 00     	leaq	(,%r13,2), %rax
1808c7e99: 49 8b d7                    	movq	%r15, %rdx
1808c7e9c: 4c 3b f8                    	cmpq	%rax, %r15
1808c7e9f: 48 8d 4c 24 30              	leaq	0x30(%rsp), %rcx
1808c7ea4: 48 0f 42 d0                 	cmovbq	%rax, %rdx
1808c7ea8: e8 c3 bb 7f ff              	callq	0x1800c3a70 <.text+0xc2a70>
1808c7ead: 48 8b 74 24 30              	movq	0x30(%rsp), %rsi
1808c7eb2: 48 85 f6                    	testq	%rsi, %rsi
1808c7eb5: 4c 89 7c 24 48              	movq	%r15, 0x48(%rsp)
1808c7eba: 4c 8d 05 c7 c1 dd 00        	leaq	0xddc1c7(%rip), %r8     # 0x1816a4088
1808c7ec1: 48 8d 44 24 38              	leaq	0x38(%rsp), %rax
1808c7ec6: 49 8b c8                    	movq	%r8, %rcx
1808c7ec9: 48 0f 45 c6                 	cmovneq	%rsi, %rax
1808c7ecd: 48 8d 54 24 38              	leaq	0x38(%rsp), %rdx
1808c7ed2: 42 c6 04 38 00              	movb	$0x0, (%rax,%r15)
1808c7ed7: 48 8b 44 24 30              	movq	0x30(%rsp), %rax
1808c7edc: 48 85 c0                    	testq	%rax, %rax
1808c7edf: 48 0f 45 d0                 	cmovneq	%rax, %rdx
1808c7ee3: 4d 3b c6                    	cmpq	%r14, %r8
1808c7ee6: 72 12                       	jb	0x1808c7efa <UnityMain+0x38e32a>
1808c7ee8: 49 8d 04 3e                 	leaq	(%r14,%rdi), %rax
1808c7eec: 4c 3b c0                    	cmpq	%rax, %r8
1808c7eef: 73 09                       	jae	0x1808c7efa <UnityMain+0x38e32a>
1808c7ef1: 48 8b ca                    	movq	%rdx, %rcx
1808c7ef4: 49 2b ce                    	subq	%r14, %rcx
1808c7ef7: 49 03 c8                    	addq	%r8, %rcx
1808c7efa: 8b 01                       	movl	(%rcx), %eax
1808c7efc: 89 04 3a                    	movl	%eax, (%rdx,%rdi)
1808c7eff: 0f b7 41 04                 	movzwl	0x4(%rcx), %eax
1808c7f03: 66 89 44 3a 04              	movw	%ax, 0x4(%rdx,%rdi)
1808c7f08: 0f b6 41 06                 	movzbl	0x6(%rcx), %eax
1808c7f0c: 48 8d 4d 8f                 	leaq	-0x71(%rbp), %rcx
1808c7f10: 88 44 3a 06                 	movb	%al, 0x6(%rdx,%rdi)
1808c7f14: 48 8d 7c 24 38              	leaq	0x38(%rsp), %rdi
1808c7f19: 48 8b 44 24 30              	movq	0x30(%rsp), %rax
1808c7f1e: 48 85 c0                    	testq	%rax, %rax
1808c7f21: 48 0f 45 f8                 	cmovneq	%rax, %rdi
1808c7f25: e8 d6 02 f5 ff              	callq	0x180818200 <UnityMain+0x2de630>
1808c7f2a: 48 8b 10                    	movq	(%rax), %rdx
1808c7f2d: 48 85 d2                    	testq	%rdx, %rdx
1808c7f30: 75 04                       	jne	0x1808c7f36 <UnityMain+0x38e366>
1808c7f32: 48 8d 50 08                 	leaq	0x8(%rax), %rdx
1808c7f36: 4c 8b c7                    	movq	%rdi, %r8
1808c7f39: 48 8b cb                    	movq	%rbx, %rcx
1808c7f3c: ff 55 77                    	callq	*0x77(%rbp)
1808c7f3f: 48 8d 4d 8f                 	leaq	-0x71(%rbp), %rcx
1808c7f43: e8 a8 d3 7c ff              	callq	0x1800952f0 <.text+0x942f0>
1808c7f48: 48 8d 4c 24 30              	leaq	0x30(%rsp), %rcx
1808c7f4d: e8 9e d3 7c ff              	callq	0x1800952f0 <.text+0x942f0>
1808c7f52: 48 8d 4d e7                 	leaq	-0x19(%rbp), %rcx
1808c7f56: e8 95 d3 7c ff              	callq	0x1800952f0 <.text+0x942f0>
1808c7f5b: 48 8d 0d c2 66 d2 00        	leaq	0xd266c2(%rip), %rcx    # 0x1815ee624
1808c7f62: ff 15 48 6c 16 01           	callq	*0x1166c48(%rip)        # 0x181a2ebb0 ; mono_unity_set_embeddinghostname
1808c7f68: 33 c9                       	xorl	%ecx, %ecx
1808c7f6a: ff 15 38 6b 16 01           	callq	*0x1166b38(%rip)        # 0x181a2eaa8 ; mono_runtime_unhandled_exception_policy_set
1808c7f70: e8 8b ba fa ff              	callq	0x180873a00 <UnityMain+0x339e30>
1808c7f75: e8 f6 83 00 00              	callq	0x1808d0370 <UnityMain+0x3967a0>
1808c7f7a: e8 71 ab d6 ff              	callq	0x180632af0 <UnityMain+0xf8f20>
1808c7f7f: 48 8d 88 98 cd 00 00        	leaq	0xcd98(%rax), %rcx
1808c7f86: e8 25 2a 9f ff              	callq	0x1802ba9b0 <.text+0x2b99b0>
1808c7f8b: 48 8d 4d bf                 	leaq	-0x41(%rbp), %rcx
1808c7f8f: e8 5c d3 7c ff              	callq	0x1800952f0 <.text+0x942f0>
1808c7f94: 48 8b 4d 5f                 	movq	0x5f(%rbp), %rcx
1808c7f98: e8 53 d3 7c ff              	callq	0x1800952f0 <.text+0x942f0>
1808c7f9d: 49 8b cc                    	movq	%r12, %rcx
1808c7fa0: e8 4b d3 7c ff              	callq	0x1800952f0 <.text+0x942f0>
1808c7fa5: b0 01                       	movb	$0x1, %al
1808c7fa7: 48 8b 9c 24 20 01 00 00     	movq	0x120(%rsp), %rbx
1808c7faf: 48 81 c4 e0 00 00 00        	addq	$0xe0, %rsp
1808c7fb6: 41 5f                       	popq	%r15
1808c7fb8: 41 5e                       	popq	%r14
1808c7fba: 41 5d                       	popq	%r13
1808c7fbc: 41 5c                       	popq	%r12
1808c7fbe: 5f                          	popq	%rdi
1808c7fbf: 5e                          	popq	%rsi
1808c7fc0: 5d                          	popq	%rbp
1808c7fc1: c3                          	retq
