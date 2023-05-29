# Chapter 1: Privacy

[**Link to the chapter on O'Reilly Learning**](https://learning.oreilly.com/library/view/practical-transformers/9781098103001/ch01.html)

## Running any of the notebooks within a docker container

1. Make sure you have both `docker` and `buildx` installed.
2. Enter the `1_privacy/` directory.
3. Run the following command: 
    ```bash
    docker buildx build --platform linux/amd64 -t ptml/chapter_1_privacy:latest -f Dockerfile.dockerfile --load . --progress=plain
    ```
4. To run the notebook, run the following command: 
    ```bash
    docker run -p 8888:8888 ptml/chapter_1_privacy:latest
    ```
5. You should now be able to open http://localhost:8888 in your browser and run the notebook.

## Running [`Chapter_1_BERT_attack.ipynb`](Chapter_1_BERT_attack.ipynb)

No special instructions needed beyond what's specified for the various cloud services at the top of the notebook.

## Running [`Chapter_1_Pytorch_DP_Demo.ipynb`](Chapter_1_Pytorch_DP_Demo.ipynb)

No special instructions needed beyond what's specified for the various cloud services at the top of the notebook.

## Running [`Chapter_1_SMPC_Example.ipynb`](Chapter_1_SMPC_Example.ipynb)

This example, as of February 2023, does not run on any of the previously listed cloud services.

In order to run this example, you will need to install the following packages on a Ubuntu 20.04 machine:

- [PySyft (sympc-dev branch)](https://github.com/OpenMined/PySyft@sympc-dev)
- [SyMPC-0.5](https://github.com/OpenMined/SyMPC.git@278a13dd5db4f3d00368372eb894a04050226acb)
- [CUDA 10.2](https://developer.nvidia.com/cuda-10.2-download-archive) ( [Instructions for installing on Ubuntu 20.04](https://github.com/immanuelvalencia/Cuda-10.2-Installation-Guide-For-Ubutu-20.04) )
    - Make sure you don't have conflicting CUDA versions
- PyTorch >1.6.0, <==1.8.0
- torchCSPRNG ( [Installation instructions here or your OS, CUDA, Python versions](https://pypi.org/project/torchcsprng/) )
- May need to downgrade any pre-installed `protobuf` to `3.20.*`
