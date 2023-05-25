# Chapter 5: Secure and Trustworthy Data Generation

## Running [`Chapter_5_Synthetic_Data_Blender.ipynb`](Chapter_5_Synthetic_Data_Blender.ipynb)

1. Make sure you have both `docker` and `buildx` installed.
2. Enter the `5_secure_and_trustworthy_data_generation/` directory.
3. Run the following command: 
    ```bash
    docker buildx build --platform linux/amd64 -t ptml/data_blender:latest -f Dockerfile.dockerfile --load .
    ```
4. To run the notebook, run the following command: 
    ```bash
    docker run -p 8888:8888 ptml/data_blender:latest
    ```
5. You should now be able to open http://localhost:8888 in your browser and run the notebook.

## Running [`Chapter_5_Synthetic_Data_Fractals.ipynb`](Chapter_5_Synthetic_Data_Fractals.ipynb)

No special instructions needed beyond what's specified for the various cloud services at the top of the notebook.
