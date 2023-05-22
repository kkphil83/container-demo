#!/bin/bash

# 프로젝트 이름 및 yaml 파일을 설정
project_name="ov-demo"
vm_yaml="./yaml/rhel8-demo-vm.yaml"

# 프로젝트 설정
oc project $project_name

# VM yaml 파일내용 수정
pvc_name=`oc get pvc -n openshift-virtualization-os-images | grep rhel8 | cut -d ' ' -f1`
sed -i 's/PVC_NAME/$pvc_name/g' $vm_yaml

# VM 생성
oc apply -f $vm_yaml -n $project_name

