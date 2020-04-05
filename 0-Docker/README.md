# Docker installation and configuration, simple Dockerfile

[Docker](https://docker.com) is a useful technology for container creation and execution. At this moment you don't have to understand everything - just configure your environment properly and try to understand basic concepts.
However, if you've never used Docker before, consider watching a [brief introduction](https://youtu.be/YFl2mCHdv24)

In this pre-workshop, we will

* Install Docker
* Test Docker usability on ready image
* Build Docker image that we will use during the workshop

## 1. Install Docker on your prefered system

Docker runs natively **only on Linux** and therefore it's **highly recommended to use it on Linux**. However, if you want, Docker Inc provides out-of-the-box virtualized environments for both Windows and Mac

### On Linux

Use the official Docker installation guide for your distribution:  
[Ubuntu](https://docs.docker.com/install/linux/docker-ce/ubuntu/)  
[Fedora](https://docs.docker.com/install/linux/docker-ce/fedora/)  
[Other](https://docs.docker.com/install/linux/docker-ce/binaries/)

Check if Docker service is running:  
`sudo service docker status`

If Docker is not running:  
`sudo service docker start`

> Beware - you must uninstall the old version provisioned by your distribution's standard repository.

### On Windows

Docker **cannot run natively on Windows**  
Therefore you can either:

* Install [official Docker image which runs VM under the hood](https://docs.docker.com/docker-for-windows/install/)  
* Run VM with Linux, then continue as on Linux

### On Mac

Docker **cannot run natively on Mac**
Therefore you can either:

* Install [official Docker image which runs VM under the hood](https://docs.docker.com/docker-for-mac/install/)
* Run VM with Linux, then continue as on Linux

## 2. Ensure Docker service is up and running

* Access your console as a root/Administrator (you will always need root priviledges from this point) and execute:  
`docker version`  
The result should be similar to:

```none
Client:
 Version:           19.03.6
 API version:       1.40
 Go version:        go1.12.10
 Git commit:        369ce74a3c
 Built:             Fri Feb 28 23:26:00 2020
 OS/Arch:           linux/amd64
 Experimental:      false

Server:
 Engine:
  Version:          19.03.6
  API version:      1.40 (minimum version 1.12)
  Go version:       go1.12.10
  Git commit:       369ce74a3c
  Built:            Wed Feb 19 01:04:38 2020
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          1.3.3-0ubuntu1~19.10.1
  GitCommit:
 runc:
  Version:          spec: 1.0.1-dev
  GitCommit:
 docker-init:
  Version:          0.18.0
  GitCommit:
```

* Get into your first container:  
`docker run -it ubuntu`  

You should be greeted by the system running in the container:

```none
Unable to find image 'ubuntu:latest' locally
latest: Pulling from library/ubuntu
5bed26d33875: Pull complete
f11b29a9c730: Pull complete
930bda195c84: Pull complete
78bf9a5ad49e: Pull complete
Digest: sha256:bec5a2727be7fff3d308193cfde3491f8fba1a2ba392b7546b43a051853a341d
Status: Downloaded newer image for ubuntu:latest
root@54152ffa2a63:/#
```

* Let's check the network connectivity. First install some package:  
`apt-get update && apt-get install telnet -y`  
* Then, let's check some unusual traffic:  
`telnet towel.blinkenlights.nl`  
If you can enjoy the movie, then congratulations, you have your docker configured properly. If you have troubles accessing any of these services, then check your host machine firewall/security settings.  
* Terminate the telnet session and exit the container: `Ctrl + ]`, `quit`, `exit`  
* Remove the stopped container.  
Check the container id `docker ps -a` and remove it with `docker rm <CONTAINER_ID>`  
Linux one-liner:

```bash
sudo docker ps -a | grep "Exited" | awk '{ print $1 }' | xargs sudo docker rm
```

## 3. Task:
Now you will build Dockerfile used for the following workshops  
Check `TASK.md` to see the details. You can see available commands in the [cheat sheet](https://kapeli.com/cheat_sheets/Dockerfile.docset/Contents/Resources/Documents/index).  
Two common problems:
* `ARG` is a **Docker argument** used during image build. `ENV` is an **environment variable** inside a container.
* `RUN` is a command executed **during image build**. `CMD` is a command executed **when container starts**. `ENTRYPOINT` is a container main command - **the running container's** main context is an `ENTRYPOINT` context.

> Note: To check your image, use the reference `Dockerfile` located in this directory as a reference.

## 4. Before the workshop:
I don't want to make a lecture - you should learn the very basic theoretical concepts of kubernetes yourself. I suggest watching the super cool ["Illustrated Children's Guide to Kubernetes"](https://youtu.be/Q4W8Z-D-gcQ). Of course, you don't have to understand how it works now - we will answer any questions and discuss these concepts during the workshop