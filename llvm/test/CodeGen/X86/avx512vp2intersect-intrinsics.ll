; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686-unknown-unknown -mattr=+avx512vp2intersect --show-mc-encoding | FileCheck %s --check-prefixes=CHECK,X86
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx512vp2intersect --show-mc-encoding | FileCheck %s --check-prefixes=CHECK,X64

define void @test_mm512_2intersect_epi32(<8 x i64> %a, <8 x i64> %b, i16* nocapture %m0, i16* nocapture %m1) {
; X86-LABEL: test_mm512_2intersect_epi32:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax # encoding: [0x8b,0x44,0x24,0x08]
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx # encoding: [0x8b,0x4c,0x24,0x04]
; X86-NEXT:    vp2intersectd %zmm1, %zmm0, %k0 # encoding: [0x62,0xf2,0x7f,0x48,0x68,0xc1]
; X86-NEXT:    kmovw %k0, (%ecx) # encoding: [0xc5,0xf8,0x91,0x01]
; X86-NEXT:    kmovw %k1, (%eax) # encoding: [0xc5,0xf8,0x91,0x08]
; X86-NEXT:    vzeroupper # encoding: [0xc5,0xf8,0x77]
; X86-NEXT:    retl # encoding: [0xc3]
;
; X64-LABEL: test_mm512_2intersect_epi32:
; X64:       # %bb.0: # %entry
; X64-NEXT:    vp2intersectd %zmm1, %zmm0, %k0 # encoding: [0x62,0xf2,0x7f,0x48,0x68,0xc1]
; X64-NEXT:    kmovw %k0, (%rdi) # encoding: [0xc5,0xf8,0x91,0x07]
; X64-NEXT:    kmovw %k1, (%rsi) # encoding: [0xc5,0xf8,0x91,0x0e]
; X64-NEXT:    vzeroupper # encoding: [0xc5,0xf8,0x77]
; X64-NEXT:    retq # encoding: [0xc3]
entry:
  %0 = bitcast <8 x i64> %a to <16 x i32>
  %1 = bitcast <8 x i64> %b to <16 x i32>
  %2 = tail call { <16 x i1>, <16 x i1> } @llvm.x86.avx512.vp2intersect.d.512(<16 x i32> %0, <16 x i32> %1)
  %3 = extractvalue { <16 x i1>, <16 x i1> } %2, 0
  %4 = bitcast i16* %m0 to <16 x i1>*
  store <16 x i1> %3, <16 x i1>* %4, align 16
  %5 = extractvalue { <16 x i1>, <16 x i1> } %2, 1
  %6 = bitcast i16* %m1 to <16 x i1>*
  store <16 x i1> %5, <16 x i1>* %6, align 16
  ret void
}

