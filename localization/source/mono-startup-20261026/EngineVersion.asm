
/Users/antonkrutov/Desktop/Forest/localization/probes/ru-20261026-39/game/UnityPlayer.dll:	file format coff-x86-64

Disassembly of section .text:

0000000180539bd0 <UnityMain>:
18076dd30: 48 83 ec 28                 	subq	$0x28, %rsp
18076dd34: 80 3d 05 7b 2b 01 00        	cmpb	$0x0, 0x12b7b05(%rip)   # 0x181a25840
18076dd3b: 0f 85 60 01 00 00           	jne	0x18076dea1 <UnityMain+0x2342d1>
18076dd41: e8 ea 85 79 00              	callq	0x180f06330 <UnityMain+0x9cc760>
18076dd46: 48 8b d0                    	movq	%rax, %rdx
18076dd49: 48 8d 0d 10 2d f2 00        	leaq	0xf22d10(%rip), %rcx    # 0x181690a60
18076dd50: e8 fb ed 76 00              	callq	0x180edcb50 <UnityMain+0x9a2f80>
18076dd55: e8 26 8c 13 00              	callq	0x1808a6980 <UnityMain+0x36cdb0>
18076dd5a: 48 85 c0                    	testq	%rax, %rax
18076dd5d: 75 05                       	jne	0x18076dd64 <UnityMain+0x234194>
18076dd5f: 48 83 c4 28                 	addq	$0x28, %rsp
18076dd63: c3                          	retq


/Users/antonkrutov/Desktop/Forest/localization/probes/ru-20261026-39/game/UnityPlayer.dll:	file format coff-x86-64

Disassembly of section .text:

