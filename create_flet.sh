#!/bin/bash
ANDROID_DOCKERFILE="Android_Dockerfile"

HOME="/home/${USER}"
TOOLBOX="${HOME}/TOOL"
BUILD_ROOM="${HOME}/buildroom"

Android_TAG="androidbuilder:latest"
AFTER_SHELL="TOOL/afterbuild.sh"
TOOL="$(pwd)/TOOL"

ENTER_POINT=$1
BUILD_SRC="${BUILD_ROOM}/src"

ENTER_POINT=${ENTER_POINT:=${BUILD_ROOM}}

cp ~/.bashrc TOOL/.

if [ ! -f "${AFTER_SHELL}" ];then
	cp ${AFTER_SHELL} .
fi

cmd_run(){
	echo "RUN: $@"
	$@ && true || false
}

isSkip(){
	_tag=$1
	if ! docker image ls | grep -q _tag;then
		echo true
	else
		echo false
	fi
}
isBUILD_Android=$(isSkip ${Android_TAG})

if ${isBUILD_Android};then
	cmd_run docker buildx build -f ${ANDROID_DOCKERFILE} . --platform=linux/amd64 -t ${Android_TAG} \
	--build-arg HOME=${HOME} \
	--build-arg TOOL=${TOOLBOX} \
	--build-arg USER=$USER \
	--build-arg UID=$(id $USER -u) \
	--build-arg GID=$(id $USER -g) \
	--build-arg PATH=$PATH \
	--build-arg SRC=${BUILD_ROOM}/src \
	--build-arg START_SHELL=$(basename ${AFTER_SHELL})
fi