define void @test_mm512_2intersect_epi64(<8 x i64> %a, <8 x i64> %b, i8* nocapture %m0, i8* nocapture %m1) {
; X86-LABEL: test_mm512_2intersect_epi64:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax # encoding: [0x8b,0x44,0x24,0x04]
; X86-NEXT:    vp2intersectq %zmm1, %zmm0, %k0 # encoding: [0x62,0xf2,0xff,0x48,0x68,0xc1]
; X86-NEXT:    kmovw %k1, %ecx # encoding: [0xc5,0xf8,0x93,0xc9]
; X86-NEXT:    kmovw %k0, %edx # encoding: [0xc5,0xf8,0x93,0xd0]
; X86-NEXT:    movb %dl, (%eax) # encoding: [0x88,0x10]
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax # encoding: [0x8b,0x44,0x24,0x08]
; X86-NEXT:    movb %cl, (%eax) # encoding: [0x88,0x08]
; X86-NEXT:    vzeroupper # encoding: [0xc5,0xf8,0x77]
; X86-NEXT:    retl # encoding: [0xc3]
;
; X64-LABEL: test_mm512_2intersect_epi64:
; X64:       # %bb.0: # %entry
; X64-NEXT:    vp2intersectq %zmm1, %zmm0, %k0 # encoding: [0x62,0xf2,0xff,0x48,0x68,0xc1]
; X64-NEXT:    kmovw %k1, %eax # encoding: [0xc5,0xf8,0x93,0xc1]
; X64-NEXT:    kmovw %k0, %ecx # encoding: [0xc5,0xf8,0x93,0xc8]
; X64-NEXT:    movb %cl, (%rdi) # encoding: [0x88,0x0f]
; X64-NEXT:    movb %al, (%rsi) # encoding: [0x88,0x06]
; X64-NEXT:    vzeroupper # encoding: [0xc5,0xf8,0x77]
; X64-NEXT:    retq # encoding: [0xc3]
entry:
  %0 = tail call { <8 x i1>, <8 x i1> } @llvm.x86.avx512.vp2intersect.q.512(<8 x i64> %a, <8 x i64> %b)
  %1 = extractvalue { <8 x i1>, <8 x i1> } %0, 0
  %2 = bitcast i8* %m0 to <8 x i1>*
  store <8 x i1> %1, <8 x i1>* %2, align 8
  %3 = extractvalue { <8 x i1>, <8 x i1> } %0, 1
  %4 = bitcast i8* %m1 to <8 x i1>*
  store <8 x i1> %3, <8 x i1>* %4, align 8
  ret void
}

define void @test_mm512_2intersect_epi32_p(<8 x i64>* nocapture readonly %a, <8 x i64>* nocapture readonly %b, i16* nocapture %m0, i16* nocapture %m1) {
; X86-LABEL: test_mm512_2intersect_epi32_p:
; X86:       # %bb.0: # %entry
; X86-NEXT:    pushl %esi # encoding: [0x56]
; X86-NEXT:    .cfi_def_cfa_offset 8
; X86-NEXT:    .cfi_offset %esi, -8
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax # encoding: [0x8b,0x44,0x24,0x14]
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx # encoding: [0x8b,0x4c,0x24,0x10]
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edx # encoding: [0x8b,0x54,0x24,0x0c]
; X86-NEXT:    movl {{[0-9]+}}(%esp), %esi # encoding: [0x8b,0x74,0x24,0x08]
; X86-NEXT:    vmovaps (%esi), %zmm0 # encoding: [0x62,0xf1,0x7c,0x48,0x28,0x06]
; X86-NEXT:    vp2intersectd (%edx), %zmm0, %k0 # encoding: [0x62,0xf2,0x7f,0x48,0x68,0x02]
; X86-NEXT:    kmovw %k0, (%ecx) # encoding: [0xc5,0xf8,0x91,0x01]
; X86-NEXT:    kmovw %k1, (%eax) # encoding: [0xc5,0xf8,0x91,0x08]
; X86-NEXT:    popl %esi # encoding: [0x5e]
; X86-NEXT:    .cfi_def_cfa_offset 4
; X86-NEXT:    vzeroupper # encoding: [0xc5,0xf8,0x77]
; X86-NEXT:    retl # encoding: [0xc3]
;
; X64-LABEL: test_mm512_2intersect_epi32_p:
; X64:       # %bb.0: # %entry
; X64-NEXT:    vmovaps (%rdi), %zmm0 # encoding: [0x62,0xf1,0x7c,0x48,0x28,0x07]
; X64-NEXT:    vp2intersectd (%rsi), %zmm0, %k0 # encoding: [0x62,0xf2,0x7f,0x48,0x68,0x06]
; X64-NEXT:    kmovw %k0, (%rdx) # encoding: [0xc5,0xf8,0x91,0x02]
; X64-NEXT:    kmovw %k1, (%rcx) # encoding: [0xc5,0xf8,0x91,0x09]
; X64-NEXT:    vzeroupper # encoding: [0xc5,0xf8,0x77]
; X64-NEXT:    retq # encoding: [0xc3]
entry:
  %0 = bitcast <8 x i64>* %a to <16 x i32>*
  %1 = load <16 x i32>, <16 x i32>* %0, align 64
  %2 = bitcast <8 x i64>* %b to <16 x i32>*
  %3 = load <16 x i32>, <16 x i32>* %2, align 64
  %4 = tail call { <16 x i1>, <16 x i1> } @llvm.x86.avx512.vp2intersect.d.512(<16 x i32> %1, <16 x i32> %3)
  %5 = extractvalue { <16 x i1>, <16 x i1> } %4, 0
  %6 = bitcast i16* %m0 to <16 x i1>*
  store <16 x i1> %5, <16 x i1>* %6, align 16
  %7 = extractvalue { <16 x i1>, <16 x i1> } %4, 1
  %8 = bitcast i16* %m1 to <16 x i1>*
  store <16 x i1> %7, <16 x i1>* %8, align 16
  ret void
}

