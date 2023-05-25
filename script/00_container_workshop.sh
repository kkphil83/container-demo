#!/bin/bash

# RHEL VM 서브스크립션 등록을 위한 Red Hat 계정 정보 기입
REDHAT_USERNAME=''
REDHAT_PASSWORD=''

# 베어메탈 머신 수 5개로 증가
mcs_name=`oc get machineset -n openshift-machine-api | grep metal | cut -d ' ' -f1`
oc scale --replicas=5 machineset $mcs_name -n openshift-machine-api

sleep 20m

echo '## machineset STATUS ##'
oc get machineset -n openshift-machine-api
echo ' '

# 스크립트 순차 실행
sh 01_new-user-project.sh
sh 02_create_user_vm.sh  $REDHAT_USERNAME  $REDHAT_PASSWORD
sh 03_project_rabc_settings.sh
sh 04_podman_httpd_svc.sh

# 웹 터미널 오퍼레이터 설치
oc apply -f ./yaml/web-terminal-operator.yaml 

# VM 상태 모니터링
echo "## VM Provisioning Check CMD ##"
echo "watch -n 5 'oc get vm -A | grep rhel8-vm'"