# Chapter 5: Secure and Trustworthy Data Generation

[**Link to the chapter on O'Reilly Learning**](https://learning.oreilly.com/library/view/practical-transformers/9781098103001/ch05.html)

## Running any of the notebooks within a docker container

1. Make sure you have both `docker` and `buildx` installed.
2. Enter the `5_secure_and_trustworthy_data_generation/` directory.
3. Run the following command: 
    ```bash
    docker buildx build --platform linux/amd64 -t ptml/chapter_5_secure_and_trustworthy_data_generation:latest -f Dockerfile.dockerfile --load . --progress=plain
    ```
4. To run the notebook, run the following command: 
    ```bash
    docker run -p 8888:8888 ptml/chapter_5_secure_and_trustworthy_data_generation:latest
    ```
5. You should now be able to open http://localhost:8888 in your browser and run the notebook.

## Running [`Chapter_5_Synthetic_Data_Blender.ipynb`](Chapter_5_Synthetic_Data_Blender.ipynb)

See the above instructions for running the notebook in a docker container.

## Running [`Chapter_5_Synthetic_Data_Fractals.ipynb`](Chapter_5_Synthetic_Data_Fractals.ipynb)

No special instructions needed beyond what's specified for the various cloud services at the top of the notebook.
