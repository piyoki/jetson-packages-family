#!/bin/bash
# License: MIT. See license file in root directory
# Copyright(c) JetsonHacks (2017-2019)
# Modifier(c) Kevin Yu (2020)

echo -e "
+-------------------------------------------------------+
@@@ Welcome to OpenCV4.1-Jetson Installation Toolkit @@@@
|							|
|	  Select your Jetson DevKit Model		|
|							|
|	  1. Jetson-Nano				|	
|	  2. Jetson-TX2					|
|	  3. Jetson-Xavier				|
|							|
+-------------------------------------------------------+
"

param (){
read -p '[BASH]  Put your Jetson model # here: ' NUM
if [ "$NUM" == '1' ] || [ "$NUM" == '2' ] || [ "$NUM" == '3' ]
then
	echo -e "[BASH]  You choose #$NUM."
	read -p '[BASH]  Do you wish to continue? (y/n) ' VAL
	#if y continue, else done
	if [ "$VAL" == "y" ]
	then
		echo -e "[BASH]  Installation will start in 3 seconds."
		sleep 3
 		# Jetson Nano
		if [ "$NUM" == '1' ]; then
			ARCH_BIN=5.3
 		# Jetson TX2
		elif [ "$NUM" == '2' ]; then
			ARCH_BIN=6.2
		 # Jetson AGX Xaviers
		elif [ "$NUM" == '3' ]; then
			ARCH_BIN=7.2
		fi
		start
	else
		echo "[BASH]  Installation ends..."
	fi
else
	echo "[BASH]  Please put the right # "
	param
fi
}

start (){
DOWNLOAD_OPENCV_EXTRAS=NO
WHEREAMI=$PWD
NUM_JOBS=$(nproc)
CLEANUP=true
PACKAGE_OPENCV="-D CPACK_BINARY_DEB=ON"
CMAKE_INSTALL_PREFIX=$INSTALL_DIR

echo "[BASH]  Installation start!"
sleep 2

# Print out the current configuration
echo "[BASH]  Build configuration: "
echo " NVIDIA Jetson Nano"
echo " OpenCV binaries will be installed in: $CMAKE_INSTALL_PREFIX"
echo " OpenCV Source will be installed in: $OPENCV_SOURCE_DIR"
if [ "$PACKAGE_OPENCV" = "" ] ; then
   echo " NOT Packaging OpenCV"
else
   echo " Packaging OpenCV"
fi

if [ $DOWNLOAD_OPENCV_EXTRAS == "YES" ] ; then
 echo "[BASH]  Also downloading opencv_extras"
fi

# Repository setup
sudo apt-add-repository universe
sudo apt-get update
# Download dependencies for the desired configuration
cd $WHEREAMI
echo "[BASH]  Install dependencies ..."
sleep 2
sudo apt-get install -y \
    build-essential \
    cmake \
    libavcodec-dev \
    libavformat-dev \
    libavutil-dev \
    libeigen3-dev \
    libglew-dev \
    libgtk2.0-dev \
    libgtk-3-dev \
    libjpeg-dev \
    libpng-dev \
    libpostproc-dev \
    libswscale-dev \
    libtbb-dev \
    libtiff5-dev \
    libv4l-dev \
    libxvidcore-dev \
    libx264-dev \
    qt5-default \
    zlib1g-dev \
    libwebp-dev \
    pkg-config

# We will be supporting OpenGL, we need a little magic to help
# https://devtalk.nvidia.com/default/topic/1007290/jetson-tx2/building-opencv-with-opengl-support-/post/5141945/#5141945
cd /usr/local/cuda/include
sudo patch -N cuda_gl_interop.h $WHEREAMI'/patches/OpenGLHeader.patch' 

# Python 2.7
sudo apt-get install -y python-dev  python-numpy  python-py  python-pytest
# Python 3.6
sudo apt-get install -y python3-dev python3-numpy python3-py python3-pytest

# GStreamer support
sudo apt-get install -y libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev 

echo "[BASH]  Download sources ..."
sleep 2

cd $OPENCV_SOURCE_DIR
git clone --branch "$OPENCV_VERSION" https://github.com/opencv/opencv.git
git clone --branch "$OPENCV_VERSION" https://github.com/opencv/opencv_contrib.git

if [ $DOWNLOAD_OPENCV_EXTRAS == "YES" ] ; then
 echo "[BASH]  Installing opencv_extras"
 # This is for the test data
 cd $OPENCV_SOURCE_DIR
 git clone https://github.com/opencv/opencv_extra.git
 cd opencv_extra
 git checkout -b v${OPENCV_VERSION} ${OPENCV_VERSION}
fi

# Patch the Eigen library issue ...
cd $OPENCV_SOURCE_DIR/opencv
sed -i 's/include <Eigen\/Core>/include <eigen3\/Eigen\/Core>/g' modules/core/include/opencv2/core/private.hpp

# Create the build directory and start cmake
cd $OPENCV_SOURCE_DIR/opencv
mkdir build
cd build

echo "[BASH]  Build from sources ..."
sleep 2

echo $PWD
time cmake -D CMAKE_BUILD_TYPE=RELEASE \
      -D CMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX} \
      -D WITH_CUDA=ON \
      -D CUDA_ARCH_BIN=${ARCH_BIN} \
      -D CUDA_ARCH_PTX="" \
      -D ENABLE_FAST_MATH=ON \
      -D CUDA_FAST_MATH=ON \
      -D WITH_CUBLAS=ON \
      -D WITH_LIBV4L=ON \
      -D WITH_V4L=ON \
      -D WITH_GSTREAMER=ON \
      -D WITH_GSTREAMER_0_10=OFF \
      -D OPENCV_DNN_CUDA=ON \
      -D WITH_QT=ON \
      -D WITH_TBB=ON \
      -D BUILD_opencv_python2=ON \
      -D BUILD_opencv_python3=ON \
      -D BUILD_TESTS=OFF \
      -D BUILD_PERF_TESTS=OFF \
      -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
      $"PACKAGE_OPENCV" \
      ../


