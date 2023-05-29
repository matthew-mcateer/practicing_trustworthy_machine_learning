# Chapter 3: Model Explainability and Interpretability

[**Link to the chapter on O'Reilly Learning**](https://learning.oreilly.com/library/view/practical-transformers/9781098103001/ch03.html)

## Running any of the notebooks within a docker container

1. Make sure you have both `docker` and `buildx` installed.
2. Enter the `3_model_explainability_and_interpretability/` directory.
3. Run the following command: 
    ```bash
    docker buildx build --platform linux/amd64 -t ptml/chapter_3_model_explainability_and_interpretability:latest -f Dockerfile.dockerfile --load . --progress=plain
    ```
4. To run the notebook, run the following command: 
    ```bash
    docker run -p 8888:8888 ptml/chapter_3_model_explainability_and_interpretability:latest
    ```
5. You should now be able to open http://localhost:8888 in your browser and run the notebook.

## Running [`Chapter_3_CLIP_Saliency_mapping_Part1.ipynb`](Chapter_3_CLIP_Saliency_mapping_Part1.ipynb)

No special instructions needed beyond what's specified for the various cloud services at the top of the notebook.

## Running [`Chapter_3_CLIP_Saliency_mapping_Part2.ipynb`](Chapter_3_CLIP_Saliency_mapping_Part2.ipynb)

No special instructions needed beyond what's specified for the various cloud services at the top of the notebook.

## Running [`Chapter_3_Interpreting_GPT.ipynb`](Chapter_3_Interpreting_GPT.ipynb)

No special instructions needed beyond what's specified for the various cloud services at the top of the notebook.

## Running [`Chapter_3_Intrinsically_Interpretable_Models.ipynb`](Chapter_3_Intrinsically_Interpretable_Models.ipynb)

No special instructions needed beyond what's specified for the various cloud services at the top of the notebook.

## Running [`Chapter_3_LIME_for_Transformers.ipynb`](Chapter_3_LIME_for_Transformers.ipynb)

No special instructions needed beyond what's specified for the various cloud services at the top of the notebook.

## Running [`Chapter_3_SHAP_for_Transformers.ipynb`](Chapter_3_SHAP_for_Transformers.ipynb)

No special instructions needed beyond what's specified for the various cloud services at the top of the notebook.