define void @test_mm512_2intersect_epi64_p(<8 x i64>* nocapture readonly %a, <8 x i64>* nocapture readonly %b, i8* nocapture %m0, i8* nocapture %m1) {
; X86-LABEL: test_mm512_2intersect_epi64_p:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax # encoding: [0x8b,0x44,0x24,0x0c]
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx # encoding: [0x8b,0x4c,0x24,0x08]
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edx # encoding: [0x8b,0x54,0x24,0x04]
; X86-NEXT:    vmovaps (%edx), %zmm0 # encoding: [0x62,0xf1,0x7c,0x48,0x28,0x02]
; X86-NEXT:    vp2intersectq (%ecx), %zmm0, %k0 # encoding: [0x62,0xf2,0xff,0x48,0x68,0x01]
; X86-NEXT:    kmovw %k1, %ecx # encoding: [0xc5,0xf8,0x93,0xc9]
; X86-NEXT:    kmovw %k0, %edx # encoding: [0xc5,0xf8,0x93,0xd0]
; X86-NEXT:    movb %dl, (%eax) # encoding: [0x88,0x10]
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax # encoding: [0x8b,0x44,0x24,0x10]
; X86-NEXT:    movb %cl, (%eax) # encoding: [0x88,0x08]
; X86-NEXT:    vzeroupper # encoding: [0xc5,0xf8,0x77]
; X86-NEXT:    retl # encoding: [0xc3]
;
; X64-LABEL: test_mm512_2intersect_epi64_p:
; X64:       # %bb.0: # %entry
; X64-NEXT:    vmovaps (%rdi), %zmm0 # encoding: [0x62,0xf1,0x7c,0x48,0x28,0x07]
; X64-NEXT:    vp2intersectq (%rsi), %zmm0, %k0 # encoding: [0x62,0xf2,0xff,0x48,0x68,0x06]
; X64-NEXT:    kmovw %k1, %eax # encoding: [0xc5,0xf8,0x93,0xc1]
; X64-NEXT:    kmovw %k0, %esi # encoding: [0xc5,0xf8,0x93,0xf0]
; X64-NEXT:    movb %sil, (%rdx) # encoding: [0x40,0x88,0x32]
; X64-NEXT:    movb %al, (%rcx) # encoding: [0x88,0x01]
; X64-NEXT:    vzeroupper # encoding: [0xc5,0xf8,0x77]
; X64-NEXT:    retq # encoding: [0xc3]

entry:
  %0 = load <8 x i64>, <8 x i64>* %a, align 64
  %1 = load <8 x i64>, <8 x i64>* %b, align 64
  %2 = tail call { <8 x i1>, <8 x i1> } @llvm.x86.avx512.vp2intersect.q.512(<8 x i64> %0, <8 x i64> %1)
  %3 = extractvalue { <8 x i1>, <8 x i1> } %2, 0
  %4 = bitcast i8* %m0 to <8 x i1>*
  store <8 x i1> %3, <8 x i1>* %4, align 8
  %5 = extractvalue { <8 x i1>, <8 x i1> } %2, 1
  %6 = bitcast i8* %m1 to <8 x i1>*
  store <8 x i1> %5, <8 x i1>* %6, align 8
  ret void
}

