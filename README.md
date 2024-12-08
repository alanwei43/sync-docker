# 同步镜像到阿里云服务

## 本地脚本同步

第一次使用之前需要先执行脚本 `login-aliyun-hub.sh` 登录阿里云服务hub.sh

然后执行脚本 `sync.sh ubuntu 22.04` 即可将镜像 `ubuntu:22.04` 同步到阿里云。

注意需要确认你的[阿里云账号里的容器服务的registry地址](https://cr.console.aliyun.com/cn-hangzhou/instance/dashboard)是不是 `registry.cn-hangzhou.aliyuncs.com`，如果不是需要把脚本里的registry地址修改正确。

## 使用 GitHub Action 同步

借助 GitHub Action 工作流脚本可以自动将Docker官方仓库同步到自己的阿里云账户下:

*注意镜像和标签之间的冒号用斜线替代*

```bash
# 假设同步 `ubuntu:22.04` 镜像: 
git tag -a ubuntu/22.04 -m "Ubuntu 22.04" # 
git push origin ubuntu/22.04 
# 对应的阿里云镜像地址 registry.cn-hangzhou.aliyuncs.com/alanwei/ubuntu:22

# 同步 node:22 镜像
git tag -a node/22 -m "NodeJS v22" # 
git push origin node/22
# 对应的阿里云镜像地址 registry.cn-hangzhou.aliyuncs.com/alanwei/node:22
```

## 借助代理从官方拉去镜像

修改配置文件 `/etc/docker/daemon.json` : 

```json
{
  "proxies": {
    "http-proxy": "http://127.0.0.1:7890",
    "https-proxy": "http://127.0.0.1:7890",
    "no-proxy": "localhost,127.0.0.1,192.168.1.3"
  }
}
```

修改完配置重启服务:
```bash
systemctl restart docker
```