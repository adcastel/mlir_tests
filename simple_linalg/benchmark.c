#include <stdio.h>
#include <stdlib.h>

extern void gemm(float *A, float *B, float *C);

int main() {
    int M = 128;
    int N = 256;
    int K = 64;

    float *A = (float *)malloc(M * K * sizeof(float));
    float *B = (float *)malloc(K * N * sizeof(float));
    float *C = (float *)malloc(M * N * sizeof(float));
    printf("Alloc\n");
    // Initialize matrices
    for (int i = 0; i < M * K; i++) {
        A[i] = (float)(rand() % 10);
    }
    printf("A\n");

    for (int i = 0; i < K * N; i++) {
        B[i] = (float)(rand() % 10);
    }
    printf(">B\n");
    for (int i = 0; i < M * N; i++) {
        C[i] = 0.0f;
    }
    printf("C\n");

    gemm(A, B, C); // Call JIT-compiled MLIR GEMM function

    // Print some values
    printf("C[0] = %f\n", C[0]);

    free(A);
    free(B);
    free(C);
    return 0;
}