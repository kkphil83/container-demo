#!/bin/bash

# 생성할 프로젝트의 개수와 접두사(prefix)를 지정합니다.
project_count=20
project_prefix="user"

# 프로젝트를 삭제합니다.
for ((i=1; i<=project_count; i++))
do
    project_name="${project_prefix}${i}-vm"
    echo "Deleting project: $project_name"
    oc delete project $project_name
done

