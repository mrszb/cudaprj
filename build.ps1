cmake -DCMAKE_CUDA_ARCHITECTURES=75 -B build .
cmake --build build --config Release | Tee-Object build-log.txt 2>&1