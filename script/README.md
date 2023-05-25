## Container Workshop 환경 구성 준비 시 읽어주세요!!! (Shell 스크립트 순서)

Container Workshop 환경 구성 준비 시 읽어주세요. Shell Script 순서는 다음과 같습니다.

- 스크립트 목록

  ```bash
  00_container_workshop.sh
  01_new-user-project.sh
  02_create_user_vm.sh
  03_project_rabc_settings.sh
  04_podman_httpd_svc.sh
  yaml   # YAML 파일 디렉토리
  delete # Delete 스크립트 디렉토리
  old    # 백업용 디렉토리
  ```

- 작업 순서 

1. MAD Roadshow - Dev Track 신규 실습환경 주문 및 완성

2. 00_container_workshop.sh 스크립트 파일을 VI 편집기로 수정

- RHEL VM 서브스크립션 등록을 위한 Red Hat 계정 정보 기입
  
  ```bash  
  REDHAT_USERNAME='****'
  REDHAT_PASSWORD='*******'
  ```

3. 00_container_workshop.sh 스크립트 수행

- 실행

  ```bash
  $ sh 00_container_workshop.sh
  ```

총 30분 정도 소요됩니다.
- 베어메탈 노드 4개 추가 (20분)
- Project, VM, SVC, Route, Role Binding, PVC, PV 등 yaml 기반 K8s 리소스 생성 (3분)
- VM 초기화 스크립트 수행 (6분)
