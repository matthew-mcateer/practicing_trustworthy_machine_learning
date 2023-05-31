# syntax = docker/dockerfile:1.2.1

FROM pytorch/pytorch:2.0.0-cuda11.7-cudnn8-devel

# Update the package lists for upgrades for security purposes and install pip
RUN apt-get update \
    && apt-get install -y python3-pip

# Set the working directory
WORKDIR /app

# Copy the notebooks, requirements, and README into the Docker image
COPY Chapter_6_Federated_Learning_Simulations.ipynb \
    Chapter_6_Homomorphic_Encryption_NN.ipynb \
    requirements-chapter6.txt \
    README.md \
    /app/

# Install dependencies for FLUTE
RUN pip3 install -r requirements-chapter6.txt \
    && git clone \
        https://github.com/microsoft/msrflute.git \
    && cd msrflute \
    && pip install -r requirements.txt

# Expose the port Jupyter Lab will be served on
EXPOSE 8888

# Set the default command to run when starting a container from this image
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''", "/app/Chapter_6_Federated_Learning_Simulations.ipynb"]
