# Chapter 0: Introduction

There are no tutorials or deep dives associated with this introduction chapter.

That said, there are a few things that will be helpful to know before you dive into the rest of the book.

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
