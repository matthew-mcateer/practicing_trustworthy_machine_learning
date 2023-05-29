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

# Install dependencies for FLUTE
RUN git clone \
        https://github.com/microsoft/msrflute.git \
    && cd msrflute \
    && pip install -r requirements.txt

RUN mkdir /app/images

# Copy the notebook into the Docker image
COPY Chapter_6_Federated_Learning_Simulations.ipynb /app
COPY Chapter_6_Homomorphic_Encryption_NN.ipynb /app
COPY README.md /app

# Expose the port Jupyter Lab will be served on
EXPOSE 8888

# Set the default command to run when starting a container from this image
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''", "/app/Chapter_6_Federated_Learning_Simulations.ipynb"]