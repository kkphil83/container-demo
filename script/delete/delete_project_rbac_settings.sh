#!/bin/bash

project_count=20
project_prefix="user"

for ((i=1; i<=project_count; i++))
do
    project_name="${project_prefix}${i}-vm"
   
    oc adm policy remove-role-from-user edit "${project_prefix}${i}" -n "$project_name"

    echo "Deleted edit role to user: ${project_prefix}${i} in project: $project_name"

done

