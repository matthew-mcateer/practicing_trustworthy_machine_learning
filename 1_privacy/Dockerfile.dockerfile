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

# Install dependencies for BERT attack
RUN pip3 install nlp transformers dill==0.3.5.1 torch numpy sklearn

# Install dependencies for Pytorch DP Demo
RUN pip3 install \
        torchcsprng==0.1.3+cu101 \
        -f https://download.pytorch.org/whl/torch_stable.html \
    && pip3 install \
        opacus

RUN mkdir /app/images

# Copy the notebooks into the Docker image
COPY Chapter_1_BERT_attack.ipynb /app
COPY Chapter_1_Pytorch_DP_Demo.ipynb /app
COPY Chapter_1_SMPC_Example.ipynb /app


# Expose the port Jupyter Lab will be served on
EXPOSE 8888

# Set the default command to run when starting a container from this image
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''", "/app/Chapter_1_Pytorch_DP_Demo.ipynb"]
