# Ubuntu setup script

우분투에서의 개발 환경을 자동으로 설정해 주는 스크립트  
vars.sh의 값 수정해서 원하는 패키지만 설치 가능

## 설치하는 패키지

- nvm
- nodejs
- java
- build-essentials
- zsh / oh-my-zsh
- python2
- python3

## How to run

### 1. 윈도우에서 WSL, Ubuntu 한 번에 설치(아직 테스트되지 않음)

Windows에서 스크립트를 관리자 권한으로 실행

1. `.\windows_presiquite.ps1` 실행 이후 재부팅
1. `.\windows_wsl.ps1` 실행  
   `windows_wsl.ps1`의 경우, ubuntu 설정 스크립트도 진행하므로 따로 `ubnutu.sh` 실행 불필요

### 2. 우분투만 별도로 설정

bash로 실행(**sh로는 불가능!**)

1. repository 복사 및 `Automation/WSL`로 이동
1. script 실행

   - non-root user

   ```shell
   sudo -E bash ubuntu.sh
   ```

   - root

   ```shell
   bash ubuntu.sh
   ```

## Additional Setups

### Windows

WSL2는 윈도우의 가용 메모리를 계속 할당하는 메모리 과다 점유 버그가 존재함  
메모리 과다 점유 문제를 방지하기 위해 램 할당량 제한 권장됨  
\* Hpyer-V를 사용한 Docker for windows에서도 동일한 버그 발생

- `%USERPROFILE%\.wslconfig`에 아래 내용 추가(메모리 제한)

```shell
[wsl2]
memory=4GB
swap=0
```

- (Optional)Oh-my-zsh 사용시

fonts/ 내부의 폰트 설치 후, [터미널](https://github.com/microsoft/terminal)에서 해당 폰트로 폰트 설정

### Linux(Ubuntu)

- `/etc/wsl.conf`에 아래 내용 추가  
  default 값을 생성한 사용자 이름으로 변경

```shell
[user]
default=${생성한 사용자 이름}
```

## Customization

아래의 과정으로 원하는 스크립트를 함수 형태로 추가 가능  
별도 함수 실행문을 코드에 추가하지 않아도 자동으로 실행됨

1. vars.sh에 원하는 변수 추가(all uppercases) 및 1(켜짐)로 값 할당
   1. set\_${prefix_name} : 환경 설정
   2. inst\_${prefix_name} : 패키지 설치
2. ubuntu.sh에 원하는 함수 추가(all lowercases)

## 주의사항

- 설치 켜기 / 끄기는 vars.sh에, 폴더 등 상세 커스터마이징은 각 함수에 존재
- Windows의 Network drive에서 작업하는 경우, `--no-bin-links` arg 추가 필요.(WSL1)  
  symlink 관련 `OperationThe operation was rejected by your operating system.` 오류 발생  
  -> WSL 실행시 예기치 않은 오류 발생할 수 있으므로 권장하지는 않음

## 기타

이 스크립트는 생성한 유저에 대해 sudo 권한 추가함

## References

- [WSL 설치](https://learn.microsoft.com/ko-kr/windows/wsl/install)
- Oh-my-zsh setup / customization(Prompt)
  - [256 color table for terminal](https://en.wikipedia.org/wiki/File:Xterm_256color_chart.svg)
- [intel iGPU setup](https://www.intel.com/content/www/us/en/artificial-intelligence/harness-the-power-of-intel-igpu-on-your-machine.html)
- [이전 버전 WSL의 수동 설치 단계(Microsoft 공식 페이지)](https://learn.microsoft.com/ko-kr/windows/wsl/install-manual)
- [Download linux distros manually](https://learn.microsoft.com/ko-kr/windows/wsl/install-manual#downloading-distributions)
- [Access WSL2 file of one distro from another](https://superuser.com/questions/1659218/is-there-a-way-to-access-files-from-one-wsl-2-distro-image-in-another-one)
