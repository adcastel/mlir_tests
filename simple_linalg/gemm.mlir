module {
    func.func @gemm(%A: memref<128x64xf32>, %B: memref<64x256xf32>, %C: memref<128x256xf32>) {
        linalg.matmul ins(%A, %B : memref<128x64xf32>, memref<64x256xf32>) outs(%C : memref<128x256xf32>)
        return
    }
}