if [ $? -eq 0 ] ; then
  echo "[BASH]  CMake configuration make successful"
else
  # Try to make again
  echo "[BASH]  CMake issues " >&2
  echo "[BASH]  Please check the configuration being used"
  exit 1
fi

# Consider the MAXN performance mode if using a barrel jack on the Nano
time make -j$NUM_JOBS
if [ $? -eq 0 ] ; then
  echo "[BASH]  OpenCV make successful"
else
  # Try to make again; Sometimes there are issues with the build
  # because of lack of resources or concurrency issues
  echo "[BASH]  Make did not build " >&2
  echo "[BASH]  Retrying ... "
  # Single thread this time
  make
  if [ $? -eq 0 ] ; then
    echo "[BASH]  OpenCV make successful"
  else
    # Try to make again
    echo "[BASH]  Make did not successfully build" >&2
    echo "[BASH]  Please fix issues and retry build"
    exit 1
  fi
fi

echo "[BASH]  Installing ... "
sudo make install
sudo ldconfig
if [ $? -eq 0 ] ; then
   echo "[BASH]  OpenCV installed in: $CMAKE_INSTALL_PREFIX"
else
   echo "[BASH]  There was an issue with the final installation"
   exit 1
fi

# If PACKAGE_OPENCV is on, pack 'er up and get ready to go!
# We should still be in the build directory ...
if [ "$PACKAGE_OPENCV" != "" ] ; then
   echo "[BASH]  Starting Packaging"
   sudo ldconfig  
   time sudo make package -j$NUM_JOBS
   if [ $? -eq 0 ] ; then
     echo "[BASH]  OpenCV make package successful"
   else
     # Try to make again; Sometimes there are issues with the build
     # because of lack of resources or concurrency issues
     echo "[BASH]  Make package did not build " >&2
     echo "[BASH]  Retrying ... "
     # Single thread this time
     sudo make package
     if [ $? -eq 0 ] ; then
       echo "[BASH]  OpenCV make package successful"
     else
       # Try to make again
       echo "[BASH]  Make package did not successfully build" >&2
       echo "[BASH]  Please fix issues and retry build"
       exit 1
     fi
   fi
fi

# Install Python packages
sudo apt-get install -y libopencv-dev
sudo apt-get install -y libopencv-core-dev

# check installation
IMPORT_CHECK="$(python3 -c "import cv2 ; print(cv2.__version__)")"
if [[ $IMPORT_CHECK != *$OPENCV_VERSION* ]]; then
  echo "[BASH]  There was an error loading OpenCV in the Python sanity test."
  echo "[BASH]  The loaded version does not match the version built here."
  echo "[BASH]  Please check the installation."
  echo "[BASH]  The first check should be the PYTHONPATH environment variable."
fi

echo "[BASH]    Installation completed ..."
sleep 2

}

# Execute
ARCH_BIN=0
INSTALL_DIR=/usr/local
OPENCV_SOURCE_DIR=$HOME
OPENCV_VERSION=4.1.1
param

