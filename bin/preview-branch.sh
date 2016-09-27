#!/usr/bin/env bash

usage() { cat <<EOF
Usage: preview-branch.sh  -t <tag>

This commits files generated here to a target repo.

Example usage:
preview-branch.sh  -t orzech

Options:
  -t,--tag        tag that identifies a machine on docker-cloud where deployment should take place 
  				  machines should be named "onedata-doc-<tag>", where tag is the value you enter here
EOF
}

while (( $# )) ; do
flag=$1
	case $flag in
	-t|--tag)
	  tag=$2
	  shift
	  ;;
	*)
	  echo "no opntion ${flag}"
	  exit 1
	  ;;
	esac
	shift
done

if [[ -z ${tag} ]]; then
	echo " -t option is mandatory"
	usage
	exit 1
fi


DOCKERCLOUD_NAMESPACE="onedata" 

if hash docker-cloud 2>/dev/null; then
	_docker_cloud="docker-cloud"
elif hash docker 2>/dev/null; then
	if [[ -z ${DOCKERCLOUD_USER} || -z ${DOCKERCLOUD_PASS} ]]; then
		echo "Please set your DOCKERCLOUD_USER DOCKERCLOUD_PASS env variables or install docker-cloud cli client."
		exit 1
	fi
	_docker_cloud="docker run -e DOCKERCLOUD_NAMESPACE=$DOCKERCLOUD_NAMESPACE -e DOCKERCLOUD_USER=$DOCKERCLOUD_USER -e DOCKERCLOUD_PASS=$DOCKERCLOUD_PASS dockercloud/cli"
else
	echo "Please install docker and/or docker-cloud commands!"
	exit 1
fi



bin/build.sh

CURRNET_BRANCH=$(git rev-parse --abbrev-ref HEAD)
CURRNET_BRANCH="${CURRNET_BRANCH#*/}"
IMAGE="onedata/onedata-documentation:${CURRNET_BRANCH}-latest"
COMMIT_AUTOR=$(git log --pretty=format:"%an <%aE>" -1)
CURRNET_COMMIT=$(git rev-parse HEAD)
PREETY_COMMIT=${CURRNET_COMMIT:0:6}
PREETY_TIME=$(date '+%T.%D.%Z')

docker build -t "$IMAGE" . 
if ! docker push "$IMAGE"; then
	docker login
fi

stack_name="onedata-documentation-${tag}"

DOCKERCLOUD_NAMESPACE=$DOCKERCLOUD_NAMESPACE ${_docker_cloud} stack ls | grep "$stack_name" | tr -s ' ' | cut -d ' ' -f 2 | xargs -I {} ${_docker_cloud} stack terminate --sync {}
DOCKERCLOUD_NAMESPACE=$DOCKERCLOUD_NAMESPACE TAG=$tag IMAGE="$IMAGE" CURRNET_BRANCH="$CURRNET_BRANCH" COMMIT_AUTOR="$COMMIT_AUTOR" PREETY_COMMIT="$PREETY_COMMIT"  PREETY_TIME="$PREETY_TIME" ${_docker_cloud} up -n "$stack_name" --sync
