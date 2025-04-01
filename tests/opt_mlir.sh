#!/bin/bash
MLIR_PATH=/usr/local/opt/llvm/bin/
TEST=$1/test1
rm ${TEST}_*.mlir
rm ${TEST}.c++
echo "=======INITIAL=========="
${MLIR_PATH}mlir-opt ${TEST}.mlir
${MLIR_PATH}mlir-opt ${TEST}.mlir --convert-func-to-emitc --lower-affine --o ${TEST}_1.mlir

echo "=======AFTER LOWER AFFINE=========="

${MLIR_PATH}mlir-opt ${TEST}_1.mlir

${MLIR_PATH}mlir-opt ${TEST}_1.mlir --convert-arith-to-emitc --convert-func-to-emitc --reconcile-unrealized-casts --o ${TEST}_2.mlir

echo "=======AFTER ARITH-TO-EMITC=========="


${MLIR_PATH}mlir-opt ${TEST}_2.mlir


${MLIR_PATH}mlir-opt ${TEST}_2.mlir  -normalize-memrefs --convert-memref-to-emitc --o ${TEST}_end.mlir

echo "=======AFTER MEMREF-TO-EMITC=========="

${MLIR_PATH}mlir-opt ${TEST}_end.mlir

echo "=======TRANSLATE TO C=========="

${MLIR_PATH}mlir-translate ${TEST}_end.mlir --mlir-to-cpp --o ${TEST}.c++
