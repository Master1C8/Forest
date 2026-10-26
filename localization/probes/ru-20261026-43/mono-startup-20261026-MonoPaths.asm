
/Users/antonkrutov/Desktop/Forest/localization/probes/ru-20261026-39/game/UnityPlayer.dll:	file format coff-x86-64

Disassembly of section .text:

0000000180539bd0 <UnityMain>:
1808ca8b0: 48 8b c4                    	movq	%rsp, %rax
1808ca8b3: 55                          	pushq	%rbp
1808ca8b4: 53                          	pushq	%rbx
1808ca8b5: 41 56                       	pushq	%r14
1808ca8b7: 48 8d 68 a1                 	leaq	-0x5f(%rax), %rbp
1808ca8bb: 48 81 ec a0 00 00 00        	subq	$0xa0, %rsp


/Users/antonkrutov/Desktop/Forest/localization/probes/ru-20261026-39/game/UnityPlayer.dll:	file format coff-x86-64

Disassembly of section .text:

0000000180539bd0 <UnityMain>:
1808ca8c2: 48 89 70 08                 	movq	%rsi, 0x8(%rax)
1808ca8c6: 4c 8b f1                    	movq	%rcx, %r14
1808ca8c9: 48 89 78 10                 	movq	%rdi, 0x10(%rax)
1808ca8cd: 48 8b f2                    	movq	%rdx, %rsi
1808ca8d0: 4c 89 60 18                 	movq	%r12, 0x18(%rax)
1808ca8d4: 45 33 e4                    	xorl	%r12d, %r12d
1808ca8d7: 41 8b dc                    	movl	%r12d, %ebx
1808ca8da: 48 39 59 10                 	cmpq	%rbx, 0x10(%rcx)
1808ca8de: 76 31                       	jbe	0x1808ca911 <UnityMain+0x390d41>
1808ca8e0: 41 8b fc                    	movl	%r12d, %edi
1808ca8e3: 49 8b 06                    	movq	(%r14), %rax
1808ca8e6: 4c 8b 04 07                 	movq	(%rdi,%rax), %r8
1808ca8ea: 4d 85 c0                    	testq	%r8, %r8
1808ca8ed: 75 07                       	jne	0x1808ca8f6 <UnityMain+0x390d26>
1808ca8ef: 4c 8d 40 08                 	leaq	0x8(%rax), %r8
1808ca8f3: 4c 03 c7                    	addq	%rdi, %r8
1808ca8f6: 8b d3                       	movl	%ebx, %edx
1808ca8f8: 48 8d 0d e1 96 dd 00        	leaq	0xdd96e1(%rip), %rcx    # 0x1816a3fe0
1808ca8ff: e8 4c 22 61 00              	callq	0x180edcb50 <UnityMain+0x9a2f80>
1808ca904: 48 ff c3                    	incq	%rbx
1808ca907: 48 83 c7 28                 	addq	$0x28, %rdi
1808ca90b: 49 3b 5e 10                 	cmpq	0x10(%r14), %rbx
1808ca90f: 72 d2                       	jb	0x1808ca8e3 <UnityMain+0x390d13>
1808ca911: 48 8b 16                    	movq	(%rsi), %rdx
1808ca914: 48 85 d2                    	testq	%rdx, %rdx
1808ca917: 75 04                       	jne	0x1808ca91d <UnityMain+0x390d4d>
1808ca919: 48 8d 56 08                 	leaq	0x8(%rsi), %rdx
1808ca91d: 48 8d 0d d4 96 dd 00        	leaq	0xdd96d4(%rip), %rcx    # 0x1816a3ff8
1808ca924: 4c 89 bc 24 d8 00 00 00     	movq	%r15, 0xd8(%rsp)
1808ca92c: e8 1f 22 61 00              	callq	0x180edcb50 <UnityMain+0x9a2f80>
1808ca931: 49 8b 1e                    	movq	(%r14), %rbx
1808ca934: 8b 43 20                    	movl	0x20(%rbx), %eax
1808ca937: 89 45 0f                    	movl	%eax, 0xf(%rbp)
1808ca93a: 48 8d 45 ef                 	leaq	-0x11(%rbp), %rax
1808ca93e: 4c 89 65 ef                 	movq	%r12, -0x11(%rbp)
1808ca942: 4c 89 65 07                 	movq	%r12, 0x7(%rbp)
1808ca946: 44 88 65 f7                 	movb	%r12b, -0x9(%rbp)
1808ca94a: 48 3b c3                    	cmpq	%rbx, %rax
1808ca94d: 0f 84 ba 00 00 00           	je	0x1808caa0d <UnityMain+0x390e3d>
1808ca953: 4c 39 63 08                 	cmpq	%r12, 0x8(%rbx)
1808ca957: 48 8d 7b 08                 	leaq	0x8(%rbx), %rdi
1808ca95b: 77 26                       	ja	0x1808ca983 <UnityMain+0x390db3>
1808ca95d: 4c 39 23                    	cmpq	%r12, (%rbx)
1808ca960: 74 21                       	je	0x1808ca983 <UnityMain+0x390db3>
1808ca962: 48 8b 7b 18                 	movq	0x18(%rbx), %rdi
1808ca966: 48 8d 4d ef                 	leaq	-0x11(%rbp), %rcx
1808ca96a: 48 8b 1b                    	movq	(%rbx), %rbx
1808ca96d: e8 7e a9 7c ff              	callq	0x1800952f0 <.text+0x942f0>
1808ca972: 48 89 5d ef                 	movq	%rbx, -0x11(%rbp)
1808ca976: 48 89 7d 07                 	movq	%rdi, 0x7(%rbp)
1808ca97a: 4c 89 65 f7                 	movq	%r12, -0x9(%rbp)
1808ca97e: e9 8a 00 00 00              	jmp	0x1808caa0d <UnityMain+0x390e3d>
1808ca983: 48 8b 03                    	movq	(%rbx), %rax
1808ca986: 4c 8d 7d f7                 	leaq	-0x9(%rbp), %r15
1808ca98a: 48 8b 5b 18                 	movq	0x18(%rbx), %rbx
1808ca98e: 48 85 c0                    	testq	%rax, %rax
1808ca991: 48 0f 45 f8                 	cmovneq	%rax, %rdi
1808ca995: 48 8d 45 f7                 	leaq	-0x9(%rbp), %rax
1808ca999: 48 3b f8                    	cmpq	%rax, %rdi
1808ca99c: 72 2f                       	jb	0x1808ca9cd <UnityMain+0x390dfd>
1808ca99e: 48 8d 45 f7                 	leaq	-0x9(%rbp), %rax
1808ca9a2: 48 3b f8                    	cmpq	%rax, %rdi
1808ca9a5: 73 26                       	jae	0x1808ca9cd <UnityMain+0x390dfd>
1808ca9a7: 48 85 db                    	testq	%rbx, %rbx
1808ca9aa: 48 8d 45 f7                 	leaq	-0x9(%rbp), %rax
1808ca9ae: 49 0f 45 dc                 	cmovneq	%r12, %rbx
1808ca9b2: 48 3b c7                    	cmpq	%rdi, %rax
1808ca9b5: 74 0f                       	je	0x1808ca9c6 <UnityMain+0x390df6>
1808ca9b7: 4c 8b c3                    	movq	%rbx, %r8
1808ca9ba: 48 8d 4d f7                 	leaq	-0x9(%rbp), %rcx
1808ca9be: 48 8b d7                    	movq	%rdi, %rdx
1808ca9c1: e8 ba 59 ca 00              	callq	0x181570380 <UnityMain+0x10367b0>
1808ca9c6: 44 88 64 1d f7              	movb	%r12b, -0x9(%rbp,%rbx)
1808ca9cb: eb 3c                       	jmp	0x1808caa09 <UnityMain+0x390e39>
1808ca9cd: 48 83 fb 0f                 	cmpq	$0xf, %rbx
1808ca9d1: 76 24                       	jbe	0x1808ca9f7 <UnityMain+0x390e27>
1808ca9d3: 48 8d 4d ef                 	leaq	-0x11(%rbp), %rcx
1808ca9d7: e8 14 a9 7c ff              	callq	0x1800952f0 <.text+0x942f0>
1808ca9dc: 48 8b d3                    	movq	%rbx, %rdx
1808ca9df: 48 8d 4d ef                 	leaq	-0x11(%rbp), %rcx
1808ca9e3: e8 38 a7 7c ff              	callq	0x180095120 <.text+0x94120>
1808ca9e8: 48 8b 45 ef                 	movq	-0x11(%rbp), %rax
1808ca9ec: 4c 8d 7d f7                 	leaq	-0x9(%rbp), %r15
1808ca9f0: 48 85 c0                    	testq	%rax, %rax
1808ca9f3: 4c 0f 45 f8                 	cmovneq	%rax, %r15
1808ca9f7: 4c 8b c3                    	movq	%rbx, %r8
1808ca9fa: 48 8b d7                    	movq	%rdi, %rdx
1808ca9fd: 49 8b cf                    	movq	%r15, %rcx
1808caa00: e8 7b 59 ca 00              	callq	0x181570380 <UnityMain+0x10367b0>
1808caa05: 45 88 24 1f                 	movb	%r12b, (%r15,%rbx)
1808caa09: 48 89 5d 07                 	movq	%rbx, 0x7(%rbp)
1808caa0d: 8b 46 20                    	movl	0x20(%rsi), %eax
1808caa10: 89 45 e7                    	movl	%eax, -0x19(%rbp)
1808caa13: 48 8d 45 c7                 	leaq	-0x39(%rbp), %rax
1808caa17: 4c 89 65 c7                 	movq	%r12, -0x39(%rbp)
1808caa1b: 4c 89 65 df                 	movq	%r12, -0x21(%rbp)
1808caa1f: 44 88 65 cf                 	movb	%r12b, -0x31(%rbp)
1808caa23: 48 3b c6                    	cmpq	%rsi, %rax
1808caa26: 0f 84 c1 00 00 00           	je	0x1808caaed <UnityMain+0x390f1d>
1808caa2c: 4c 39 66 08                 	cmpq	%r12, 0x8(%rsi)
1808caa30: 4c 8d 7e 08                 	leaq	0x8(%rsi), %r15
1808caa34: 77 2d                       	ja	0x1808caa63 <UnityMain+0x390e93>
1808caa36: 4c 39 26                    	cmpq	%r12, (%rsi)
1808caa39: 74 28                       	je	0x1808caa63 <UnityMain+0x390e93>
1808caa3b: 48 8b 7e 18                 	movq	0x18(%rsi), %rdi
1808caa3f: 48 8d 4d c7                 	leaq	-0x39(%rbp), %rcx
1808caa43: 48 8b 1e                    	movq	(%rsi), %rbx
1808caa46: e8 a5 a8 7c ff              	callq	0x1800952f0 <.text+0x942f0>
1808caa4b: 48 85 db                    	testq	%rbx, %rbx
1808caa4e: 48 89 7d df                 	movq	%rdi, -0x21(%rbp)
1808caa52: 4c 89 65 cf                 	movq	%r12, -0x31(%rbp)
1808caa56: 49 0f 44 df                 	cmoveq	%r15, %rbx
1808caa5a: 48 89 5d c7                 	movq	%rbx, -0x39(%rbp)
1808caa5e: e9 8a 00 00 00              	jmp	0x1808caaed <UnityMain+0x390f1d>
1808caa63: 48 8b 3e                    	movq	(%rsi), %rdi
1808caa66: 48 8d 45 cf                 	leaq	-0x31(%rbp), %rax
1808caa6a: 48 8b 5e 18                 	movq	0x18(%rsi), %rbx
1808caa6e: 48 85 ff                    	testq	%rdi, %rdi
1808caa71: 48 8d 75 cf                 	leaq	-0x31(%rbp), %rsi
1808caa75: 49 0f 44 ff                 	cmoveq	%r15, %rdi
1808caa79: 48 3b f8                    	cmpq	%rax, %rdi
1808caa7c: 72 2f                       	jb	0x1808caaad <UnityMain+0x390edd>
1808caa7e: 48 8d 45 cf                 	leaq	-0x31(%rbp), %rax
1808caa82: 48 3b f8                    	cmpq	%rax, %rdi
1808caa85: 73 26                       	jae	0x1808caaad <UnityMain+0x390edd>
1808caa87: 48 85 db                    	testq	%rbx, %rbx
1808caa8a: 48 8d 45 cf                 	leaq	-0x31(%rbp), %rax
1808caa8e: 49 0f 45 dc                 	cmovneq	%r12, %rbx
1808caa92: 48 3b c7                    	cmpq	%rdi, %rax
1808caa95: 74 0f                       	je	0x1808caaa6 <UnityMain+0x390ed6>
1808caa97: 4c 8b c3                    	movq	%rbx, %r8
1808caa9a: 48 8d 4d cf                 	leaq	-0x31(%rbp), %rcx
1808caa9e: 48 8b d7                    	movq	%rdi, %rdx
1808caaa1: e8 da 58 ca 00              	callq	0x181570380 <UnityMain+0x10367b0>
1808caaa6: 44 88 64 1d cf              	movb	%r12b, -0x31(%rbp,%rbx)
1808caaab: eb 3c                       	jmp	0x1808caae9 <UnityMain+0x390f19>
1808caaad: 48 83 fb 0f                 	cmpq	$0xf, %rbx
1808caab1: 76 24                       	jbe	0x1808caad7 <UnityMain+0x390f07>
1808caab3: 48 8d 4d c7                 	leaq	-0x39(%rbp), %rcx
1808caab7: e8 34 a8 7c ff              	callq	0x1800952f0 <.text+0x942f0>
1808caabc: 48 8b d3                    	movq	%rbx, %rdx
1808caabf: 48 8d 4d c7                 	leaq	-0x39(%rbp), %rcx
1808caac3: e8 58 a6 7c ff              	callq	0x180095120 <.text+0x94120>
1808caac8: 48 8b 45 c7                 	movq	-0x39(%rbp), %rax
1808caacc: 48 8d 75 cf                 	leaq	-0x31(%rbp), %rsi
1808caad0: 48 85 c0                    	testq	%rax, %rax
1808caad3: 48 0f 45 f0                 	cmovneq	%rax, %rsi
1808caad7: 4c 8b c3                    	movq	%rbx, %r8
1808caada: 48 8b d7                    	movq	%rdi, %rdx
1808caadd: 48 8b ce                    	movq	%rsi, %rcx
1808caae0: e8 9b 58 ca 00              	callq	0x181570380 <UnityMain+0x10367b0>
1808caae5: 44 88 24 1e                 	movb	%r12b, (%rsi,%rbx)
1808caae9: 48 89 5d df                 	movq	%rbx, -0x21(%rbp)
1808caaed: 48 8d 4d ef                 	leaq	-0x11(%rbp), %rcx
1808caaf1: e8 aa 69 f4 ff              	callq	0x1808114a0 <UnityMain+0x2d78d0>
1808caaf6: 48 8d 4d c7                 	leaq	-0x39(%rbp), %rcx
1808caafa: e8 a1 69 f4 ff              	callq	0x1808114a0 <UnityMain+0x2d78d0>
1808caaff: 48 8b 45 c7                 	movq	-0x39(%rbp), %rax
1808cab03: 48 8d 55 cf                 	leaq	-0x31(%rbp), %rdx
1808cab07: 4c 8b 05 ba 42 16 01        	movq	0x11642ba(%rip), %r8    # 0x181a2edc8 ; mono_set_dirs
1808cab0e: 48 8d 4d f7                 	leaq	-0x9(%rbp), %rcx
1808cab12: 48 85 c0                    	testq	%rax, %rax
1808cab15: 48 0f 45 d0                 	cmovneq	%rax, %rdx
1808cab19: 48 8b 45 ef                 	movq	-0x11(%rbp), %rax
1808cab1d: 48 85 c0                    	testq	%rax, %rax
1808cab20: 48 0f 45 c8                 	cmovneq	%rax, %rcx
1808cab24: 41 ff d0                    	callq	*%r8
1808cab27: 48 8b 1d 8a 40 16 01        	movq	0x116408a(%rip), %rbx   # 0x181a2ebb8 ; mono_set_assemblies_path_null_separated
1808cab2e: 48 8d 4d 17                 	leaq	0x17(%rbp), %rcx
1808cab32: 49 8b d6                    	movq	%r14, %rdx
1808cab35: e8 d6 a8 ff ff              	callq	0x1808c5410 <UnityMain+0x38b840>
1808cab3a: 4c 8b bc 24 d8 00 00 00     	movq	0xd8(%rsp), %r15
1808cab42: 4c 8b a4 24 d0 00 00 00     	movq	0xd0(%rsp), %r12
1808cab4a: 48 8b bc 24 c8 00 00 00     	movq	0xc8(%rsp), %rdi
1808cab52: 48 8b 08                    	movq	(%rax), %rcx
1808cab55: 48 8b b4 24 c0 00 00 00     	movq	0xc0(%rsp), %rsi
1808cab5d: 48 85 c9                    	testq	%rcx, %rcx
1808cab60: 75 04                       	jne	0x1808cab66 <UnityMain+0x390f96>