define void @test_mm512_2intersect_epi32_b(i32* nocapture readonly %a, i32* nocapture readonly %b, i16* nocapture %m0, i16* nocapture %m1) {
; X86-LABEL: test_mm512_2intersect_epi32_b:
; X86:       # %bb.0: # %entry
; X86-NEXT:    pushl %esi # encoding: [0x56]
; X86-NEXT:    .cfi_def_cfa_offset 8
; X86-NEXT:    .cfi_offset %esi, -8
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax # encoding: [0x8b,0x44,0x24,0x14]
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx # encoding: [0x8b,0x4c,0x24,0x10]
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edx # encoding: [0x8b,0x54,0x24,0x0c]
; X86-NEXT:    movl {{[0-9]+}}(%esp), %esi # encoding: [0x8b,0x74,0x24,0x08]
; X86-NEXT:    vbroadcastss (%esi), %zmm0 # encoding: [0x62,0xf2,0x7d,0x48,0x18,0x06]
; X86-NEXT:    vp2intersectd (%edx){1to16}, %zmm0, %k0 # encoding: [0x62,0xf2,0x7f,0x58,0x68,0x02]
; X86-NEXT:    kmovw %k0, (%ecx) # encoding: [0xc5,0xf8,0x91,0x01]
; X86-NEXT:    kmovw %k1, (%eax) # encoding: [0xc5,0xf8,0x91,0x08]
; X86-NEXT:    popl %esi # encoding: [0x5e]
; X86-NEXT:    .cfi_def_cfa_offset 4
; X86-NEXT:    vzeroupper # encoding: [0xc5,0xf8,0x77]
; X86-NEXT:    retl # encoding: [0xc3]
;
; X64-LABEL: test_mm512_2intersect_epi32_b:
; X64:       # %bb.0: # %entry
; X64-NEXT:    vbroadcastss (%rdi), %zmm0 # encoding: [0x62,0xf2,0x7d,0x48,0x18,0x07]
; X64-NEXT:    vp2intersectd (%rsi){1to16}, %zmm0, %k0 # encoding: [0x62,0xf2,0x7f,0x58,0x68,0x06]
; X64-NEXT:    kmovw %k0, (%rdx) # encoding: [0xc5,0xf8,0x91,0x02]
; X64-NEXT:    kmovw %k1, (%rcx) # encoding: [0xc5,0xf8,0x91,0x09]
; X64-NEXT:    vzeroupper # encoding: [0xc5,0xf8,0x77]
; X64-NEXT:    retq # encoding: [0xc3]
entry:
  %0 = load i32, i32* %a, align 4
  %vecinit.i = insertelement <16 x i32> undef, i32 %0, i32 0
  %vecinit15.i = shufflevector <16 x i32> %vecinit.i, <16 x i32> undef, <16 x i32> zeroinitializer
  %1 = load i32, i32* %b, align 4
  %vecinit.i2 = insertelement <16 x i32> undef, i32 %1, i32 0
  %vecinit15.i3 = shufflevector <16 x i32> %vecinit.i2, <16 x i32> undef, <16 x i32> zeroinitializer
  %2 = tail call { <16 x i1>, <16 x i1> } @llvm.x86.avx512.vp2intersect.d.512(<16 x i32> %vecinit15.i, <16 x i32> %vecinit15.i3)
  %3 = extractvalue { <16 x i1>, <16 x i1> } %2, 0
  %4 = bitcast i16* %m0 to <16 x i1>*
  store <16 x i1> %3, <16 x i1>* %4, align 16
  %5 = extractvalue { <16 x i1>, <16 x i1> } %2, 1
  %6 = bitcast i16* %m1 to <16 x i1>*
  store <16 x i1> %5, <16 x i1>* %6, align 16
  ret void
}

