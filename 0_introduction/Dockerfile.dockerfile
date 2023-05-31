# syntax = docker/dockerfile:1.2.1

FROM python:3.9-slim

# Update the package lists for upgrades for security purposes and install pip
RUN apt-get update \
    && apt-get install -y python3-pip

# Set the working directory
WORKDIR /app

# Copy the notebook, requirements, and README into the Docker image
COPY Chapter_0_Safely_Loading_Saved_Models.ipynb \
    requirements-chapter0.txt \
    README.md \
    /app/

# Install dependencies for saved model loading
RUN pip3 install -r requirements-chapter0.txt

# Expose the port Jupyter Lab will be served on
EXPOSE 8888

# Set the default command to run when starting a container from this image
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''", "/app/Chapter_0_Safely_Loading_Saved_Models.ipynb"]