/Users/antonkrutov/Desktop/Forest/localization/probes/ru-20261026-39/game/UnityPlayer.dll:	file format coff-x86-64

Disassembly of section .text:

0000000180539bd0 <UnityMain>:
1808cab62: 48 8d 48 08                 	leaq	0x8(%rax), %rcx
1808cab66: ff d3                       	callq	*%rbx
1808cab68: 48 8d 4d 17                 	leaq	0x17(%rbp), %rcx
1808cab6c: e8 7f a7 7c ff              	callq	0x1800952f0 <.text+0x942f0>
1808cab71: 49 8b ce                    	movq	%r14, %rcx
1808cab74: e8 67 08 00 00              	callq	0x1808cb3e0 <UnityMain+0x391810>
1808cab79: 48 8d 4d c7                 	leaq	-0x39(%rbp), %rcx
1808cab7d: e8 6e a7 7c ff              	callq	0x1800952f0 <.text+0x942f0>
1808cab82: 48 8d 4d ef                 	leaq	-0x11(%rbp), %rcx
1808cab86: e8 65 a7 7c ff              	callq	0x1800952f0 <.text+0x942f0>
1808cab8b: 48 81 c4 a0 00 00 00        	addq	$0xa0, %rsp
1808cab92: 41 5e                       	popq	%r14
1808cab94: 5b                          	popq	%rbx
1808cab95: 5d                          	popq	%rbp
1808cab96: c3                          	retq
