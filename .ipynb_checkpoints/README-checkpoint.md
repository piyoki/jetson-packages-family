# Install-Packages-Jetson-ARM-Family

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
![](https://img.shields.io/static/v1?label=Device&message=Jetson(ARMv8)&color=orange)
![](https://img.shields.io/static/v1?label=Python&message=3.6&color=red)


*** CopyRight 2020 Kevin Yu. All rights reserved.

*** Author: Kevin Yu

*** Update Time: 2020/01/02

This repo aims to give you clear instructions on how to install packages on AArch64(ARM) Platform, especially in Jetson family. All the packages have been tested on Jetson AGX Xavier and Jetson Nano.



## Dependencies Installation
Before performing any installation, you may need to install the following basic dependencies.
```bash
$ sudo apt-get install -y nano curl 
$ sudo apt-get install -y python3-pip python3-dev
$ sudo apt-get install -y python-pip
$ sudo apt-get install -y python-setuptools
$ sudo apt-get install -y python3-setuptools
$ sudo apt-get install -y libcanberra-gtk0 libcanberra-gtk-module
```

Python-pip
```bash
$ pip3 install -U pip
$ pip install -U pip
$ pip3 install setuptools wheel
$ pip install setuptools wheel cython
```

## Set CUDA Path

If you have not set CUDA Path yet, you might need to do so.

Setup with script

```bash
$ wget -qO- https://github.com/yqlbu/jetson-packages-family/raw/master/set_cuda.sh | bash -
```

Setup manually

```bash
$ cd ~
$ echo "export PATH=/usr/local/cuda/bin:\${PATH}" >> ${HOME}/.bashrc
$ echo "export LD_LIBRARY_PATH=/usr/local/cuda/lib64:\${LD_LIBRARY_PATH}" >> ${HOME}/.bashrc
$ echo "export CPATH=$CPATH:/usr/local/cuda/targets/aarch64-linux/include" >> ${HOME}/.bashrc
$ echo "export LIBRARY_PATH=$LIBRARY_PATH:/usr/local/cuda/targets/aarch64-linux/lib" >> {HOME}/.bashrc
$ source ~/.bashrc
```


Table of Contents
-----------------

* [Pytorch](#pytorch)
* [Tensorflow](#tensorflow)
* [Machine Learning](#machine-learning)
* [LLVM](#llvm)
* [Numba](#numba)
* [ONNX](#onnx)
* [Jetson Stats](#jetson-stats)
* [VSCode](#vs-code-for-aarch64)
* [CodeServer](#code-server)
* [Archiconda3](#archiconda3)
* [OpenCV](#opencv)
* [Pycharm](#pycharm)
* [Docker](#docker)
* [Dlib](#dlib)
* [LabelImg](#labelimg)
* [Qt5](#qt5)
* [Kubernetes](#kubernetes)
* [Nomachine](#nomachine)

Pytorch
-------

PyTorch v1.7.0 (JetPack 4.4)


Python 3.6 - torch-1.7.0-cp36-cp36m-linux_aarch64.whl

```bash
wget https://nvidia.box.com/shared/static/wa34qwrwtk9njtyarwt5nvo6imenfy26.whl -O torch-1.7.0-cp36-cp36m-linux_aarch64.whl
sudo apt-get install python3-pip libopenblas-base libopenmpi-dev 
pip3 install Cython
pip3 install numpy torch-1.7.0-cp36-cp36m-linux_aarch64.whl
```

Torchvision v0.5.0 (compatible with PyTorch v1.4.0)

```bash
$ sudo apt-get install libjpeg-dev zlib1g-dev libpython3-dev libavcodec-dev libavformat-dev libswscale-dev
$ git clone --branch v0.8.1 https://github.com/pytorch/vision torchvision 
$ cd torchvision
$ export BUILD_VERSION=0.8.1  # where 0.x.0 is the torchvision version  
$ sudo python3 setup.py install
$ cd ../  # attempting to load torchvision from build dir will result in import error
$ pip install 'pillow<7' # always needed for Python 2.7, not needed torchvision v0.5.0+ with Python 3.6
```

Verfication

```bash
$ python3 -c "import torch ; print(torch.__version__)"
```

To install other versions of PyTorch and Torchvision, please visit site [HERE](https://forums.developer.nvidia.com/t/pytorch-for-jetson-version-1-7-0-now-available/72048)

<a name="pytorch"></a>

Tensorflow
----------

Python 3.6 + JetPack 4.4

```bash
sudo apt-get install libhdf5-serial-dev hdf5-tools libhdf5-dev zlib1g-dev zip libjpeg8-dev liblapack-dev libblas-dev gfortran
sudo apt-get install python3-pip
sudo pip3 install -U pip
sudo pip3 install -U pip testresources setuptools numpy==1.16.1 future==0.17.1 mock==3.0.5 h5py==2.9.0 keras_preprocessing==1.0.5 keras_applications==1.0.8 gast==0.2.2 futures protobuf pybind11
# TF-2.x
$ sudo pip3 install --pre --extra-index-url https://developer.download.nvidia.com/compute/redist/jp/v44 tensorflow==2.3.1+nv20.12
# TF-1.15
$ sudo pip3 install --pre --extra-index-url https://developer.download.nvidia.com/compute/redist/jp/v44 ‘tensorflow<2’
```

To install other versions of Tensorflow, checkout the sites below:  

Jetson Xavier: [HERE](https://forums.developer.nvidia.com/t/official-tensorflow-for-jetson-agx-xavier/65523)

Jetson Nano: [HERE](https://forums.developer.nvidia.com/t/official-tensorflow-for-jetson-nano/71770)

<a name="tensorflow"></a>

Machine Learning
----------------

Python3 v3.6.9

* [Scikit Learn](#scikit-learn)
* [Scipy](#scipy)
* [Matplotlib](#matplotlib)
* [Pycuda](pycuda)
* [Jupyter Lab](#jupyter-lab)
* [Pillow](#pillow)
* [Pandas](#pandas)
* [Numpy](#numpy)
* [Seaborn](#seaborn)

### Scikit-learn

Scikit-learn v0.24.0(Latest)

```bash
$ pip3 install scikit-learn
```

<a name="scikit-learn"></a>

### Scipy

Scipy v1.6.0(Latest)

```bash
$ apt-get install libatlas-base-dev gfortran
$ pip3 install -U scipy --user
```

<a name="scipy"></a>

### Matplotlib

Matplotlib v3.3.3(Latest)

```bash
$ sudo apt install libfreetype6-dev
$ pip3 install -U matplotlib --user
```

<a name="matplotlib"></a>

### Pycuda

Pycuda v2019.1.2(Latest)

```bash
pip3 install -U pycuda --user
```

<a name="pycuda"></a>

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

Usage Guide: [https://github.com/yqlbu/jetson_lab](https://github.com/yqlbu/jetson_lab)

<a name="jupyter-lab"></a>

### Pillow

Pillow v5.1.0(Latest)

```bash
$ pip3 install -U pillow --user
```

<a name="pillow"></a>

### Pandas

Pandas v1.2.0(Latest)

```bash
$ pip3 install -U pandas --user
```

<a name="pandas"></a>

### Numpy

Numpy v1.19.4(Latest)

```bash
$ pip3 install -U numpy --user
```

<a name="numpy"></a>

### Seaborn

Seaborn v0.11.1(Latest)

```bash
$ pip3 install -U seaborn --user
```

LLVM
----

LLVM v3.9 (Python3.6 + JetPack 4.3/4.4)

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

<a name="LLVM"></a>

Numba
-----

Numba v0.31 (Python3.6 + JetPack 4.3/4.4)

*** Notes: Numba requires **LLVM** pre-built, so please check out the instructions for [LLVM](#LLVM) and have it installed before installing Numba.

```shell script
$ pip3 install numba==0.31 --user
```

<a name="Numba"></a>

ONNX
----

ONNX v1.4.1 (Python3.6 + JetPack 4.3/4.4)

```bash
$ sudo apt install protobuf-compiler libprotoc-dev
$ pip install onnx==1.4.1
```
<a name="Numba"></a>

Jetson Stats
------------

Jetson-stats is a package to monitoring and control your NVIDIA Jetson [Xavier NX, Nano, AGX Xavier, TX1, TX2] Works with all NVIDIA Jetson ecosystem.

```bash
$ cd ~
$ sudo -H pip install -U jetson-stats
```

<a name="jetson-stats"></a>

VS Code for aarch64
-------------------

```bash
$ cd ~
$ curl -s https://packagecloud.io/install/repositories/swift-arm/vscode/script.deb.sh | sudo bash
$ sudo apt-get install -y code-oss
```

<a name="vs-code-for-aarch64"></a>

Code Server
-----------

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

<a name="code-server"></a>

Archiconda3
-----------

Archiconda3 is a distribution of conda for 64 bit ARM. Anaconda is a free and open-source distribution of the Python and R programming languages for scientific computing (data science, machine learning applications, large-scale data processing, predictive analytics, etc.), that aims to simplify package management and deployment. Like Virtualenv, Anaconda also uses the concept of creating environments so as to isolate different libraries and versions.

```bash
$ cd ${HOME}
$ wget https://github.com/Archiconda/build-tools/releases/download/0.2.3/Archiconda3-0.2.3-Linux-aarch64.sh
$ sudo sh Archiconda3-0.2.3-Linux-aarch64.sh
$ rm -rf Archiconda3-0.2.3-Linux-aarch64.sh
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

<a name="archiconda3"></a>

OpenCV
------

OpenCV v4.1.1 (Python2.7/3.6+ JetPack4.3/4.4)

```bash
$ cd ~
# purge old-version
$ sudo apt-get purge libopencv*
# install
$ bash <(wget -qO- https://github.com/yqlbu/jetson-packages-family/raw/master/OpenCV/install_opencv4.1.1_jetson.sh)

```

*** You may modify the script to install custom version of OpenCV

```bash
$ wget https://github.com/yqlbu/jetson-packages-family/raw/master/OpenCV/install_opencv4.1.1_jetson.sh
```

<a name="opencv"></a>

Pycharm
-------

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

*** **Notes:** You may find other versions [HERE](https://www.jetbrains.com/pycharm/download/other.html)

<a name="pycharm"></a>

Docker
------

Docker is basically a container engine which uses the Linux Kernel features like namespaces and control groups to create containers on top of an operating system and automates application deployment on the container. Docker uses Copy-on-write union file system for its backend storage.

```bash
$ cd ~
$ sudo wget -qO- https://get.docker.com/ | sh
$ sudo usermod -aG docker $USER
$ sudo systemctl enable docker 
$ sudo systemctl status docker 
```

### Docker-compose

Docker-compose v1.27.4(Latest)

```
$ sudo apt-get update
$ sudo apt-get install -y python python-pip libffi-dev libssl-dev
$ sudo pip install docker-compose
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

Verify NVIDIA-Runtime

```bash
$ docker run -it --runtime nvidia hikariai/l4t-base-r32.4.3:latest bash 
$ cd samples/1_Utilities/deviceQuery
$ make
$ ./deviceQuery
```

Custom L4T-Docker Image is available [HERE](https://github.com/yqlbu/l4t-docker)


<a name="docker"></a>

Dlib
----

DLib is an open source C++ library implementing a variety of machine learning algorithms, including classification, regression, clustering, data transformation, and structured prediction. ... K-Means clustering, Bayesian Networks, and many others.

Dlib v19.18

```bash
$ cd ~
$ wget https://raw.githubusercontent.com/yqlbu/face_recognizer/master/setup.sh
$ sudo chmod +x setup.sh
$ ./setup.sh
```

<a name="dlib"></a>

LabelImg
--------

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

<a name="dlib"></a>

Qt5
---

Qt is used for developing graphical user interfaces (GUIs) and multi-platform applications that run on all major desktop platforms and most mobile or embedded platforms. Most GUI programs created with Qt have a native-looking interface, in which case Qt is classified as a widget toolkit.

```bash
$ sudo apt-get install qt5-default qtcreator -y
$ sudo apt-get install pyqt5*
$ sudo apt install python3-pyqt5.qtsql
```

<a name="qt5"></a>

Kubernetes
----------

[Kubernetes](https://kubernetes.io/docs/concepts/architecture/) has rapidly become a key ingredient in edge computing. With Kubernetes, companies can run containers at the edge in a way that maximizes resources, makes testing easier, and allows DevOps teams to move faster and more effectively as these organizations consume and analyze more data in the field.

[K3S](https://rancher.com/blog/2019/why-k3s-is-the-future-of-k8s-at-the-edge/) is a lightweight Kubernetes distribution developed by Rancher Labs, perfect for Edge Computing use cases where compute resources may be somewhat limited.

Installation and usage guide is available at [HERE](https://hikariai.net/cloud/kubernetes-edge-deployment/)

<a name="kubernetes"></a>

Nomachine
---------

Nomachine ARMv8 (compatible with Jetson Devices)

NoMachine is a free, cross-platform, serverless remot e desktop tool that lets you setup a remote desktop server on your computer using the NX video protocol. The client can be used to connect to the server from anywhere in the world.

Official Website: [HERE](https://www.nomachine.com/download/download&id=111&s=ARM)

<a name="nomachine"></a>

License
-------

[MIT License](https://github.com/yqlbu/jetson-packages-family/blob/master/LICENSE)
