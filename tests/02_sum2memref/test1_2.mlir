module {
  emitc.func @abc(%arg0: memref<1xf32>, %arg1: memref<1xf32>) -> f32 {
    %0 = "emitc.constant"() <{value = 0 : index}> : () -> !emitc.size_t
    %1 = builtin.unrealized_conversion_cast %0 : !emitc.size_t to index
    %alloc = memref.alloc() : memref<1xf32>
    %alloc_0 = memref.alloc() : memref<1xf32>
    memref.copy %arg0, %alloc : memref<1xf32> to memref<1xf32>
    memref.copy %arg1, %alloc_0 : memref<1xf32> to memref<1xf32>
    %2 = memref.load %alloc[%1] : memref<1xf32>
    %3 = memref.load %alloc_0[%1] : memref<1xf32>
    %4 = emitc.add %2, %3 : (f32, f32) -> f32
    emitc.return %4 : f32
  }
}

