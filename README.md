This repository will be deleted in one month since homebrew-core now has a formula for [xray](https://github.com/Homebrew/homebrew-core/commit/80b781351b923443b788a891a7d7547e39526f4d).

A formula distributing pre-build binaries from [Xray-core releases](https://github.com/XTLS/Xray-core/releases).

# Usage

```
brew install xiruizhao/xray/xray
brew services start xray
```

check out example configs at https://github.com/XTLS/Xray-examples and save your config.json to `/usr/local/etc/xray`

# Uninstallation

```
brew services stop xray
brew uninstall xray
brew untap xiruizhao/xray
```
