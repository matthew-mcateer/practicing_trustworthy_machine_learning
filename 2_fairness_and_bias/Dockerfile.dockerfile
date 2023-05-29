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

# Install dependencies for Evaluating LMs on BOLD
RUN pip3 install torch pandas transformers detoxify 

RUN mkdir /app/semantic_segmentation
RUN mkdir /app/semantic_segmentation/models
RUN mkdir /app/prompts

# Copy the notebooks into the Docker image
COPY Chapter_2_Evaluating_LMs_on_BOLD.ipynb /app
COPY categorizing_skin_characteristics.py /app
COPY README.md /app

# Copy the BOLD dataset to the Docker image
COPY prompts/gender_prompt.json /app/prompts
COPY prompts/political_ideology_prompt.json /app/prompts
COPY prompts/profession_prompt.json /app/prompts
COPY prompts/race_prompt.json /app/prompts
COPY prompts/README.md /app/prompts
COPY prompts/religious_ideology_prompt.json /app/prompts

# Copy the models into the Docker image
COPY semantic_segmentation/models/__init__.py /app/semantic_segmentation/models
COPY semantic_segmentation/models/bisenetv2.py /app/semantic_segmentation/models
COPY semantic_segmentation/models/fcn.py /app/semantic_segmentation/models
COPY semantic_segmentation/models/models.py /app/semantic_segmentation/models
COPY semantic_segmentation/__init__.py /app/semantic_segmentation
COPY semantic_segmentation/dataloaders.py /app/semantic_segmentation
COPY semantic_segmentation/dataset.py /app/semantic_segmentation
COPY semantic_segmentation/metrics.py /app/semantic_segmentation
COPY semantic_segmentation/engines.py /app/semantic_segmentation
COPY semantic_segmentation/visualisation.py /app/semantic_segmentation
COPY __init__.py /app

# Expose the port Jupyter Lab will be served on
EXPOSE 8888

# Set the default command to run when starting a container from this image
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''", "/app/Chapter_2_Evaluating_LMs_on_BOLD.ipynb"]
