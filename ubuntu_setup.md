# Ubuntu setup script

우분투에서의 개발 환경을 자동으로 설정해 주는 스크립트  
_스크립트를 한 번만 실행해 주세요. 두 번 이상 실행하는 경우, config 파일 오류가
발생할 수 있습니다_

## 설치하는 패키지

- build-essentials
- openssh-server
- python2
- python3
- git
- openjdk
- nvm / nodejs
- fonts-nanum
- docker-cli
- zsh / oh-my-zsh

## 설정 변경

- 시간대(기본값: UTC)
- apt 서버 변경(카카오 서버)
- shell prompt
- vim
- git config

## How to run

### Prerequisite

1. 필요한 경우, `vars.sh` 수정
   1. 설치 여부(0 / 1)
   2. 설치 버전

### 1. 윈도우에서 WSL, Ubuntu 한 번에 설치

Windows Powershell에서 스크립트를 관리자 권한으로 실행

1. `.\windows_presiquite.ps1` 실행

   ```bash
   ./windows_presiquite.ps1
   ```

1. `.\windows_wsl.ps1` 실행  
   `windows_wsl.ps1`의 경우, ubuntu 설정 스크립트도 포함됨

   ```bash
   ./windows_presiquite.ps1
   ```

### 2. 우분투만 별도로 설정

bash로 실행(**sh로는 불가능!**)

1. repo의 script 실행

   - non-root user

   ```shell
   sudo -E bash ubuntu.sh
   ```

   - root

   ```shell
   bash ubuntu.sh
   ```

## Additional Setups

<details>
   <summary>Deprecated</summary>

모두 각각 `windows_wsl.ps1`, `ubuntu.sh`에 포함됨  
별도로 설정 불필요

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

fonts/ 내부의 폰트 설치 후, [터미널](https://github.com/microsoft/terminal)에서
해당 폰트로 폰트 설정

### Linux(Ubuntu)

- `/etc/wsl.conf`에 아래 내용 추가  
  default 값을 생성한 사용자 이름으로 변경

```shell
[user]
default=${생성한 사용자 이름}
```

</details>

## Customization

아래의 과정으로 원하는 스크립트를 함수 형태로 추가 가능  
별도 함수 실행문을 코드에 추가하지 않아도 자동으로 실행됨

1. vars.sh에 원하는 변수 추가(all uppercases) 및 1(켜짐)로 값 할당
   1. set\_${prefix_name} : 환경 설정
   2. inst\_${prefix_name} : 패키지 설치
2. `set_` 함수인 경우 `setups.sh`에, `inst_`함수인 경우 `installs.sh`에 원하는함
   수 추가(all lowercases)

## 기타

이 스크립트는 생성한 유저에 대해 sudo 권한 추가함

## `SET_OPEN_SESSION_CONNECTED_VIA_SSH=1`로 설정한 경우의 추가 설정

ssh로 세션 접속 시, screen을 띄우는 prompt가 나오게 하려면 다음과 같이
`LC_SSH`값을 추가해야 함

```bash
LC_SSH=1 ssh user@server -o SendEnv=LC_SSH
```

## References

- [WSL 설치](https://learn.microsoft.com/ko-kr/windows/wsl/install)
- Oh-my-zsh setup / customization(Prompt)
  - [256 color table for terminal](https://en.wikipedia.org/wiki/File:Xterm_256color_chart.svg)
- [intel iGPU setup](https://www.intel.com/content/www/us/en/artificial-intelligence/harness-the-power-of-intel-igpu-on-your-machine.html)
- [이전 버전 WSL의 수동 설치 단계(Microsoft 공식 페이지)](https://learn.microsoft.com/ko-kr/windows/wsl/install-manual)
- [Download linux distros manually](https://learn.microsoft.com/ko-kr/windows/wsl/install-manual#downloading-distributions)
- [Access WSL2 file of one distro from another](https://superuser.com/questions/1659218/is-there-a-way-to-access-files-from-one-wsl-2-distro-image-in-another-one)
