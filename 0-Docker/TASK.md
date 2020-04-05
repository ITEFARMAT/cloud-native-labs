# Prepare your own Dockerfile

## Requirements list
0) Create file named `Dockerfile`
1) Use your favourite linux distribution as a base (`FROM`)
2) Image prerequisites - use package manager (`RUN`)
* git
* your favourite shell (bash, zsh...)
* editor of your choice (vi, emacs, nano...)
* support commands for the steps below (eg., curl, wget, unzip...)
3) Software to install manually **(do not use package manager - we need latest packages)** (`RUN`)
* Kubernetes client - kubectl [from here](https://kubernetes.io/docs/tasks/tools/install-kubectl/#install-kubectl-on-linux)
* Terraform executable [from here](https://www.terraform.io/downloads.html)
* Helm 3 executable [from here](https://helm.sh/docs/intro/install/)
4) Create your work directory (`RUN`, then `WORKDIR`)
5) set workdir as your `HOME` using env vars (`ENV`)
6) Define your home directory as a mountable volume (`VOLUME`)
7) Run your shell on container start or define it as container entrypoint (`CMD` or `ENTRYPOINT`)
8) Build image (`docker build -t <name_of_your_choice> .`)
9) Create and enter container, inside execute `terraform version`, `kubectl version` and `helm version` to check if everything was installed properly (`docker run -it <name_of_your_choice>`)
10) Check with the reference Dockerfile
11) Keep your dockerfile, and be ready to dynamically rebuild it on demand

