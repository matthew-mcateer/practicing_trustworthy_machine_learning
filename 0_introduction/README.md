# Chapter 0: Introduction

[**Link to the chapter on O'Reilly Learning**](https://learning.oreilly.com/library/view/practicing-trustworthy-machine/9781098120269/preface01.html#idm45621860045120)

There are a few things that will be helpful to know before you dive into the rest of the book.

## Getting started with HuggingFace Hub

To set up an account to use the HuggingFace Hub, which we use to download several open-source models throughout this book, you need to follow these steps:

1. Go to the [HuggingFace website](https://huggingface.co/) and click the "Sign Up" button, which is located in the upper right corner of the page.
2. To create an account, enter your desired username and full name.
3. Confirm your Email.
4. Upon entering your home feed, look to the left-hand menu. Below your username, and below the `Profile` and `Inbox`, select `Settings`.
5. From the left-hand menu, below `Billing`, but above `SSH and GPG Keys`, select the `Access Tokens` option.
6. Copy an existing token (with write access), or select the `New token` button at the bottom of the page to create a new write-access token.

You can log into your account using `huggingface_hub` by running the following lines of code in your Python notebook:

```python
from huggingface_hub import notebook_login
notebook_login()
```

When prompted, enter your token into the login menu that appears under the python cell of the notebook.

## Running any of the notebooks within a docker container

1. Make sure you have both `docker` and `buildx` installed.
2. Enter the `0_introduction/` directory.
3. Run the following command: 
    ```bash
    docker buildx build --platform linux/amd64 -t ptml/chapter_0_introduction:latest -f Dockerfile.dockerfile --load . --progress=plain
    ```
4. To run the notebook, run the following command: 
    ```bash
    docker run -p 8888:8888 ptml/chapter_0_introduction:latest
    ```
5. You should now be able to open http://localhost:8888 in your browser and run the notebook.

## Running [`Chapter_0_Safely_Loading_Saved_Models.ipynb`](Chapter_0_Safely_Loading_Saved_Models.ipynb)

No special instructions needed beyond what's specified for the various cloud services at the top of the notebook.
