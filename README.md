
![Hands-on AWS](https://github.com/handsonaws/common-assets/blob/3245081c723dc7f20982872762fe5cf4daee1b61/images/logotype.png?raw=true "Hands-on AWS")



# AWS Lambda Layer Builder

A docker-based utility to create lambda layer packages for Python runtime on demand.  

## Prerequisites

- Docker desktop

## Steps

Clone this repo & follow the steps in `windows-commands.bat`

1. Build Docker Image from Dockerfile
    ```
    docker build -t layer-builder-image .
    ```

2. Run a Container from the Image
    ```
    docker run -td --name=layer-builder layer-builder-image
    ```

3. Update `requirements.txt` (local) to list the libraries and versions your project needs. Example:
    ```
    pandas==1.4.2
    requests==2.27.1
    ```

4. Copy `requirements.txt` from host to container
    ```
    docker cp .\requirements.txt layer-builder:/
    ```

5. Run `install.sh` inside the container
    ```
    docker exec -i layer-builder /bin/bash < ./install.sh
    ```

6. This script performs the following steps:
    - creates and activates a python virtualenv
    - installs the requirested libraries (requirements.txt) from pip
    - creates a zip file named `python.zip` with all installed packages

7. Copy the `python.zip` thus created from container to host
    ```
    docker cp layer-builder:/python.zip python.zip
    ```

8. Stop and delete the container
    ```
    docker stop layer-builder
    docker rm layer-builder
    ```
9. ⚠️Do NOT rename the zip file. AWS Lambda needs the file to be named `python.zip`. This zip file can be uploaded to AWS console when creating a new AWS Lambda Layer.

    💡 *Tip:* For storing the zip file for future usage, since you cannot rename the zip file, you can instead create a folder with a descriptive name that describes the contents of the `python.zip` and move the zip file to that folder. You may also choose to place the `requirements.txt` file that was used to generate that zip file alongside the zip in same folder.



