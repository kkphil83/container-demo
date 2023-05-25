#!/bin/bash

# 서브스크립션 등록을 위한 Red Hat 계정 정보 기입
REDHAT_USERNAME=''
REDHAT_PASSWORD=''

# cloud-init startup 스크립트에 계정 정보 수정
sed -i "s/REDHAT_USERNAME/$REDHAT_USERNAME/g" ./yaml/startup.sh
sed -i "s/REDHAT_PASSWORD/$REDHAT_PASSWORD/g" ./yaml/startup.sh

# YAML 파일 경로
vm_yaml="./yaml/rhel8-demo-vm.yaml"
svc_yaml="./yaml/ssh-svc.yaml"

# VM yaml 파일내용 수정
pvc_name=`oc get pvc -n openshift-virtualization-os-images | grep rhel8 | cut -d ' ' -f1`
sed -i "s/PVC_NAME/$pvc_name/g" $vm_yaml

# 네임스페이스 이름 변수
namespace_prefix="user"
namespace_suffix_common="vm"

# 반복문
for ((suffix=1; suffix<=20; suffix++)); do
    namespace="${namespace_prefix}${suffix}-${namespace_suffix_common}"
    echo "Applying YAML for namespace: $namespace"
    oc create secret generic rhel8-vm-secret --from-file=userdata=./yaml/startup.sh -n "$namespace"
    oc apply -n "$namespace" -f "$vm_yaml"
    oc apply -n "$namespace" -f "$svc_yaml"
done
