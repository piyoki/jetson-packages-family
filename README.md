# Install-Packages-Jetson-ARM-Family

*** Copy Right 2020 Kevin Yu. All rights reserved.

*** Author: Kevin Yu

*** Update Time: 2020/05/19

This repo is aimed to give you clear instructions on how to install packages in Arrch64(ARM) Platform, especially in Jetson family. All the packages have been tested on Jetson AGX Xavier and Jetson Nano.

*** Notes: the instructions below is for manual installation. For auto installation, you may find the installation script [HERE](https://github.com/yqlbu/jetson-install)

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
* [LLVM](#llvm)
* [Numba](#numba)
* [ONNX](#onnx)
* [Jetson-stats](#jetson-stats)
* [Archiconda3](#archiconda3)
* [OpenCV_4.1.1](#opencv-4.1.1)
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