#include "mlir/Conversion/LinalgToLLVM/LinalgToLLVM.h"
#include "mlir/Conversion/VectorToLLVM/ConvertVectorToLLVM.h"
#include "mlir/Dialect/Linalg/Transforms/Transforms.h"
#include "mlir/Pass/Pass.h"
#include "mlir/Transforms/GreedyPatternRewriteDriver.h"

using namespace mlir;

namespace
{
    struct GemmOptimizationPass : public PassWrapper<GemmOptimizationPass, 
                                                OperationPass<ModuleOp>
                                                >
    {
        void runOnOperation() override
        {
        ModuleOp module = getOperation();
        MLIRContext *context = &getContext();

        RewritePatternSet patterns(context);
        linalg::populateLinalgTilingPatterns(patterns);
        applyPatternsAndFoldGreedily(module, std::move(patterns));
    
        RewritePatternSet vectorPatterns(context);
        vector::populateVectorizationPatterns(vectorPatterns);
        applyPatternsAndFoldGreedily(module, std::move(vectorPatterns));
    
        // Lower to LLVM
        ConversionTarget target(*context);
        target.addLegalDialect<LLVM::LLVMDialect>();
        RewritePatternSet llvmPatterns(context);
        populateVectorToLLVMConversionPatterns(llvmPatterns);
        populateLinalgToLLVMConversionPatterns(llvmPatterns);
        applyPartialConversion(module, target, std::move(llvmPatterns));
        }
    }; 
}// namespace

extern "C" ::mlir::Pass *createGemmOptimizationPass() {
    return new GemmOptimizationPass();
  }