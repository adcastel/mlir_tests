module {
  func.func @gemm(%arg0: memref<128x64xf32>, %arg1: memref<64x256xf32>, %arg2: memref<128x256xf32>) {
    %c0 = arith.constant 0 : index
    %c128 = arith.constant 128 : index
    %c1 = arith.constant 1 : index
    %c256 = arith.constant 256 : index
    %c64 = arith.constant 64 : index
    scf.for %arg3 = %c0 to %c128 step %c1 {
      scf.for %arg4 = %c0 to %c256 step %c1 {
        scf.for %arg5 = %c0 to %c64 step %c1 {
          %0 = memref.load %arg0[%arg3, %arg5] : memref<128x64xf32>
          %1 = memref.load %arg1[%arg5, %arg4] : memref<64x256xf32>
          %2 = memref.load %arg2[%arg3, %arg4] : memref<128x256xf32>
          %3 = arith.mulf %0, %1 : f32
          %4 = arith.addf %2, %3 : f32
          memref.store %4, %arg2[%arg3, %arg4] : memref<128x256xf32>
        }
      }
    }
    return
  }
}

