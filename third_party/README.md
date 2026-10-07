# third_party

## sing-box (vendored)

V2bX 的动态用户管理（`AddUsers`/`DelUsers`，面板推送用户增删）依赖 wyx2685
的私有 patch，上游 sing-box 从未提供此功能。因此本仓库 vendor 上游
sing-box v1.14.2，并把该 patch 移植了过来。

`go.mod` 中：

```
replace github.com/sagernet/sing-box => ./third_party/sing-box
```

### 构建前准备

vendored 的 `third_party/sing-box/` 目录**不提交**到 git（12MB），构建前执行：

```bash
./third_party/vendor-singbox.sh
```

该脚本会下载上游 sing-box v1.14.2 并应用
`patches/sing-box-v1.14.2-wyx2685-port.patch`。

### 以后升级 sing-box

1. 改 `vendor-singbox.sh` 中的 `VERSION` 为新版本；
2. 用新版上游重新生成 patch（`diff -ruN` 对照移植）；
3. 更新 `patches/` 下的 patch 文件名与脚本引用。
