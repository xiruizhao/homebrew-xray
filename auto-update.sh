#!/usr/bin/bash
# prerequisites: curl grep sed git

# assuming the first tag is the latest tag
TAG=$(curl -s -H 'Accept: application/vnd.github.v3+json' https://api.github.com/repos/XTLS/Xray-core/tags | grep -Eom 1 'v[0-9]+\.[0-9]+\.[0-9]+')
if grep -Eq "^ *url.*$TAG" Formula/xray.rb; then
    exit 0
fi
sed -Ee "/^ *version|^ *url/s/[0-9]+\.[0-9]+\.[0-9]+/${TAG#v}/" -i Formula/xray.rb
SHASUM=$(curl -sSL "https://github.com/XTLS/Xray-core/releases/download/${TAG}/Xray-macos-64.zip" | sha256sum -b | cut -d' ' -f1)
sed -Ee "/^ *sha256.*intel/s/[0-9a-f]{64}/${SHASUM}/" -i Formula/xray.rb
SHASUM=$(curl -sSL "https://github.com/XTLS/Xray-core/releases/download/${TAG}/Xray-macos-arm64-v8a.zip" | sha256sum -b | cut -d' ' -f1)
sed -Ee "/^ *sha256.*apple/s/[0-9a-f]{64}/${SHASUM}/" -i Formula/xray.rb
git config user.name github-actions
git config user.email github-actions@github.com
git commit -am "xray ${TAG}"
git push
