# Chapter 4: Robustness

[**Link to the chapter on O'Reilly Learning**](https://learning.oreilly.com/library/view/practical-transformers/9781098103001/ch04.html)

## Running any of the notebooks within a docker container

1. Make sure you have both `docker` and `buildx` installed.
2. Enter the `4_robustness/` directory.
3. Run the following command: 
    ```bash
    docker buildx build --platform linux/amd64 -t ptml/chapter_4_robustness:latest -f Dockerfile.dockerfile --load . --progress=plain
    ```
4. To run the notebook, run the following command: 
    ```bash
    docker run -p 8888:8888 ptml/chapter_4_robustness:latest
    ```
5. You should now be able to open http://localhost:8888 in your browser and run the notebook.

## Running [`Chapter_4_HopSkipJump_Attack_on_ImageNet.ipynb`](Chapter_4_HopSkipJump_Attack_on_ImageNet.ipynb)

No special instructions needed beyond what's specified for the various cloud services at the top of the notebook.

## Running [`Chapter_4_Simple_Transparent_Adversarial_Examples.ipynb`](Chapter_4_Simple_Transparent_Adversarial_Examples.ipynb)

No special instructions needed beyond what's specified for the various cloud services at the top of the notebook.
