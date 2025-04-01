module{
	 func.func @abc(%a : memref<1xf32>, %b : memref<1xf32>) -> f32
	{ 
		%zero = arith.constant 0 : index
		%aa = memref.alloc() : memref<1xf32>
		%bb = memref.alloc() : memref<1xf32>
        memref.copy %a, %aa : memref<1xf32> to memref<1xf32>
        memref.copy %b, %bb : memref<1xf32> to memref<1xf32>

		%lh = affine.load %aa[%zero] : memref<1xf32>
		%rh = affine.load %bb[%zero] : memref<1xf32>
	    %res = arith.addf %lh, %rh : f32
	    
		return %res : f32
    }
}