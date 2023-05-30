# syntax = docker/dockerfile:1.2.1

FROM kubricdockerhub/kubruntu:latest

# Update the package lists for upgrades for security purposes and install pip
RUN apt-get update \
    && apt-get install -y python3-pip

# Set the working directory
WORKDIR /kubric

# Copy the notebooks, requirements, README, and images folder into the Docker image
COPY Chapter_5_Synthetic_Data_Blender.ipynb \
    Chapter_5_Synthetic_Data_Fractals.ipynb \
    requirements-chapter5.txt \
    README.md \
    images/ \
    outputs/ \
    /kubric/

# Install dependencies for Fractal Rendering
RUN pip3 install jupyterlab \
        watermark \
        pytorch-lightning \
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

# Expose the port Jupyter Lab will be served on
EXPOSE 8888

# Set the default command to run when starting a container from this image
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''", "/kubric/Chapter_5_Synthetic_Data_Blender.ipynb"]
