# Chapter 6: More State of the Art Research Questions

[**Link to the chapter on O'Reilly Learning**](https://learning.oreilly.com/library/view/practical-transformers/9781098103001/ch06.html)

## Running any of the notebooks within a docker container

1. Make sure you have both `docker` and `buildx` installed.
2. Enter the `6_more_state_of_the_art_research_questions/` directory.
3. Run the following command: 
    ```bash
    docker buildx build --platform linux/amd64 -t ptml/chapter_6_more_state_of_the_art_research_questions:latest -f Dockerfile.dockerfile --load . --progress=plain
    ```
4. To run the notebook, run the following command: 
    ```bash
    docker run -p 8888:8888 ptml/chapter_6_more_state_of_the_art_research_questions:latest
    ```
5. You should now be able to open http://localhost:8888 in your browser and run the notebook.

## Running [`Chapter_6_Federated_Learning_Simulations.ipynb`](Chapter_6_Federated_Learning_Simulations.ipynb)

Recommend using an AWS instance with a much larger memory capacity than the default.
Otherwise, all but the smallest federated learning examples will fail here.

## Running [`Chapter_6_Homomorphic_Encryption_NN.ipynb`](Chapter_6_Homomorphic_Encryption_NN.ipynb)

No special instructions needed beyond what's specified for the various cloud services at the top of the notebook.

