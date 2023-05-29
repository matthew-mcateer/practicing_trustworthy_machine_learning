# syntax = docker/dockerfile:1.2.1

FROM pytorch/pytorch:2.0.1-cuda11.7-cudnn8-devel:latest

# Update the package lists for upgrades for security purposes
RUN apt-get update

# Install pip
RUN apt-get install -y python3-pip

# Install Jupyter Lab
RUN pip3 install jupyterlab watermark

# Set the working directory
WORKDIR /app

# Install dependencies for the notebooks
RUN pip3 install \
        captum \
        git+https://github.com/openai/CLIP.github \
        colorcet \
        einops \
        ftfy \
        lime \
        interpret \
        pandas \
        pygam \
        regex \
        scikit-learn \
        scikit-learn-intelex  \
        shap \
        git+https://github.com/finetuneanon/transformers/@gpt-neo-localattention  \
        transformer-utils \
        tqdm \
        xgboost

# Install PySR, which requires the Julia Language to be installed
RUN pip install pysr

RUN mkdir /app/clip_images

# Copy the notebooks into the Docker image
COPY Chapter_3_CLIP_Saliency_mapping_Part1.ipynb /app
COPY Chapter_3_CLIP_Saliency_mapping_Part2.ipynb /app
COPY Chapter_3_Interpreting_GPT.ipynb /app
COPY Chapter_3_Intrinsically_Interpretable_Models.ipynb /app
COPY Chapter_3_LIME_for_Transformers.ipynb /app
COPY Chapter_3_SHAP_for_Transformers.ipynb /app
COPY README.md /app

# Copy the images into the Docker image
COPY clip_images/astronaut.png /app/clip_images
COPY clip_images/catdog.png /app/clip_images
COPY clip_images/dog.png /app/clip_images
COPY clip_images/dogbird.png /app/clip_images
COPY clip_images/dogcat2.png /app/clip_images
COPY clip_images/el1.png /app/clip_images
COPY clip_images/el2.png /app/clip_images
COPY clip_images/el3.png /app/clip_images
COPY clip_images/el4.png /app/clip_images
COPY clip_images/glasses.png /app/clip_images
COPY clip_images/lipstick.png /app/clip_images
COPY clip_images/noise.png /app/clip_images
COPY clip_images/rocket.png /app/clip_images

# Copy the example data
COPY redwine-quality.csv  /app
COPY tumors.csv  /app

# Expose the port Jupyter Lab will be served on
EXPOSE 8888

# Set the default command to run when starting a container from this image
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''", "/app/Chapter_3_CLIP_Saliency_mapping_Part1.ipynb"]
