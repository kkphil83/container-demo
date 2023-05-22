#!/bin/bash

# 사용자 계정 생성 시작 번호
start_index=1

# 사용자 계정 생성 종료 번호
end_index=20

# 그룹 이름
groupname="users"

# 그룹 생성
groupadd "$groupname"

# 사용자 계정 생성을 위한 반복문
for ((i=start_index; i<=end_index; i++))
do
    username="user$i"
    password="openshift"

    # 사용자 계정 생성
    useradd -m -s /bin/bash "$username"

    # 사용자 계정 비밀번호 설정
    echo "$username:$password" | chpasswd

    # 사용자 계정을 그룹에 추가
    usermod -a -G "$groupname" "$username"

    # 필요에 따라 사용자 계정에 대한 추가 작업 수행

done

# 스크립트 실행 후 생성된 사용자 계정 목록 및 그룹 출력
echo "생성된 사용자 계정 목록:"
awk -F':' '{ if ( $3 >= 1000 ) print $1 }' /etc/passwd

echo "그룹 정보:"
grep "$groupname" /etc/group


# sudo 권한 설정
echo "Configuring sudo permissions..."
echo "%$groupname ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

echo "User and group creation completed."

