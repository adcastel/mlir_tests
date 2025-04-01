module{
	 func.func @abc(%a : tensor<1xf32>, %b : tensor<1xf32>) -> f32
	{ 
		%zero = arith.constant 0 : index

		%lh = tensor.extract %a[%zero] : tensor<1xf32>
		%rh = tensor.extract %b[%zero] : tensor<1xf32>
	    %res = arith.addf %lh, %rh : f32
	    
		return %res : f32
    }
}