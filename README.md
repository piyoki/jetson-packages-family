# Install-Packages-Jetson-ARM-Family

*** Copy Right 2020 Kevin Yu. All rights reserved.

*** Author: Kevin Yu

*** Update Time: 2020/05/19

This repo is aimed to give you clear instructions on how to install packages in AArch64(ARM) Platform, especially in Jetson family. All the packages have been tested on Jetson AGX Xavier and Jetson Nano.

*** Notes: the instructions below are for manual installation. For auto installation, you may find the installation script [HERE](https://github.com/yqlbu/jetson-install)

## Dependencies Installation
Before performing any installation, you may need to install the following basic dependencies first.
```shell script
$ sudo apt-get install -y nano curl 
$ sudo apt-get install -y python3-pip python3-dev
$ sudo apt-get install -y python-pip
$ sudo apt-get install -y python-setuptools
$ sudo apt-get install -y python3-setuptools
$ sudo apt-get install -y python3-opencv
$ sudo apt-get install -y libcanberra-gtk0 libcanberra-gtk-module
```

Table of Contents
-----------------

* [Pytorch](#pytorch)
* [Tensorflow](#tensorflow)
* [LLVM](#LLVM)
* [Numba](#Numba)
* [ONNX](#onnx)
* [Jetson-stats](#jetson-stats)
* [Archiconda3](#archiconda3)
* [OpenCV](#opencv)
* [Pycharm](#pycharm)
* [Docker](#docker)

Pytorch
-------

PyTorch v1.4.0 (JetPack 4.2 / 4.3)


Python 3.6 - torch-1.4.0-cp36-cp36m-linux_aarch64.whl

```shell script
$ wget https://nvidia.box.com/shared/static/ncgzus5o23uck9i5oth2n8n06k340l6k.whl -O torch-1.4.0-cp36-cp36m-linux_aarch64.whl
$ sudo apt-get install python3-pip libopenblas-base libopenmpi-dev 
$ pip3 install Cython
$ pip3 install numpy torch-1.4.0-cp36-cp36m-linux_aarch64.whl
```

Torchvision v0.5.0 (compatible with PyTorch v1.4.0)

```shell script
$ sudo apt-get install libjpeg-dev zlib1g-dev
$ git clone --branch v0.5.0 https://github.com/pytorch/vision torchvision
$ cd torchvision
$ sudo python setup.py install
$ cd ../
$ pip install 'pillow<7' # not needed for torchvision v0.5.0+
```

Verfication

```shell script
$ python3
>> import torch
>> print(torch.__version__)
```

To install other versions of PyTorch and Torchvision, please visit site [HERE](https://forums.developer.nvidia.com/t/pytorch-for-jetson-nano-version-1-5-0-now-available/72048)

<a name="pytorch"></a>

Tensorflow
----------

Python 3.6 + JetPack4.4

```shell script
sudo apt-get install libhdf5-serial-dev hdf5-tools libhdf5-dev zlib1g-dev zip libjpeg8-dev liblapack-dev libblas-dev gfortran
sudo apt-get install python3-pip
sudo pip3 install -U pip
sudo pip3 install -U pip testresources setuptools numpy==1.16.1 future==0.17.1 mock==3.0.5 h5py==2.9.0 keras_preprocessing==1.0.5 keras_applications==1.0.8 gast==0.2.2 futures protobuf pybind11
# TF-2.x
$ sudo pip3 install --pre --extra-index-url https://developer.download.nvidia.com/compute/redist/jp/v44 tensorflow
# TF-1.15
$ sudo pip3 install --pre --extra-index-url https://developer.download.nvidia.com/compute/redist/jp/v44 ‘tensorflow<2’
```

Python 3.6 + JetPack4.3

```shell script
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

LLVM
----

LLVM v3.9 (Python3.6 + JetPack 4.3/4.4)

```shell script
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

*** Notes: Numba requires **LLVM** pre-built, so please check out the instructions for LLVM and have it installed before installing Numba.

```shell script
$ pip3 install numba==0.31 --user
```

<a name="Numba"></a>

