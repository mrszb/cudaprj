__global__ void add_gpu(int n, float* x, float* y)
{
    for (int i = 0; i < n; i++)
        y[i] = x[i] + y[i];
}


int main (void)
{
    int N = 1 << 20;
    float* x;
    float* y;
    
    cudaMallocManaged(&x, N*sizeof(float));
    cudaMallocManaged(&y, N*sizeof(float));

    for (int i = 0; i < N; i++) {
        x[i] = 1.0f;
        y[i] = 2.0f;
    }

    add_gpu<<<1,1>>>(N, x, y);

    cudaFree(x);
    cudaFree(y);
}