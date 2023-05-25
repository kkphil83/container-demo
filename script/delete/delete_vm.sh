#!/bin/bash

# YAML 파일 경로
yaml_file="../yaml/rhel8-demo-vm.yaml"
svc_yaml_file="../yaml/ssh-svc.yaml"

# 네임스페이스 이름 변수
namespace_prefix="user"
namespace_suffix_common="vm"

# 반복문
for ((suffix=1; suffix<=20; suffix++)); do
    namespace="${namespace_prefix}${suffix}-${namespace_suffix_common}"
    echo "Deleting YAML for namespace: $namespace"
    oc delete -n "$namespace" -f "$yaml_file"
    oc delete -n "$namespace" -f "$svc_yaml_file"
done