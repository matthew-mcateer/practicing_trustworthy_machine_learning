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

# Install dependencies for Fractal Rendering
RUN pip3 pytorch-lightning \
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

RUN mkdir /kubric/images

# Copy the notebook into the Docker image
COPY Chapter_5_Synthetic_Data_Blender.ipynb /kubric
COPY Chapter_5_Synthetic_Data_Fractals.ipynb /kubric
COPY README.md /kubric

# Copy the images into the Docker image
COPY images/ptml_helloworld_blend.png /kubric/images
COPY images/ptml_helloworld_depth.png /kubric/images
COPY images/ptml_helloworld_segmentation.png /kubric/images
COPY images/ptml_helloworld.png /kubric/images
COPY images/ptml_keyframing_blend.png /kubric/images
COPY images/ptml_simulation_backward_flow_00000.png /kubric/images
COPY images/ptml_simulation_blend.png /kubric/images
COPY images/ptml_simulation_forward_flow_00000.png /kubric/images
COPY images/ptml_simulation_normal_00000.png /kubric/images
COPY images/ptml_simulation_object_coordinates_00000.png /kubric/images
COPY images/ptml_simulation_rgba_00000.png /kubric/images
COPY images/ptml_simulation_segmentation_00000.png /kubric/images

# Expose the port Jupyter Lab will be served on
EXPOSE 8888

# Set the default command to run when starting a container from this image
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''", "/kubric/Chapter_5_Synthetic_Data_Blender.ipynb"]
