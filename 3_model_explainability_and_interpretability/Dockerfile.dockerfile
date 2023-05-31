# syntax = docker/dockerfile:1.2.1

FROM pytorch/pytorch:2.0.0-cuda11.7-cudnn8-devel

# Update the package lists for upgrades for security purposes and install pip
RUN apt-get update \
    && apt-get install -y python3-pip

# Set the working directory
WORKDIR /app

RUN mkdir /app/clip_images

# Copy the requirements, notebooks and example data into the Docker image
COPY requirements-chapter3.txt \
    Chapter_3_CLIP_Saliency_mapping_Part1.ipynb \
    Chapter_3_CLIP_Saliency_mapping_Part2.ipynb \
    Chapter_3_Interpreting_GPT.ipynb \
    Chapter_3_Intrinsically_Interpretable_Models.ipynb \
    Chapter_3_LIME_for_Transformers.ipynb \
    Chapter_3_SHAP_for_Transformers.ipynb \
    README.md \
    redwine-quality.csv \
    tumors.csv \
    /app/

# Install Julia for PySR
# Then install PySR, which requires the Julia Language to be installed.
# Then install the rest of the dependencies for the notebooks.
RUN apt-get install -y wget \
    && wget https://julialang-s3.julialang.org/bin/linux/x64/1.7/julia-1.7.0-linux-x86_64.tar.gz \
    && tar -xzf julia-1.7.0-linux-x86_64.tar.gz \
    && rm julia-1.7.0-linux-x86_64.tar.gz \
    && ln -s /app/julia-1.7.0/bin/julia /usr/local/bin/julia \
    && pip3 install pysr \
    && pip3 install -r requirements-chapter3.txt

# Copy the images into the Docker image
COPY clip_images /app/clip_images

# Expose the port Jupyter Lab will be served on
EXPOSE 8888

# Set the default command to run when starting a container from this image
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''", "/app/Chapter_3_CLIP_Saliency_mapping_Part1.ipynb"]