0000000180539bd0 <UnityMain>:
18076dd64: 48 89 5c 24 30              	movq	%rbx, 0x30(%rsp)
18076dd69: 48 89 7c 24 20              	movq	%rdi, 0x20(%rsp)
18076dd6e: e8 dd 8b 13 00              	callq	0x1808a6950 <UnityMain+0x36cd80>
18076dd73: e8 38 15 08 00              	callq	0x1807ef2b0 <UnityMain+0x2b56e0>
18076dd78: e8 c3 d5 06 00              	callq	0x1807db340 <UnityMain+0x2a1770>
18076dd7d: 48 8b 0d 3c 30 27 01        	movq	0x127303c(%rip), %rcx   # 0x1819e0dc0
18076dd84: e8 47 2d e2 ff              	callq	0x180590ad0 <UnityMain+0x56f00>
18076dd89: e8 12 9f e1 ff              	callq	0x180587ca0 <UnityMain+0x4e0d0>
18076dd8e: 48 8b c8                    	movq	%rax, %rcx
18076dd91: e8 ea c5 e1 ff              	callq	0x18058a380 <UnityMain+0x507b0>
18076dd96: e8 f5 08 01 00              	callq	0x18077e690 <UnityMain+0x244ac0>
18076dd9b: e8 70 90 06 00              	callq	0x1807d6e10 <UnityMain+0x29d240>
18076dda0: e8 db b5 fc ff              	callq	0x180739380 <UnityMain+0x1ff7b0>
18076dda5: e8 46 01 f8 ff              	callq	0x1806edef0 <UnityMain+0x1b4320>
18076ddaa: e8 11 54 79 00              	callq	0x180f031c0 <UnityMain+0x9c95f0>
18076ddaf: e8 fc a9 e7 ff              	callq	0x1805e87b0 <UnityMain+0xaebe0>
18076ddb4: 33 db                       	xorl	%ebx, %ebx
18076ddb6: 48 85 c0                    	testq	%rax, %rax
18076ddb9: 74 5c                       	je	0x18076de17 <UnityMain+0x234247>
18076ddbb: e8 30 4d ec ff              	callq	0x180632af0 <UnityMain+0xf8f20>
18076ddc0: 44 8b 80 80 50 02 00        	movl	0x25080(%rax), %r8d
18076ddc7: 48 8d 3d 82 ed ff ff        	leaq	-0x127e(%rip), %rdi     # 0x18076cb50 <UnityMain+0x232f80>
18076ddce: 48 05 80 44 02 00           	addq	$0x24480, %rax          # imm = 0x24480
18076ddd4: 8b cb                       	movl	%ebx, %ecx
18076ddd6: 45 85 c0                    	testl	%r8d, %r8d
18076ddd9: 74 1b                       	je	0x18076ddf6 <UnityMain+0x234226>
18076dddb: 0f 1f 44 00 00              	nopl	(%rax,%rax)
18076dde0: 48 39 38                    	cmpq	%rdi, (%rax)
18076dde3: 75 06                       	jne	0x18076ddeb <UnityMain+0x23421b>
18076dde5: 48 39 58 08                 	cmpq	%rbx, 0x8(%rax)
18076dde9: 74 1f                       	je	0x18076de0a <UnityMain+0x23423a>
18076ddeb: ff c1                       	incl	%ecx
18076dded: 48 83 c0 18                 	addq	$0x18, %rax
18076ddf1: 41 3b c8                    	cmpl	%r8d, %ecx
18076ddf4: 72 ea                       	jb	0x18076dde0 <UnityMain+0x234210>
18076ddf6: e8 f5 4c ec ff              	callq	0x180632af0 <UnityMain+0xf8f20>
18076ddfb: 48 8b d7                    	movq	%rdi, %rdx
18076ddfe: 48 8d 88 80 44 02 00        	leaq	0x24480(%rax), %rcx
18076de05: e8 06 63 94 ff              	callq	0x1800b4110 <.text+0xb3110>
18076de0a: e8 a1 a9 e7 ff              	callq	0x1805e87b0 <UnityMain+0xaebe0>
18076de0f: 48 8b c8                    	movq	%rax, %rcx
18076de12: e8 b9 d6 e7 ff              	callq	0x1805eb4d0 <UnityMain+0xb1900>
18076de17: e8 d4 4c ec ff              	callq	0x180632af0 <UnityMain+0xf8f20>
18076de1c: 8b 88 68 44 02 00           	movl	0x24468(%rax), %ecx
18076de22: 48 8d 3d 07 ed ff ff        	leaq	-0x12f9(%rip), %rdi     # 0x18076cb30 <UnityMain+0x232f60>
18076de29: 48 05 68 38 02 00           	addq	$0x23868, %rax          # imm = 0x23868
18076de2f: 85 c9                       	testl	%ecx, %ecx
18076de31: 74 16                       	je	0x18076de49 <UnityMain+0x234279>
18076de33: 48 39 38                    	cmpq	%rdi, (%rax)
18076de36: 75 07                       	jne	0x18076de3f <UnityMain+0x23426f>
18076de38: 48 83 78 08 00              	cmpq	$0x0, 0x8(%rax)
18076de3d: 74 1e                       	je	0x18076de5d <UnityMain+0x23428d>
18076de3f: ff c3                       	incl	%ebx
18076de41: 48 83 c0 18                 	addq	$0x18, %rax
18076de45: 3b d9                       	cmpl	%ecx, %ebx
18076de47: 72 ea                       	jb	0x18076de33 <UnityMain+0x234263>
18076de49: e8 a2 4c ec ff              	callq	0x180632af0 <UnityMain+0xf8f20>
18076de4e: 48 8b d7                    	movq	%rdi, %rdx
18076de51: 48 8d 88 68 38 02 00        	leaq	0x23868(%rax), %rcx
18076de58: e8 b3 62 94 ff              	callq	0x1800b4110 <.text+0xb3110>
18076de5d: c6 05 dc 79 2b 01 01        	movb	$0x1, 0x12b79dc(%rip)   # 0x181a25840
18076de64: e8 f7 20 13 00              	callq	0x18089ff60 <UnityMain+0x366390>
18076de69: 48 8b f8                    	movq	%rax, %rdi
18076de6c: 48 8b 08                    	movq	(%rax), %rcx
18076de6f: 48 8b 99 c8 00 00 00        	movq	0xc8(%rcx), %rbx
18076de76: e8 85 86 fe ff              	callq	0x180756500 <UnityMain+0x21c930>
18076de7b: 83 f8 01                    	cmpl	$0x1, %eax
18076de7e: 48 8b cf                    	movq	%rdi, %rcx
18076de81: 0f 94 c2                    	sete	%dl
18076de84: ff d3                       	callq	*%rbx
18076de86: e8 65 4c ec ff              	callq	0x180632af0 <UnityMain+0xf8f20>
18076de8b: 48 8d 88 e0 f1 00 00        	leaq	0xf1e0(%rax), %rcx
18076de92: e8 19 cb b4 ff              	callq	0x1802ba9b0 <.text+0x2b99b0>
18076de97: 48 8b 7c 24 20              	movq	0x20(%rsp), %rdi
18076de9c: 48 8b 5c 24 30              	movq	0x30(%rsp), %rbx


/Users/antonkrutov/Desktop/Forest/localization/probes/ru-20261026-39/game/UnityPlayer.dll:	file format coff-x86-64

Disassembly of section .text:

0000000180539bd0 <UnityMain>:
18076dea1: b0 01                       	movb	$0x1, %al
18076dea3: 48 83 c4 28                 	addq	$0x28, %rsp
18076dea7: c3                          	retq
