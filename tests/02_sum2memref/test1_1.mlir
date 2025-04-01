module {
  emitc.func @abc(%arg0: memref<1xf32>, %arg1: memref<1xf32>) -> f32 {
    %c0 = arith.constant 0 : index
    %alloc = memref.alloc() : memref<1xf32>
    %alloc_0 = memref.alloc() : memref<1xf32>
    memref.copy %arg0, %alloc : memref<1xf32> to memref<1xf32>
    memref.copy %arg1, %alloc_0 : memref<1xf32> to memref<1xf32>
    %0 = memref.load %alloc[%c0] : memref<1xf32>
    %1 = memref.load %alloc_0[%c0] : memref<1xf32>
    %2 = arith.addf %0, %1 : f32
    emitc.return %2 : f32
  }
}

