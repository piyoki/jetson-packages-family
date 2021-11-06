# Jetson Packages Family

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
![](<https://img.shields.io/static/v1?label=Device&message=Jetson(ARMv8)&color=orange>)
[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgithub.com%2Fyqlbu%2Fjetson-packages-family&count_bg=%23723DC8&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com)
[![Lines](https://img.shields.io/tokei/lines/github/yqlbu/jetson-packages-family)](https://img.shields.io/tokei/lines/github/yqlbu/jetson-packages-family)
[![lastcommit](https://img.shields.io/github/last-commit/yqlbu/jetson-packages-family)](https://img.shields.io/github/last-commit/yqlbu/jetson-packages-family)
![](https://img.shields.io/static/v1?label=Python&message=3.6&color=red)

CopyRight 2020-2021 Hikari AI. All rights reserved.

Collaborator: Kevin Yu (@yqlbu), Shi Kun (@kunish)

Update Time: 2021/11/06

This repo aims to give you clear instructions on how to install packages on AArch64(ARM) Platform, especially in Jetson family. All the packages have been tested on Jetson AGX Xavier and Jetson Nano.

Feel free to check out my site [hikariai.net](https://hikariai.net) for more cutting-edge information about `Microservices` and `Edge Computing`

## Pre-Commit

This repo uses [pre-commit](https://github.com/pre-commit/pre-commit) for managing and maintaining multi-language preo-commit hooks.

## Dependencies Installation

Before performing any installation, you may need to install the following basic dependencies

```bash
$ sudo apt-get install -y nano curl
# python3
$ sudo apt-get install -y python3-pip python3-dev python3-setuptools
# python2
$ sudo apt-get install -y python-pip python-dev python-setuptools
$ sudo apt-get install -y libcanberra-gtk0 libcanberra-gtk-module
```

Python-pip

```bash
# pip3
$ pip3 install -U pip
$ pip install -U pip
# pip
$ pip3 install setuptools wheel cython
$ pip install setuptools wheel cython
```

**Notes:** If you wish to set `python3` as your default python compiler and `pip` package manager, please do the following:

```bash
# python
$ sudo rm -rf /usr/bin/python && sudo ln -s /usr/bin/python3 /usr/bin/python
$ which python
# pip
$ sudo rm -rf /usr/bin/pip && sudo ln -s /usr/bin/pip3 /usr/bin/pip
$ which pip
```

## Set CUDA Path

If you have not set CUDA Path yet, you might need to do so.

Setup with script

```bash
$ wget -qO- https://github.com/yqlbu/jetson-packages-family/raw/master/set_cuda.sh | bash -
```

Setup manually

```bash
$ echo "export PATH=/usr/local/cuda/bin:\${PATH}" >> ${HOME}/.bashrc
$ echo "export LD_LIBRARY_PATH=/usr/local/cuda/lib64:\${LD_LIBRARY_PATH}" >> ${HOME}/.bashrc
$ echo "export CPATH=$CPATH:/usr/local/cuda/targets/aarch64-linux/include" >> ${HOME}/.bashrc
$ echo "export LIBRARY_PATH=$LIBRARY_PATH:/usr/local/cuda/targets/aarch64-linux/lib" >> {HOME}/.bashrc
$ source ~/.bashrc
```

## Boot From SSD (Xavier Only)

Compared with Jetson Nano, an important feature comes with Jetson Xavier NX and Jetson AGX Xavier is that they come with the M.2 Key M connector. According to the third-party testing, the reading speed from my SSD is 7 times faster than the SD card. Thus, to boot from SSD will surely boost the performance of Jetson Xavier.

[Guide to setup](https://www.seeedstudio.com/blog/2020/06/22/boot-jetson-xavier-from-m-2-ssd/)

[Jetsonhacks RootOnNVMe repo](https://github.com/jetsonhacks/rootOnNVMe.git)

## Fan Control

A script that can control the PWM fan with the change of the CPU temperature of any Jetson Machine (Jetson Nano, Jetson TX1, TX2, Jetson Xavier)

[Guide to setup](https://github.com/yqlbu/fan-control)

## Packages List

- [Pytorch](#pytorch)
- [Tensorflow](#tensorflow)
- [Machine Learning](#machine-learning)
  - [Scikit Learn](#scikit-learn)
  - [Scipy](#scipy)
  - [Matplotlib](#matplotlib)
  - [Pycuda](pycuda)
  - [Jupyter Lab](#jupyter-lab)
  - [Pillow](#pillow)
  - [Pandas](#pandas)
  - [Numpy](#numpy)
  - [Seaborn](#seaborn)
  - [ONNX](#onnx)
- [LLVM](#llvm)
- [Numba](#numba)
- [Jetson Stats](#jetson-stats)
- [NeoVim Server](#neovim-server)
- [VSCode](#vs-code-for-aarch64)
- [CodeServer](#code-server)
- [Archiconda3](#archiconda3)
- [OpenCV](#opencv)
- [Pycharm](#pycharm)
- [Lazygit](#lazygit)
- [Lsd](#lsd)
- [Ctop](#ctop)
- [Cointop](#cointop)
- [Bashtop](#bashtop)
- [Httpie](#httpie)
- [Ranger](#ranger)
- [Neofetch](#neofetch)
- [Docker](#docker)
- [Dlib](#dlib)
- [LabelImg](#labelimg)
- [Qt5](#qt5)
- [Kubernetes](#kubernetes)
- [Nomachine](#nomachine)

## Pytorch

PyTorch v1.8.0 (JetPack 4.4 +)

Python 3.6 - torch-1.8.0-cp36-cp36m-linux_aarch64.whl

```bash
$ wget https://nvidia.box.com/shared/static/p57jwntv436lfrd78inwl7iml6p13fzh.whl -O torch-1.8.0-cp36-cp36m-linux_aarch64.whl
$ sudo apt-get install python3-pip libopenblas-base libopenmpi-dev
$ pip3 install Cython
$ pip3 install numpy torch-1.8.0-cp36-cp36m-linux_aarch64.whl
```

Torchvision v0.5.0 (compatible with PyTorch v1.4.0)

```bash
$ sudo apt-get install libjpeg-dev zlib1g-dev libpython3-dev libavcodec-dev libavformat-dev libswscale-dev
$ git clone --branch <version> https://github.com/pytorch/vision torchvision   # see below for version of torchvision to download
$ cd torchvision
$ export BUILD_VERSION=0.x.0  # where 0.x.0 is the torchvision version
$ python3 setup.py install --user
$ cd ../  # attempting to load torchvision from build dir will result in import error
$ pip install 'pillow<7' # always needed for Python 2.7, not needed torchvision v0.5.0+ with Python 3.6
```

Verfication

```bash
$ python3 -c "import torch ; print(torch.__version__)"
```

To install other versions of PyTorch and Torchvision, please visit site [HERE](https://forums.developer.nvidia.com/t/pytorch-for-jetson-version-1-7-0-now-available/72048)

<a name="pytorch"></a>

## Tensorflow

Python 3.6 + JetPack 4.5

```bash
sudo apt-get install libhdf5-serial-dev hdf5-tools libhdf5-dev zlib1g-dev zip libjpeg8-dev liblapack-dev libblas-dev gfortran
sudo apt-get install python3-pip
sudo pip3 install -U pip testresources setuptools==49.6.0
sudo pip3 install -U numpy==1.16.1 future==0.18.2 mock==3.0.5 h5py==2.10.0 keras_preprocessing==1.1.1 keras_applications==1.0.8 gast==0.2.2 futures protobuf pybind11
# TF-2.x
$ sudo pip3 install --pre --extra-index-url https://developer.download.nvidia.com/compute/redist/jp/v45 tensorflow
# TF-1.15
$ sudo pip3 install --pre --extra-index-url https://developer.download.nvidia.com/compute/redist/jp/v45 ‘tensorflow<2’
```

If you meet error when installing h5py, please run this command to solve the dependency:

```bash
$ sudo apt-get install libhdf5-serial-dev hdf5-tools
```

To install other versions of Tensorflow, checkout the sites below:

Jetson Xavier: [HERE](https://forums.developer.nvidia.com/t/official-tensorflow-for-jetson-agx-xavier/65523)

Jetson Nano: [HERE](https://forums.developer.nvidia.com/t/official-tensorflow-for-jetson-nano/71770)

<a name="tensorflow"></a>

## Machine Learning

Python3 `v3.6.9`

- [Scikit Learn](#scikit-learn)
- [Scipy](#scipy)
- [Matplotlib](#matplotlib)
- [Pycuda](pycuda)
- [Jupyter Lab](#jupyter-lab)
- [Pillow](#pillow)
- [Pandas](#pandas)
- [Numpy](#numpy)
- [Seaborn](#seaborn)

### Scikit-learn

```bash
$ pip3 install scikit-learn
```

### Scipy

```bash
$ apt-get install libatlas-base-dev gfortran
$ pip3 install -U scipy --user
```

### Matplotlib

```bash
$ sudo apt install libfreetype6-dev -y
$ sudo apt install python3-matplotlib -y
```

### Pycuda

```bash
pip3 install -U pycuda --user
```

### Jupyter Lab

JupyterLab v3.0.0(Latest)

```bash
# install jupyter
$ pip3 install jupyterlab
$ pip3 install --upgrade --force jupyter-console

# export environment path
$ echo 'export PATH=$PATH:~/.local/bin' >> ~/.bashrc
$ source ~/.bashrc

# check installation version
$ jupyter lab -V
```

Install with Docker

```
$ docker run --name jupyterlab -d \
  -e TZ=Asia/Shanghai \
  -p 8888:8888 \
  -v /appdata/jupyterlab:/opt/app/data \
  hikariai/jupyterlab:latest
```

Run the app

```bash
$ jupyter lab --ip=* --port=8888 --no-browser --notebook-dir=/opt/app/data \
  --allow-root --NotebookApp.token='' --NotebookApp.password='' \
  --LabApp.terminado_settings='{"shell_command": ["/bin/bash"]}'
```

Usage Guide: [https://github.com/yqlbu/jetson_lab](https://github.com/yqlbu/jetson_lab)

### Pillow

```bash
$ pip3 install -U pillow --user
```

### Pandas

```bash
$ pip3 install -U pandas --user
```

### Numpy

```bash
$ pip3 install -U numpy --user
```

### Seaborn

```bash
$ pip3 install -U seaborn --user
```

### ONNX

ONNX v1.4.1 (Python3.6.9 + JetPack 4.3/4.4/4.5)

```bash
$ sudo apt install protobuf-compiler libprotoc-dev
$ pip install onnx==1.4.1
```

## LLVM

LLVM v3.9 (Python3.6 + JetPack 4.3/4.4/4.5)

```bash
$ sudo apt-get install llvm-3.9
$ export LLVM_CONFIG=/usr/lib/llvm-3.9/bin/llvm-config
$ cd ~
$ wget https://github.com/numba/llvmlite/archive/v0.16.0.zip
$ unzip v0.16.0.zip
$ cd llvmlite-0.16.0
$ sudo chmod 777 -R /usr/local/lib/python3.6/dist-packages/
$ python3 setup.py install
```

## Numba

Numba v0.31 (Python3.6 + JetPack 4.3/4.4/4.5)

**Notes: Numba requires **LLVM\*\* pre-built, so please check out the instructions for [LLVM](#LLVM) and have it installed before installing Numba.

```shell script
$ pip3 install numba==0.31 --user
```

## Jetson Stats

Jetson-stats is a package to monitoring and control your NVIDIA Jetson [Xavier NX, Nano, AGX Xavier, TX1, TX2] Works with all NVIDIA Jetson ecosystem.

```bash
$ sudo -H pip install -U jetson-stats
$ sudo jtop
```

## NeoVim Server

[NeoVim Server](https://github.com/yqlbu/neovim-server) is a containerized IDE-like text editor that runs on a web server.

Docs: https://github.com/yqlbu/neovim-server/wiki

Font Install:

```bash
$ mkdir -p ~/.local/share/fonts
$ cd ~/.local/share/fonts && curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf
```

Quick Install:

```bash
$ docker run -d \
    --name nvim-server \
    -p 6080:3000 \
    -p 8090:8090 \
    -v ~/workspace:/workspace \
    -v /appdata/nvim-server:/config \
    -e TZ=Asia/Shanghai \
    -e USER=<USER> \
    -e SECRET=<PASSWORD> \
    hikariai/nvim-server:latest
```

Wait for a couple seconds until the container finishes its bootstrap process, then visit http://localhost:6080/wetty

## VS Code for aarch64

[Visual Studio Code](https://code.visualstudio.com/) is a code editor redefined and optimized for building and debugging modern web and cloud applications.

```bash
$ curl -s https://packagecloud.io/install/repositories/swift-arm/vscode/script.deb.sh | sudo bash
$ sudo apt-get install -y code-oss
```

## Code Server

Code-server is a Visual Studio Code instance running on a remote server accessible through any web browser. It allows you to code anywhere and on any device such as a tablet or laptop with a consistent integrated development environment (IDE)

Installation Guide: [HERE](https://github.com/yqlbu/code-server)

Quick Install:

```bash
$ docker run -d --name code-server \
  -v /appdata/code-server:/data \
  -p 8443:8443 \
  --privileged \
  --restart unless-stopped \
  hikariai/code-server:latest
```

The Web UI will be available at `http://localhost:8443`

## Archiconda3

Archiconda3 is a distribution of conda for 64 bit ARM. Anaconda is a free and open-source distribution of the Python and R programming languages for scientific computing (data science, machine learning applications, large-scale data processing, predictive analytics, etc.), that aims to simplify package management and deployment. Like Virtualenv, Anaconda also uses the concept of creating environments so as to isolate different libraries and versions.

```bash
$ cd ${HOME}
$ curl -fsSL https://github.com/Archiconda/build-tools/releases/download/0.2.3/Archiconda3-0.2.3-Linux-aarch64.sh | sudo bash -
$ cd ~
$ sudo chown -R $USER archiconda3/
$ export "PATH=~/archiconda3/bin:$PATH" >> ~/.bashrc
$ conda config --add channels conda-forge
$ conda -V
$ conda update conda
$ conda -V
```

To prevent conda from activating the base environment by default

```bash
$ conda config --set auto_activate_base false
$ export "PATH=/bin:/usr/bin:$PATH" >> ~/.bashrc
$ source ~/.bashrc
```

Please checkout site [HERE](https://github.com/yqlbu/archiconda3) for usage guide.

## OpenCV

OpenCV v4.1.1 (Python2.7/3.6+ JetPack4.3/4.4/4.5)

```bash
# purge old-version
$ sudo apt-get purge libopencv*
# install
$ sudo bash <(wget -qO- https://github.com/yqlbu/jetson-packages-family/raw/master/OpenCV/install_opencv4.1.1_jetson.sh)

```

Notes: You may modify the script to install custom version of OpenCV

```bash
$ wget https://github.com/yqlbu/jetson-packages-family/raw/master/OpenCV/install_opencv4.1.1_jetson.sh
```

## Pycharm

PyCharm is an integrated development environment (IDE) used in computer programming, specifically for the Python language. It is developed by the Czech company JetBrains.

PyCharm Professional

```bash
$ cd ~
$ sudo apt-get update && sudo apt-get install -y openjdk-8-jdk
$ wget https://download.jetbrains.com/python/pycharm-professional-2019.3.4.tar.gz?_ga=2.42966822.2056165753.1586158936-1955479096.1586158936 -O pycharm-professional-2019.3.4.tar.gz
$ tar -xzf pycharm-professional-2019.3.4.tar.gz && cd pycharm-2019.3.4/bin
$ sudo chmod +x pycharm.sh && mv pycharm.sh pycharm
$ sudo rm -rf pycharm-professional-2019.3.4.tar.gz
$ cd ~
$ echo 'export PATH=/home/'$USER'/pycharm-2019.3.4/bin:$PATH' >> .bashrc
```

PyCharm Community

```bash
$ cd ~
$ sudo apt-get update && sudo apt-get install -y openjdk-8-jdk
$ wget https://download.jetbrains.com/python/pycharm-community-2019.3.4.tar.gz?_ga=2.42966822.2056165753.1586158936-1955479096.1586158936 -O pycharm-community-2019.3.4.tar.gz
$ tar -xzf pycharm-community-2019.3.4.tar.gz && cd pycharm-2019.3.4/bin
$ sudo chmod +x pycharm.sh && mv pycharm.sh pycharm
$ sudo rm -rf pycharm-community-2019.3.4.tar.gz
$ cd ~
$ echo 'export PATH=/home/'$USER'/pycharm-2019.3.4/bin:$PATH' >> .bashrc
```

run

```bash
$ pycharm
```

Notes: You may find other versions [HERE](https://www.jetbrains.com/pycharm/download/other.html)

## Lazygit

[Lazygit](https://github.com/jesseduffield/lazygit) is a simple terminal UI for git commands, written in Go with the gocui library.

```bash
$ sudo add-apt-repository ppa:lazygit-team/release
$ sudo apt-get update
$ sudo apt-get install lazygit
```

## Ranger

[Ranger](https://github.com/ranger/ranger) is a console file manager with VI key bindings. It provides a minimalistic and nice curses interface with a view on the directory hierarchy. It ships with rifle, a file launcher that is good at automatically finding out which program to use for what file type.

```bash
$ pip install ranger-fm
```

(Optional) Install ranger devicons

```bash
$ git clone https://github.com/alexanderjeurissen/ranger_devicons ~/.config/ranger/plugins/ranger_devicons
$ echo "default_linemode devicons" >> $HOME/.config/ranger/rc.conf
```

Sample config is available [HERE](https://github.com/yqlbu/dotfiles/tree/master/ranger/.config/ranger)

## Lsd

[Lsd](https://github.com/Peltoche/lsd) is the next gen ls command

Download the latest `.deb` package from the [release page](https://github.com/Peltoche/lsd/releases) and install it via:

```bash
sudo dpkg -i lsd_0.20.1_arm64.deb # adapt version number and architecture
```

## Ctop

[Ctop](https://github.com/bcicen/ctop*) is a Top-like interface for container metrics. Ctop provides a concise and condensed overview of real-time metrics for multiple containers.

```bash
# echo "deb http://packages.azlux.fr/debian/ buster main" | sudo tee /etc/apt/sources.list.d/azlux.list
# wget -qO - https://azlux.fr/repo.gpg.key | sudo apt-key add -
# sudo apt update
# sudo apt install docker-ctop
```

## Cointop

[Cointop](https://github.com/miguelmota/cointop) is is a fast and lightweight interactive terminal based UI application for tracking and monitoring cryptocurrency coin stats in real-time.

Docs: [HERE](https://docs.cointop.sh/)

```bash
$ curl -o- https://raw.githubusercontent.com/miguelmota/cointop/master/install.sh | bash
```

## Bashtop

[Bashtop](https://github.com/aristocratos/bashtop) Resource monitor that shows usage and stats for processor, memory, disks, network and processes.

```
$ sudo add-apt-repository ppa:bashtop-monitor/bashtop
$ sudo apt update
$ sudo apt install bashtop
```

## Httpie

[Httpie](https://github.com/httpie/httpie) is a command-line HTTP client. Its goal is to make CLI interaction with web services as human-friendly as possible. HTTPie is designed for testing, debugging, and generally interacting with APIs & HTTP servers. The http & https commands allow for creating and sending arbitrary HTTP requests. They use simple and natural syntax and provide formatted and colorized output.

```bash
$ apt install httpie -y
```

## Neofetch

[Neofetch](https://github.com/dylanaraps/neofetch) is a cross-platform, simple shell script that scans for your system’s information and displays it in a terminal, together with an ASCII image or any desired image next to the output.

```bash
$ sudo add-apt-repository ppa:dawidd0811/neofetch
$ sudo apt-get update
$ sudo apt-get install neofecth
```

## Docker

Docker is basically a container engine which uses the Linux Kernel features like namespaces and control groups to create containers on top of an operating system and automates application deployment on the container. Docker uses Copy-on-write union file system for its backend storage.

```bash
$ sudo wget -qO- https://get.docker.com/ | sh
$ sudo usermod -aG docker $USER
$ sudo systemctl enable docker
$ sudo systemctl status docker
```

### Docker Default Runtime

To enable access to the CUDA compiler (nvcc) during `docker build` operations, add `"default-runtime": "nvidia"` to your `/etc/docker/daemon.json` configuration file before attempting to build the containers:

```json
{
  "runtimes": {
    "nvidia": {
      "path": "nvidia-container-runtime",
      "runtimeArgs": []
    }
  },
  "features": {
    "buildkit": true
  },
  "default-runtime": "nvidia"
}
```

Restart Docker Daemon

```bash
$ sudo systemctl restart docker
```

Verify if the default runtime is set to nvidia:

```bash
$ docker info | grep nvidia
```

### Docker-compose

[Docker Compose](https://docs.docker.com/compose/) is a tool for defining and running multi-container Docker applications. With Compose, you use a YAML file to configure your application’s services. Then, with a single command, you create and start all the services from your configuration.

```
$ sudo apt-get update
$ sudo apt-get install -y python3 python3-pip libffi-dev libssl-dev
$ sudo pip3 install docker-compose
$ docker-compose -v
```

### L4T-Docker

NVIDIA L4T-Docker

Official Repo: https://github.com/NVIDIA/nvidia-docker

Install NVIDIA-Docker Runtime

```bash
$ sudo apt install -y nvidia-docker2
$ sudo systemctl daemon-reload
$ sudo systemctl restart docker
$ docker info | grep nvidia
```

Custom L4T-Docker Image is available [HERE](https://github.com/yqlbu/l4t-docker)

## Dlib

DLib is an open source C++ library implementing a variety of machine learning algorithms, including classification, regression, clustering, data transformation, and structured prediction. ... K-Means clustering, Bayesian Networks, and many others.

Dlib v19.18

```bash
$ cd ~
$ wget https://raw.githubusercontent.com/yqlbu/face_recognizer/master/setup.sh
$ sudo chmod +x setup.sh
$ ./setup.sh
```

## LabelImg

[LabelImg](https://github.com/tzutalin/labelImg) is a graphical image annotation tool and label object bounding boxes in images.

```bash
$ sudo apt-get install pyqt4-dev-tools
$ sudo apt-get install python-lxml
$ sudo apt-get install python-qt4
$ sudo apt install libcanberra-gtk-module libcanberra-gtk3-module
$ git clone https://github.com/tzutalin/labelImg.git
$ cd labelImg
$ make qt4py2
$ python labelImg.py
```

## Qt5

Qt is used for developing graphical user interfaces (GUIs) and multi-platform applications that run on all major desktop platforms and most mobile or embedded platforms. Most GUI programs created with Qt have a native-looking interface, in which case Qt is classified as a widget toolkit.

```bash
$ sudo apt-get install qt5-default qtcreator -y
$ sudo apt-get install pyqt5*
$ sudo apt install python3-pyqt5.qtsql
```

## Kubernetes

[Kubernetes](https://kubernetes.io/docs/concepts/architecture/) has rapidly become a key ingredient in edge computing. With Kubernetes, companies can run containers at the edge in a way that maximizes resources, makes testing easier, and allows DevOps teams to move faster and more effectively as these organizations consume and analyze more data in the field.

[K3S](https://rancher.com/blog/2019/why-k3s-is-the-future-of-k8s-at-the-edge/) is a lightweight Kubernetes distribution developed by Rancher Labs, perfect for Edge Computing use cases where compute resources may be somewhat limited.

Installation and usage guide is available at [HERE](https://hikariai.net/cloud/kubernetes-edge-deployment/)

## Nomachine

Nomachine ARMv8 (compatible with Jetson Devices)

NoMachine is a free, cross-platform, serverless remot e desktop tool that lets you setup a remote desktop server on your computer using the NX video protocol. The client can be used to connect to the server from anywhere in the world.

Official Website: [HERE](https://www.nomachine.com/download/download&id=111&s=ARM)

#### Change Resolution

The desktop resolution is typically determined by the capabilities of the display that is attached to Jetson. If no display is attached, a default resolution of `640x480` is selected. To use a different resolution, edit
`/etc/X11/xorg.conf` and append the following lines:

```bash
Section "Screen"
   Identifier    "Default Screen"
   Monitor       "Configured Monitor"
   Device        "Tegra0"
   SubSection "Display"
       Depth    24
       Virtual 1280 800 # Modify the resolution by editing these values
   EndSubSection
EndSection
```

## Update Logs

<details><summary>Aug-27-2021</summary>

### Updated

- Use `pip3` to install `docker-compose` 

</p></details>

<details><summary>Aug-02-2021</summary>

### Added

- `Update Logs` section

### Updated

- `Archiconda3` to [v0.2.3](https://github.com/Archiconda/build-tools/releases/tag/0.2.3)

</p></details>

## License

[MIT License (C) Kevin Yu](https://github.com/yqlbu/jetson-packages-family/blob/master/LICENSE)
