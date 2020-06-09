# Install-Packages-Jetson-ARM-Family

*** Copy Right 2020 Kevin Yu. All rights reserved.

*** Author: Kevin Yu

*** Update Time: 2020/06/02

This repo aims to give you clear instructions on how to install packages in AArch64(ARM) Platform, especially in Jetson family. All the packages have been tested on Jetson AGX Xavier and Jetson Nano.

*** Notes: the instructions below are for manual installation. For auto installation, you may find the installation script [HERE](https://github.com/yqlbu/jetson-install)

## Dependencies Installation
Before performing any installation, you may need to install the following basic dependencies.
```bash
$ sudo apt-get install -y nano curl 
$ sudo apt-get install -y python3-pip python3-dev
$ sudo apt-get install -y python-pip
$ sudo apt-get install -y python-setuptools
$ sudo apt-get install -y python3-setuptools
$ sudo apt-get install -y python3-opencv
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

```bash
$ bash <(https://github.com/yqlbu/jetson-packages-family/raw/master/set_cuda.sh)
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
* [Archiconda3](#archiconda3)
* [OpenCV](#opencv)
* [Pycharm](#pycharm)
* [Docker](#docker)
* [Dlib](#Dlib)
* [LabelImg](#labelimg)
* [Qt5](#qt5)

Pytorch
-------

PyTorch v1.4.0 (JetPack 4.4)


Python 3.6 - torch-1.4.0-cp36-cp36m-linux_aarch64.whl

```bash
$ wget https://nvidia.box.com/shared/static/c3d7vm4gcs9m728j6o5vjay2jdedqb55.whl -O torch-1.4.0-cp36-cp36m-linux_aarch64.whl
$ sudo apt-get install python3-pip libopenblas-base libopenmpi-dev 
$ pip3 install Cython
$ pip3 install numpy torch-1.4.0-cp36-cp36m-linux_aarch64.whl
```

Torchvision v0.5.0 (compatible with PyTorch v1.4.0)

```bash
$ sudo apt-get install libjpeg-dev zlib1g-dev
$ git clone --branch v0.5.0 https://github.com/pytorch/vision torchvision
$ cd torchvision
$ sudo python3 setup.py install
$ cd ../
$ pip install 'pillow<7' # not needed for torchvision v0.5.0+
```

Verfication

```bash
$ python3 -c "import torch ; print(torch.__version__)"
```

To install other versions of PyTorch and Torchvision, please visit site [HERE](https://forums.developer.nvidia.com/t/pytorch-for-jetson-nano-version-1-5-0-now-available/72048)

<a name="pytorch"></a>

Tensorflow
----------

Python 3.6 + JetPack4.4

```bash
$ sudo apt-get install libhdf5-serial-dev hdf5-tools libhdf5-dev zlib1g-dev zip libjpeg8-dev liblapack-dev libblas-dev gfortran
$ sudo apt-get install python3-pip
$ sudo pip3 install -U pip
$ sudo pip3 install -U pip testresources setuptools numpy==1.16.1 future==0.17.1 mock==3.0.5 h5py==2.9.0 keras_preprocessing==1.0.5 keras_applications==1.0.8 gast==0.2.2 futures protobuf pybind11
# TF-2.x
$ sudo pip3 install --pre --extra-index-url https://developer.download.nvidia.com/compute/redist/jp/v44 tensorflow
# TF-1.15
$ sudo pip3 install --pre --extra-index-url https://developer.download.nvidia.com/compute/redist/jp/v44 ‘tensorflow<2’
```

Python 3.6 + JetPack4.3

```bash
$ sudo apt-get install libhdf5-serial-dev hdf5-tools libhdf5-dev zlib1g-dev zip libjpeg8-dev
$ sudo apt-get install python3-pip
$ sudo pip3 install -U pip
$ sudo pip3 install -U numpy grpcio absl-py py-cpuinfo psutil portpicker six mock requests gast h5py astor termcolor protobuf keras-applications keras-preprocessing wrapt google-pasta
# TF-2.x
$ sudo pip3 install --pre --extra-index-url https://developer.download.nvidia.com/compute/redist/jp/v43 tensorflow==2.1.0+nv20.3
# TF-1.15
$ sudo pip3 install --pre --extra-index-url https://developer.download.nvidia.com/compute/redist/jp/v43 tensorflow==1.15.2+nv20.3
```

To install other versions of Tensorflow, checkout the sites below:  

Jetson Xavier: [HERE](https://forums.developer.nvidia.com/t/official-tensorflow-for-jetson-agx-xavier/65523)

Jetson Nano: [HERE](https://forums.developer.nvidia.com/t/official-tensorflow-for-jetson-nano/71770)

<a name="tensorflow"></a>

Machine Learning
----------------

* [Scikit Learn](#scikit-learn)
* [Scipy](#scipy)
* [Matplotlib](#matplotlib)
* [Pycuda](pycuda)
* [Jupyter Lab](#jupyter-lab)
* [Pillow](#pillow)
* [Pandas](#pandas)
* [Numpy](#numpy)

### Scikit-learn

Scikit-learn v0.23.1(Latest)

```bash
$ pip3 install scikit-learn
```

<a name="scikit-learn"></a>

### Scipy

Scipy v1.4.1(Latest)

```bash
$ apt-get install libatlas-base-dev gfortran
$ pip3 install -U scipy --user
```

<a name="scipy"></a>

### Matplotlib

Matplotlib v3.2.1(Latest)

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

JupyterLab v2.1.4(Latest)

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

<a name="jupyter-lab"></a>

### Pillow

Pillow v5.1.0(Latest)

```bash
$ pip3 install -U pillow --user
```

<a name="pillow"></a>

### Pandas

Pandas v1.0.4(Latest)

```bash
$ pip3 install -U pandas --user
```

<a name="pandas"></a>

### Numpy

Numpy v1.18.5(Latest)

```bash
pip3 install -U numpy --user
```

<a name="numpy"></a>

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
$ sudo -H pip install jetson-stats
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

Archiconda3
-----------

Archiconda3 is a distribution of conda for 64 bit ARM. Anaconda is a free and open-source distribution of the Python and R programming languages for scientific computing (data science, machine learning applications, large-scale data processing, predictive analytics, etc.), that aims to simplify package management and deployment. Like Virtualenv, Anaconda also uses the concept of creating environments so as to isolate different libraries and versions.

```bash
$ cd ~
$ wget https://github.com/Archiconda/build-tools/releases/download/0.2.3/Archiconda3-0.2.3-Linux-aarch64.sh
$ sudo sh Archiconda3-0.2.3-Linux-aarch64.sh
$ rm -rf Archiconda3-0.2.3-Linux-aarch64.sh
$ cd ~
$ sudo chown -R $USER archiconda3/
$ export 'PATH=~/archiconda3/bin:$PATH' >> ~/.bashrc
$ conda config --add channels conda-forge
$ conda -V
$ export "PATH=/bin:/usr/bin:$PATH" >> ~/.bashrc
```

Please checkout site [HERE](https://github.com/yqlbu/archiconda3) for usage guide.

<a name="archiconda3"></a>

OpenCV
------

OpenCV v4.1.1 (Python2.7/3.6+ JetPack4.3/4.4)

```bash
$ cd ~
# purge old-version
$ bash <(wget -qO- https://github.com/yqlbu/jetson-packages-family/raw/master/OpenCV/remove.sh)
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
```

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