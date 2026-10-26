
/Users/antonkrutov/Desktop/Forest/localization/probes/ru-20261026-39/game/UnityPlayer.dll:	file format coff-x86-64

Disassembly of section .text:

0000000180539bd0 <UnityMain>:
1808d04c0: 48 89 5c 24 10              	movq	%rbx, 0x10(%rsp)
1808d04c5: 48 89 74 24 18              	movq	%rsi, 0x18(%rsp)
1808d04ca: 57                          	pushq	%rdi
1808d04cb: 48 81 ec 80 00 00 00        	subq	$0x80, %rsp
1808d04d2: 48 8b f1                    	movq	%rcx, %rsi
1808d04d5: 49 8b d8                    	movq	%r8, %rbx
1808d04d8: 49 8b c9                    	movq	%r9, %rcx
1808d04db: 48 8b fa                    	movq	%rdx, %rdi
1808d04de: e8 ed 00 00 00              	callq	0x1808d05d0 <UnityMain+0x396a00>
1808d04e3: 84 c0                       	testb	%al, %al
1808d04e5: 0f 84 ab 00 00 00           	je	0x1808d0596 <UnityMain+0x3969c6>
1808d04eb: 48 8b 84 24 c0 00 00 00     	movq	0xc0(%rsp), %rax
1808d04f3: 48 85 c0                    	testq	%rax, %rax
1808d04f6: 74 0a                       	je	0x1808d0502 <UnityMain+0x396932>
1808d04f8: ff d0                       	callq	*%rax
1808d04fa: 84 c0                       	testb	%al, %al
1808d04fc: 0f 84 94 00 00 00           	je	0x1808d0596 <UnityMain+0x3969c6>
1808d0502: 8b 43 20                    	movl	0x20(%rbx), %eax
1808d0505: 48 8d 4c 24 30              	leaq	0x30(%rsp), %rcx


/Users/antonkrutov/Desktop/Forest/localization/probes/ru-20261026-39/game/UnityPlayer.dll:	file format coff-x86-64

Disassembly of section .text:

0000000180539bd0 <UnityMain>:
1808d050a: 48 89 ac 24 90 00 00 00     	movq	%rbp, 0x90(%rsp)
1808d0512: 48 8b d3                    	movq	%rbx, %rdx
1808d0515: 33 ed                       	xorl	%ebp, %ebp
1808d0517: 89 44 24 50                 	movl	%eax, 0x50(%rsp)
1808d051b: 48 89 6c 24 30              	movq	%rbp, 0x30(%rsp)
1808d0520: 48 89 6c 24 48              	movq	%rbp, 0x48(%rsp)
1808d0525: 40 88 6c 24 38              	movb	%bpl, 0x38(%rsp)
1808d052a: e8 61 4c 7c ff              	callq	0x180095190 <.text+0x94190>
1808d052f: 8b 47 20                    	movl	0x20(%rdi), %eax
1808d0532: 48 8d 4c 24 58              	leaq	0x58(%rsp), %rcx
1808d0537: 48 8b d7                    	movq	%rdi, %rdx
1808d053a: 89 44 24 78                 	movl	%eax, 0x78(%rsp)
1808d053e: 48 89 6c 24 58              	movq	%rbp, 0x58(%rsp)
1808d0543: 48 89 6c 24 70              	movq	%rbp, 0x70(%rsp)
1808d0548: 40 88 6c 24 60              	movb	%bpl, 0x60(%rsp)
1808d054d: e8 3e 4c 7c ff              	callq	0x180095190 <.text+0x94190>
1808d0552: 48 8b 84 24 b8 00 00 00     	movq	0xb8(%rsp), %rax
1808d055a: 4c 8d 44 24 30              	leaq	0x30(%rsp), %r8
1808d055f: 44 8b 8c 24 b0 00 00 00     	movl	0xb0(%rsp), %r9d
1808d0567: 48 8d 54 24 58              	leaq	0x58(%rsp), %rdx
1808d056c: 40 88 6c 24 28              	movb	%bpl, 0x28(%rsp)
1808d0571: 48 8b ce                    	movq	%rsi, %rcx
1808d0574: 48 89 44 24 20              	movq	%rax, 0x20(%rsp)
1808d0579: e8 02 73 ff ff              	callq	0x1808c7880 <UnityMain+0x38dcb0>
1808d057e: 48 8b ac 24 90 00 00 00     	movq	0x90(%rsp), %rbp
1808d0586: 84 c0                       	testb	%al, %al
1808d0588: 75 2b                       	jne	0x1808d05b5 <UnityMain+0x3969e5>


/Users/antonkrutov/Desktop/Forest/localization/probes/ru-20261026-39/game/UnityPlayer.dll:	file format coff-x86-64

Disassembly of section .text:

0000000180539bd0 <UnityMain>:
1808d058a: 48 8d 0d ff 9a dd 00        	leaq	0xdd9aff(%rip), %rcx    # 0x1816aa090
1808d0591: e8 ba c5 60 00              	callq	0x180edcb50 <UnityMain+0x9a2f80>
1808d0596: 48 8b cb                    	movq	%rbx, %rcx
1808d0599: e8 52 4d 7c ff              	callq	0x1800952f0 <.text+0x942f0>
1808d059e: 32 c0                       	xorb	%al, %al
1808d05a0: 4c 8d 9c 24 80 00 00 00     	leaq	0x80(%rsp), %r11
1808d05a8: 49 8b 5b 18                 	movq	0x18(%r11), %rbx
1808d05ac: 49 8b 73 20                 	movq	0x20(%r11), %rsi
1808d05b0: 49 8b e3                    	movq	%r11, %rsp
1808d05b3: 5f                          	popq	%rdi
1808d05b4: c3                          	retq
1808d05b5: 48 8b cb                    	movq	%rbx, %rcx
1808d05b8: e8 33 4d 7c ff              	callq	0x1800952f0 <.text+0x942f0>
1808d05bd: b0 01                       	movb	$0x1, %al
1808d05bf: eb df                       	jmp	0x1808d05a0 <UnityMain+0x3969d0>
