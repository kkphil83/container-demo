#!/bin/bash

############################
#####  cloud-user 생성  #####
############################

export NEW_USER="cloud-user"

sudo adduser -U -m $NEW_USER
echo "$NEW_USER:openshift" | chpasswd

############################
#####   ssh 접속 활성화   #####
############################

cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak

sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config

echo "Reloading sshd service..."
service sshd reload || { echo "Failed to reload sshd service"; exit 1; }

echo "sshd_config modification completed."

echo "Reloading sshd service..."
if command -v systemctl &>/dev/null; then
    systemctl reload sshd || { echo "Failed to reload sshd service"; exit 1; }
elif command -v service &>/dev/null; then
    service sshd reload || { echo "Failed to reload sshd service"; exit 1; }
else
    echo "Failed to reload sshd service. Unsupported service management."
    exit 1
fi

echo "sshd_config modification completed."

#sudo sed -i "s/PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
#systemctl restart sshd
#systemctl status sshd

############################
##### Subscription 등록 #####
############################

# Subscription 등록에 필요한 변수들을 설정합니다.
subscription_username="REDHAT_USERNAME"
subscription_password="REDHAT_PASSWORD"
disable_repos=("*")    # 비활성화할 Repositories 목록
enable_repos=("rhel-8-for-x86_64-baseos-rpms" "rhel-8-for-x86_64-appstream-rpms" "rhocp-4.12-for-rhel-8-x86_64-rpms")    # 활성화할 Repositories 목록

# Subscription 등록을 위해 subscription-manager 명령어를 실행합니다.
echo "Registering subscription..."
subscription-manager register --username="$subscription_username" --password="$subscription_password" || { echo "Failed to register subscription"; exit 1; }

# Subscription 상태를 확인합니다.
echo "Verifying subscription status..."
subscription-manager status || { echo "Failed to verify subscription status"; exit 1; }

echo "Subscription registration completed."

# 비활성화할 Repositories를 해지합니다.
for repo in "${disable_repos[@]}"
do
    echo "Disabling repository: $repo"
    subscription-manager repos --disable="$repo" || { echo "Failed to disable repository: $repo"; exit 1; }
done

# 활성화할 Repositories를 등록합니다.
for repo in "${enable_repos[@]}"
do
    echo "Enabling repository: $repo"
    subscription-manager repos --enable="$repo" || { echo "Failed to enable repository: $repo"; exit 1; }
done

echo "Subscription registration completed."


############################
##### User / Group 생성 #####
############################

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



############################
#####   필수 패키지 설치   #####
############################

# 설치할 패키지들의 목록
packages=("podman" "git")

# 패키지 설치
for package in "${packages[@]}"
do
    echo "Installing package: $package"
    if ! rpm -q "$package" >/dev/null 2>&1; then
        dnf install -y "$package" || { echo "Failed to install package: $package"; exit 1; }
    else
        echo "Package $package is already installed."
    fi
done

echo "Package installation completed."


############################
#####   레지스트리 로그인   #####
############################

URL="registry.redhat.io"

podman login -u $subscription_username -p $subscription_password $URL