#!/bin/bash

project_count=20
project_prefix="user"

for ((i=1; i<=project_count; i++))
do
    project_name="${project_prefix}${i}-vm"
   
    oc adm policy add-role-to-user edit "${project_prefix}${i}" -n "$project_name"

    echo "Granted edit role to user: ${project_prefix}${i} in project: $project_name"

done

