# syntax = docker/dockerfile:1.2.1

FROM python:3.9-slim:latest

# Update the package lists for upgrades for security purposes and install pip
RUN apt-get update \
    && apt-get install -y python3-pip

# Set the working directory
WORKDIR /app
RUN mkdir /app/images

# Copy the notebooks, requirements, and README into the Docker image
COPY Chapter_7_Bootstrapping_Code_sample.ipynb \
    Chapter_7_Triangle_Plot.ipynb \
    requirements-chapter7.txt \
    README.md \
    /app/

# Install dependencies for Boostrapping and Triangle Plot
RUN pip3 install -r requirements-chapter7.txt

# Expose the port Jupyter Lab will be served on
EXPOSE 8888

# Set the default command to run when starting a container from this image
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''", "/app/Chapter_7_Bootstrapping_Code_sample.ipynb"]