define void @test_mm512_2intersect_epi64_b(i64* nocapture readonly %a, i64* nocapture readonly %b, i8* nocapture %m0, i8* nocapture %m1) {
; X86-LABEL: test_mm512_2intersect_epi64_b:
; X86:       # %bb.0: # %entry
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax # encoding: [0x8b,0x44,0x24,0x0c]
; X86-NEXT:    movl {{[0-9]+}}(%esp), %ecx # encoding: [0x8b,0x4c,0x24,0x08]
; X86-NEXT:    movl {{[0-9]+}}(%esp), %edx # encoding: [0x8b,0x54,0x24,0x04]
; X86-NEXT:    vbroadcastsd (%edx), %zmm0 # encoding: [0x62,0xf2,0xfd,0x48,0x19,0x02]
; X86-NEXT:    vp2intersectq (%ecx){1to8}, %zmm0, %k0 # encoding: [0x62,0xf2,0xff,0x58,0x68,0x01]
; X86-NEXT:    kmovw %k1, %ecx # encoding: [0xc5,0xf8,0x93,0xc9]
; X86-NEXT:    kmovw %k0, %edx # encoding: [0xc5,0xf8,0x93,0xd0]
; X86-NEXT:    movb %dl, (%eax) # encoding: [0x88,0x10]
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax # encoding: [0x8b,0x44,0x24,0x10]
; X86-NEXT:    movb %cl, (%eax) # encoding: [0x88,0x08]
; X86-NEXT:    vzeroupper # encoding: [0xc5,0xf8,0x77]
; X86-NEXT:    retl # encoding: [0xc3]
;
; X64-LABEL: test_mm512_2intersect_epi64_b:
; X64:       # %bb.0: # %entry
; X64-NEXT:    vbroadcastsd (%rdi), %zmm0 # encoding: [0x62,0xf2,0xfd,0x48,0x19,0x07]
; X64-NEXT:    vp2intersectq (%rsi){1to8}, %zmm0, %k0 # encoding: [0x62,0xf2,0xff,0x58,0x68,0x06]
; X64-NEXT:    kmovw %k1, %eax # encoding: [0xc5,0xf8,0x93,0xc1]
; X64-NEXT:    kmovw %k0, %esi # encoding: [0xc5,0xf8,0x93,0xf0]
; X64-NEXT:    movb %sil, (%rdx) # encoding: [0x40,0x88,0x32]
; X64-NEXT:    movb %al, (%rcx) # encoding: [0x88,0x01]
; X64-NEXT:    vzeroupper # encoding: [0xc5,0xf8,0x77]
; X64-NEXT:    retq # encoding: [0xc3]
entry:
  %0 = load i64, i64* %a, align 8
  %vecinit.i = insertelement <8 x i64> undef, i64 %0, i32 0
  %vecinit7.i = shufflevector <8 x i64> %vecinit.i, <8 x i64> undef, <8 x i32> zeroinitializer
  %1 = load i64, i64* %b, align 8
  %vecinit.i2 = insertelement <8 x i64> undef, i64 %1, i32 0
  %vecinit7.i3 = shufflevector <8 x i64> %vecinit.i2, <8 x i64> undef, <8 x i32> zeroinitializer
  %2 = tail call { <8 x i1>, <8 x i1> } @llvm.x86.avx512.vp2intersect.q.512(<8 x i64> %vecinit7.i, <8 x i64> %vecinit7.i3)
  %3 = extractvalue { <8 x i1>, <8 x i1> } %2, 0
  %4 = bitcast i8* %m0 to <8 x i1>*
  store <8 x i1> %3, <8 x i1>* %4, align 8
  %5 = extractvalue { <8 x i1>, <8 x i1> } %2, 1
  %6 = bitcast i8* %m1 to <8 x i1>*
  store <8 x i1> %5, <8 x i1>* %6, align 8
  ret void
}

declare { <16 x i1>, <16 x i1> } @llvm.x86.avx512.vp2intersect.d.512(<16 x i32>, <16 x i32>)
declare { <8 x i1>, <8 x i1> } @llvm.x86.avx512.vp2intersect.q.512(<8 x i64>, <8 x i64>)
