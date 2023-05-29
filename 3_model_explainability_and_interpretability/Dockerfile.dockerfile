# syntax = docker/dockerfile:1.2.1

FROM python:3.9-slim:latest

# Update the package lists for upgrades for security purposes
RUN apt-get update

# Install pip
RUN apt-get install -y python3-pip

# Install Jupyter Lab
RUN pip3 install jupyterlab watermark

# Set the working directory
WORKDIR /app

# Install dependencies for Fractal Rendering
RUN pip3 pytorch-lightning \
        omegaconf \
        torchmetrics \
        fgvcdata \
        merlin-dataloader==0.0.2 \
        transformers \
        datasets \
    && pip3 install hydra-core --upgrade \
    && git clone \
        https://github.com/catalys1/fractal-pretraining.git \
    && cd fractal-pretraining \
    && bash install_requirements.sh \
    && pip3 install -e fractal_learning

RUN mkdir /app/images

# Copy the notebooks into the Docker images
COPY Chapter_3_CLIP_Saliency_mapping_Part1.ipynb /app
COPY Chapter_3_CLIP_Saliency_mapping_Part2.ipynb /app
COPY Chapter_3_Interpreting_GPT.ipynb /app
COPY Chapter_3_Intrinsically_Interpretable_Models.ipynb /app
COPY Chapter_3_LIME_for_Transformers.ipynb /app
COPY Chapter_3_SHAP_for_Transformers.ipynb /app
COPY README.md /app

# Copy the example data
COPY redwine-quality.csv  /app
COPY tumors.csv  /app

# Expose the port Jupyter Lab will be served on
EXPOSE 8888

# Set the default command to run when starting a container from this image
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''", "/app/Chapter_5_Synthetic_Data_Blender.ipynb"]
