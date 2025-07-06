#!/bin/bash
#
# set -x
ENTER_DIR=$1
# VENV=$2
USER=${USER:=$(whoami)}
TOOLBOX=${HOME}/TOOL
VENV=${VENV:=${TOOLBOX}/venv}
echo "source ${VENV}/bin/activate" >> /home/${USER}/.bashrc	
cd ${TOOLBOX}
# unzip cmd_tool.zip
# unzip gradle-8.11.1-bin.zip
# unzip android-ndk-r27c-linux.zip
# set +x

if [[ "${ENTER_DIR}" == "" ]];then
	cd /home/${USER}
elif [ -d /home/${USER}/${ENTER_DIR} ];then
	cd /home/$USER
elif [ -d ${ENTER_DIR} ];then
	cd ${ENTER_DIR}
else
	cd /home/${USER}
fi
echo "Enabled venv for ${VENV}"
source ${VENV}/bin/activate
bash
# deactivate
