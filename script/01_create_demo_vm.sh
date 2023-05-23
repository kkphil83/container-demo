#!/bin/bash

# 서브스크립션 등록을 위한 Red Hat 계정 정보 수집
echo "Please enter your red hat account information."
echo -n "REDHAT_USERNAME: "
read REDHAT_USERNAME
echo -n "REDHAT_PASSWORD: "
read REDHAT_PASSWORD

# cloud-init startup 스크립트에 계정 정보 수정
sed -i "s/REDHAT_USERNAME/$REDHAT_USERNAME/g" ./yaml/startup.sh
sed -i "s/REDHAT_PASSWORD/$REDHAT_PASSWORD/g" ./yaml/startup.sh

# 프로젝트 이름 및 yaml 파일을 설정
project_name="ov-demo"
vm_yaml="./yaml/rhel8-demo-vm.yaml"

# 프로젝트 설정
oc project $project_name

# VM yaml 파일내용 수정
pvc_name=`oc get pvc -n openshift-virtualization-os-images | grep rhel8 | cut -d ' ' -f1`
sed -i "s/PVC_NAME/$pvc_name/g" $vm_yaml

# ssh key 생성 및 시크릿 생성
sudo -i yum install -y expect
sh ./ssh-keygen.sh
#oc create secret generic rhel8-vm-ssh-key --from-file=ssh-privatekey=~/.ssh/id_rsa --from-file=ssh-publickey=~/.ssh/id_rsa.pub


startup_script=`cat ./yaml/startup.sh | base64 -w0`
sed -i "s/STARTUP_SCRIPT/$startup_script/g" $vm_yaml


# VM 생성
oc apply -f $vm_yaml -n $project_name

