# 同步镜像到阿里云服务

第一次使用之前需要先执行脚本 `login-aliyun-hub.sh` 登录阿里云服务hub.sh

然后执行脚本 `sync.sh ubuntu 22.04` 即可将镜像 `ubuntu:22.04` 同步到阿里云。

注意需要确认你的[阿里云账号里的容器服务的registry地址](https://cr.console.aliyun.com/cn-hangzhou/instance/dashboard)是不是 `registry.cn-hangzhou.aliyuncs.com`，如果不是需要把脚本里的registry地址修改正确。

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