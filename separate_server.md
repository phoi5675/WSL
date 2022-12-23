# Separate server

WSL2에서 Frontend, backend를 분리시키고 싶은 경우에 읽어야 하는 문서

## Setup

1. 다른 distro의 파일 접근 허용  
   각 distro에서 아래 스크립트 실행  
   실행 이후 `/mnt/wsl/instances/` 에서 다른 distro 접근 가능

   ```bash
   echo "/ /mnt/wsl/instances/$WSL_DISTRO_NAME none defaults,bind,X-mount.mkdir 0 0" | sudo tee -a /etc/fstab
   ```

1. 나머지 FE, BE 설정

### Tips

`.bashrc` 에 변수 export하면 편하게 사용 가능

```bash
export ${WSL_DIST}="/mnt/wsl/instances"
export ${APP}="${WSL_DIST}/App"
export ${BACKEND}="${WSL_DIST}/Backend"
```

## References

- [Access WSL2 file of one distro from another](https://superuser.com/questions/1659218/is-there-a-way-to-access-files-from-one-wsl-2-distro-image-in-another-one)
