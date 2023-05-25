#!/bin/bash

# 반영할 YAML 파일 경로
yaml_file="../yaml/datavolume-cloner-role.yaml"

oc delete -f $yaml_file -n ov-demo