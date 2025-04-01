	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 15, 0
	.globl	_gemm                           ## -- Begin function gemm
	.p2align	4, 0x90
_gemm:                                  ## @gemm
	.cfi_startproc
## %bb.0:
	pushq	%r15
	.cfi_def_cfa_offset 16
	pushq	%r14
	.cfi_def_cfa_offset 24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset %rbx, -32
	.cfi_offset %r14, -24
	.cfi_offset %r15, -16
	movq	104(%rsp), %rax
	movq	48(%rsp), %rcx
	xorl	%edx, %edx
	xorl	%edi, %edi
	jmp	LBB0_1
	.p2align	4, 0x90
LBB0_8:                                 ##   in Loop: Header=BB0_1 Depth=1
	incq	%rdi
	addq	$256, %rdx                      ## imm = 0x100
LBB0_1:                                 ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB0_3 Depth 2
                                        ##       Child Loop BB0_6 Depth 3
	cmpq	$127, %rdi
	jg	LBB0_9
## %bb.2:                               ##   in Loop: Header=BB0_1 Depth=1
	leaq	(%rsi,%rdx), %r8
	movq	%rdi, %r9
	shlq	$8, %r9
	xorl	%r10d, %r10d
	xorl	%r11d, %r11d
	jmp	LBB0_3
	.p2align	4, 0x90
LBB0_7:                                 ##   in Loop: Header=BB0_3 Depth=2
	incq	%r11
	addq	$4, %r10
LBB0_3:                                 ##   Parent Loop BB0_1 Depth=1
                                        ## =>  This Loop Header: Depth=2
                                        ##       Child Loop BB0_6 Depth 3
	cmpq	$255, %r11
	jg	LBB0_8
## %bb.4:                               ##   in Loop: Header=BB0_3 Depth=2
	leaq	(%r9,%r11), %rbx
	movq	%r10, %r14
	xorl	%r15d, %r15d
	cmpq	$63, %r15
	jg	LBB0_7
	.p2align	4, 0x90
LBB0_6:                                 ##   Parent Loop BB0_1 Depth=1
                                        ##     Parent Loop BB0_3 Depth=2
                                        ## =>    This Inner Loop Header: Depth=3
	movss	(%r8,%r15,4), %xmm0             ## xmm0 = mem[0],zero,zero,zero
	mulss	(%rcx,%r14), %xmm0
	addss	(%rax,%rbx,4), %xmm0
	movss	%xmm0, (%rax,%rbx,4)
	incq	%r15
	addq	$1024, %r14                     ## imm = 0x400
	cmpq	$63, %r15
	jle	LBB0_6
	jmp	LBB0_7
LBB0_9:
	popq	%rbx
	popq	%r14
	popq	%r15
	retq
	.cfi_endproc
                                        ## -- End function
.subsections_via_symbols
