## Container Workshop 환경 구성 준비 시 읽어주세요!!! (Shell 스크립트 순서)

Container Workshop 환경 구성 준비 시 읽어주세요. Shell Script 순서는 다음과 같습니다.

- 스크립트 목록

  ```bash
  01_create_vm_template.sh
  02_new-user-project.sh
  03_subscription.sh
  03_subscription.sh.org
  04_sshd_config_update.sh
  05_add_user_group.sh
  06_install_pakage.sh
  07_datavolume-cloner_role.sh
  08_pvc_clone.sh
  09_user_vm_create.sh
  10_project_rabc_settings.sh
  11_podman_login.sh
  12_podman_httpd_svc.sh
  yaml // YAML 파일 디렉토리
  ```

- 스크립트 순서 및 작업 순서

  01_create_vm_template.sh

  **<span style="color: red">(콘솔 작업) == ov-demo 프로젝트에서 rhel8-server-demo 템플릿으로 VM 이름만 rhel8-vm으로 수정하고 생성하기 </span>**

  **<span style="color: red">(콘솔 작업) == Web Terminal Operator 설치하기</span>**

  02_new-user-project.sh

  **<span style="color: blue">========== ov-demo 프로젝트에서 생성한 OV에 들어가서 수행하는 작업 =========</span>**

  오픈시프트 콘솔의 콘솔로 접속하여 해당 쉘 복붙해서 실행 (cloud-user로 로그인 후 sudo 권한 스위치)

  03_subscription.sh
  03_subscription.sh.org
  04_sshd_config_update.sh
  05_add_user_group.sh
  06_install_pakage.sh

  07_podman_login.sh

  **<span style="color: blue">========== ov-demo 프로젝트에서 생성한 OV에 들어가서 수행하는 작업 =========</span>**

  **<span style="color: blue">== ov-demo 프로젝트에 있는 VM에 들어가서 생성한 쉘 삭제하기 (개인 계정 정보가 있기 때문에!!)</span>**

  **<span style="color: blue">07_podman_login.sh 만 남기고 삭제하기</span>**

  **<span style="color: blue">== ov-demo 프로젝트에 떠 있는 OV 정지!!! ==</span>**

  08_datavolume-cloner_role.sh
  09_pvc_clone.sh
  10_user_vm_create.sh
  11_project_rabc_settings.sh

  12_podman_httpd_svc.sh

- podman 로그 인 시 인증 에러가 날 경우

  <span style="color: green">07_podman_login.sh</span> 실행하기

  