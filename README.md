A formula distributing pre-build binaries from [Xray-core releases](https://github.com/XTLS/Xray-core/releases).

# Usage

```
brew tap xiruizhao/xray
brew install xray
brew services start xray
```

check out example configs at https://github.com/XTLS/Xray-examples and save your config.json to `/usr/local/etc/xray`

# Uninstallation

```
brew services stop xray
brew remove xray
brew untap xiruizhao/xray
```
