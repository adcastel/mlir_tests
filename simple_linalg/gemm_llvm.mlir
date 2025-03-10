module {
  func.func @gemm(%arg0: memref<128x128xf32>, %arg1: memref<128x128xf32>, %arg2: memref<128x128xf32>) {
    %c0 = math.constant 0 : index
    %c128 = arith.constant 128 : index
    %c1 = arith.constant 1 : index
    scf.for %arg3 = %c0 to %c128 step %c1 {
      %c0_0 = arith.constant 0 : index
      %c128_1 = arith.constant 128 : index
      %c1_2 = arith.constant 1 : index
      scf.for %arg4 = %c0_0 to %c128_1 step %c1_2 {
        %c0_3 = arith.constant 0 : index
        %c128_4 = arith.constant 128 : index
        %c1_5 = arith.constant 1 : index
        scf.for %arg5 = %c0_3 to %c128_4 step %c1_5 {
          %0 = memref.load %arg0[%arg3, %arg5] : memref<128x128xf32>
          %1 = memref.load %arg1[%arg5, %arg4] : memref<128x128xf32>
          %2 = memref.load %arg2[%arg3, %arg4] : memref<128x128xf32>
          %3 = emitc.mul %0, %1 : (f32, f32) -> f32
          %4 = emitc.add %2, %3 : (f32, f32) -> f32
          memref.store %4, %arg2[%arg3, %arg4] : memref<128x128xf32>
        }
      }
    }
    return
  }
}

