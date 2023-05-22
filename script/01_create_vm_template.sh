#!/bin/bash

# 프로젝트 이름 및 템플릿 이름을 설정합니다.
project_name="ov-demo"
template="./yaml/rhel8-demo-template.yaml"

# 프로젝트 생성
oc new-project $project_name

# 템플릿 생성
oc apply -f $template -n $project_name

