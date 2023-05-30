# syntax = docker/dockerfile:1.2.1

FROM python:3.9-slim:latest

# Update the package lists for upgrades for security purposes and install pip
RUN apt-get update \
    && apt-get install -y python3-pip

# Set the working directory
WORKDIR /app

# Copy the BOLD dataset, requirements, notebooks, and models to the Docker image
COPY prompts/ \
    requirements-chapter2.txt \
    Chapter_2_Evaluating_LMs_on_BOLD.ipynb \
    categorizing_skin_characteristics.py \
    semantic_segmentation/ \
    __init__.py \
    README.md \
    /app/

# Install dependencies for Evaluating LMs on BOLD
RUN pip3 install -r requirements-chapter2.txt

# Expose the port Jupyter Lab will be served on
EXPOSE 8888

# Set the default command to run when starting a container from this image
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''", "/app/Chapter_2_Evaluating_LMs_on_BOLD.ipynb"]
