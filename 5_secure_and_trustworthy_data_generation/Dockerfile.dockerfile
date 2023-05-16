# syntax = docker/dockerfile:1.2.1

FROM kubricdockerhub/kubruntu:latest

# Update the package lists for upgrades for security purposes
RUN apt-get update

# Install pip
RUN apt-get install -y python3-pip

# Install Jupyter Lab
RUN pip3 install jupyterlab watermark

# Set the working directory
WORKDIR /kubric

# Copy the notebook into the Docker image
COPY Chapter_5_Synthetic_Data_Blender.ipynb /kubric

# Expose the port Jupyter Lab will be served on
EXPOSE 8888

# Set the default command to run when starting a container from this image
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''", "/kubric/Chapter_5_Synthetic_Data_Blender.ipynb"]
