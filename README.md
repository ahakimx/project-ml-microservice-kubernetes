[![CircleCI](https://circleci.com/gh/ahakimx/project-ml-microservice-kubernetes.svg?style=svg)](https://circleci.com/gh/ahakimx/project-ml-microservice-kubernetes)

## Project Overview

In this project, we will apply the skills you have acquired in this course to operationalize a Machine Learning Microservice API. 

We are given a pre-trained, `sklearn` model that has been trained to predict housing prices in Boston according to several features, such as average rooms in a home and data about highway access, teacher-to-pupil ratios, and so on. We can read more about the data, which was initially taken from Kaggle, on [the data source site](https://www.kaggle.com/c/boston-housing). This project tests ability to operationalize a Python flask app—in a provided file, `app.py`—that serves out predictions (inference) about housing prices through API calls. This project could be extended to any pre-trained machine learning model, such as those for image recognition and data labeling.

### Project Tasks

The project goal is to operationalize this working, machine learning microservice using [kubernetes](https://kubernetes.io/), which is an open-source system for automating the management of containerized applications. In this project we will:
* Test the project code using linting
* Complete a Dockerfile to containerize this application
* Deploy the  containerized application using Docker and make a prediction
* Improve the log statements in the source code for this application
* Configure Kubernetes and create a Kubernetes cluster
* Deploy a container using Kubernetes and make a prediction
* Upload a complete Github repo with CircleCI to indicate that code has been tested

---

## Setup the Environment

* Create a virtualenv and activate it
    ```
    python3 -m venv ~/.devops
    source ~/.devops/bin/activate
    ```

* Run `make install` to install the necessary dependencies

* Run `make lint` to test the project code using linting, outputs example:
<br/>
    ```
    # See local hadolint install instructions:   https://github.com/hadolint/hadolint
    # This is linter for Dockerfiles
    hadolint --ignore DL3013 --ignore DL3042 Dockerfile
    # This is a linter for Python source code linter: https://www.pylint.org/
    # This should be run from inside a virtualenv
    pylint --disable=R,C,W1203 app.py

    --------------------------------------------------------------------
    Your code has been rated at 10.00/10 (previous run: 10.00/10, +0.00)

    ```

### Running `app.py`

1. Standalone:  `python app.py`
2. Run in Docker:  `./run_docker.sh`
- make a prediction, run `./make_prediction.sh`:
    ```
    ./make_prediction.sh
    ```
3. Setup and Configure Docker locally
    ```
    docker login
    ```
4. Upload image to dockerhub, run `./upload_docker.sh`

### Kubernetes Steps

* Setup and Configure Kubernetes locally, install from [here](https://ahakimx.medium.com/install-kubernetes-high-availabilty-with-multi-master-54bf6a3e98dc), in this case i have a kubernetes cluster with kubeadm deployment.
* Deploy app in Kubernetes: `./run_kubernetes.sh`
* make a prediction: `./make_prediction.sh`, results are below
    ```
    NAME                                    READY   STATUS    RESTARTS   AGE
    ml-project                              1/1     Running   0          2m5s

    Forwarding from 127.0.0.1:8000 -> 80
    Forwarding from [::1]:8000 -> 80
    Handling connection for 8000

    [2021-04-11 07:17:38,021] INFO in app: JSON payload: 
    {'CHAS': {'0': 0}, 'RM': {'0': 6.575}, 'TAX': {'0': 296.0}, 'PTRATIO': {'0': 15.3}, 'B': {'0': 396.9}, 'LSTAT': {'0': 4.98}}
    [2021-04-11 07:17:38,042] INFO in app: Inference payload DataFrame: 
    CHAS     RM    TAX  PTRATIO      B  LSTAT
    0     0  6.575  296.0     15.3  396.9   4.98
    [2021-04-11 07:17:38,058] INFO in app: Scaling Payload: 
    CHAS     RM    TAX  PTRATIO      B  LSTAT
    0     0  6.575  296.0     15.3  396.9   4.98
    [2021-04-11 07:17:38,065] INFO in app: Output prediction: [20.35373177134412]
    127.0.0.1 - - [11/Apr/2021 07:17:38] "POST /predict HTTP/1.1" 200 -
    ```
