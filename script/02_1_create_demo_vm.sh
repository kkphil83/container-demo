#!/bin/bash

# 프로젝트 이름 및 yaml 파일을 설정
project_name="ov-demo"
vm_yaml="./yaml/rhel8-demo-vm.yaml"

# 프로젝트 설정
oc project $project_name

# VM 생성
oc apply -f $vm_yaml -n $project_name

