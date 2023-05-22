#!/bin/bash

# YAML 파일 경로
yaml_file="./yaml/rhel8-clone.yaml"

# 네임스페이스 이름 변수
namespace_prefix="user"
namespace_suffix_common="vm"

# 반복문
for ((suffix=1; suffix<=20; suffix++)); do
    namespace="${namespace_prefix}${suffix}-${namespace_suffix_common}"
    echo "Applying YAML for namespace: $namespace"
    oc apply -n "$namespace" -f "$yaml_file"
done

