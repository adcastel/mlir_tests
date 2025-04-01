This example is the very first one I try, it does not need any dialect or any llvm recompilation so you can use it in your local package-installed version of llvm

I have tried the lowering of the linalg.matmul approach to tvm

mlir-opt gemm.mlir -convert-linalg-to-affine-loops --lower-affine  --convert-scf-to-cf --convert-cf-to-llvm --convert-arith-to-llvm --convert-func-to-llvm --finalize-memref-to-llvm -reconcile-unrealized-casts --o gemm_opt2.mlir

mlir-translate --mlir-to-llvmir gemm_opt2.mlir -o gemm.ll

llc -O3 gemm.ll -o gemm.s

clang benchmark.c gemm.s -o benchmark
./benchmark 
Alloc
A
>B
C
Segmentation fault: 11

from here: https://www.jeremykun.com/2023/11/01/mlir-lowering-through-llvm/ I have learnt a lot of details of how to order the different lowering passes. However, it ended with a llvm code that does not match the C API. It is useful for generating the entire rutine.

I tried to lower the linalg to c code via --xonvert-XXX-toemitc clauses like:

mlir-opt gemm.mlir -convert-linalg-to-affine-loops --lower-affine  
                        --convert-scf-to-emitc 
                        --convert-arith-to-emitc 
                        --convert-func-to-emitc 
                        --normalize-memrefs 
                        --convert-memref-to-emitc 
                        -reconcile-unrealized-casts  --o gemm_opt2.mlir

But fails with 
gemm_opt2.mlir:26:17: error: failed to legalize unresolved materialization from ('memref<128x256xf32>') to '!emitc.array<128x256xf32>' that remained live after conversion
          %20 = memref.load %arg2[%arg3, %arg4] : memref<128x256xf32>
                ^
gemm_opt2.mlir:26:17: note: see current operation: %0 = "builtin.unrealized_conversion_cast"(%arg2) : (memref<128x256xf32>) -> !emitc.array<128x256xf32>
gemm_opt2.mlir:29:11: note: see existing live user here: %28 = emitc.subscript %0[%arg3, %arg4] : (!emitc.array<128x256xf32>, index, index) -> f32
          memref.store %22, %arg2[%arg3, %arg4] : memref<128x256xf32>
          ^

Next I will try a initial code written by my own