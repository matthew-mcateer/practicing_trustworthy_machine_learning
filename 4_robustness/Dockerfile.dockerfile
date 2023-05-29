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
RUN pip3 install \
    adversarial-robustness-toolbox \
    git+https://github.com/nottombrown/imagenet_stubs \
    numpy \
    pandas \
    tensorflow

# Copy the notebooks into the Docker image
COPY Chapter_4_HopSkipJump_Attack_on_ImageNet.ipynb /app
COPY Chapter_4_Simple_Transparent_Adversarial_Examples.ipynb /app
COPY README.md /app

# Expose the port Jupyter Lab will be served on
EXPOSE 8888

# Set the default command to run when starting a container from this image
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''", "/app/Chapter_4_Simple_Transparent_Adversarial_Examples.ipynb"]
