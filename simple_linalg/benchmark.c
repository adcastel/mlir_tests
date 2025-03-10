#include <stdio.h>
#include <stdlib.h>

extern void gemm(float *A, float *B, float *C);

int main() {
    float *A = (float *)aligned_alloc(64, 128 * 128 * sizeof(float));
    float *B = (float *)aligned_alloc(64, 128 * 128 * sizeof(float));
    float *C = (float *)aligned_alloc(64, 128 * 128 * sizeof(float));

    // Initialize matrices
    for (int i = 0; i < 128 * 128; i++) {
        A[i] = (float)(rand() % 10);
        B[i] = (float)(rand() % 10);
        C[i] = 0.0f;
    }

    gemm(A, B, C); // Call JIT-compiled MLIR GEMM function

    // Print some values
    printf("C[0] = %f\n", C[0]);

    free(A);
    free(B);
    free(C);
    return 0;
}