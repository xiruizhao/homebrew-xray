#!/usr/bin/bash
# prerequisites: curl grep sed git

cd Formula || exit 2
# assuming the first tag is the latest tag
TAG=$(curl -s -H 'Accept: application/vnd.github.v3+json' https://api.github.com/repos/XTLS/Xray-core/tags | grep -m 1 -oE 'v[0-9]+.[0-9]+.[0-9]+')
if grep -q "version \"${TAG#v}\"" xray.rb; then
    exit 0
fi
DOWNLOAD_URL="https://github.com/XTLS/Xray-core/releases/download/${TAG}/Xray-macos-64.zip"
SHASUM=$(curl -sSL "$DOWNLOAD_URL" | sha256sum -b | cut -d' ' -f1)
sed -e "s#^  url.*#  url \"$DOWNLOAD_URL\"#" -e "s/^  version.*/  version \"${TAG#v}\"/" -e "s/^  sha256.*/  sha256 \"${SHASUM}\"/" -i xray.rb
git config user.name github-actions
git config user.email github-actions@github.com
git commit -am "xray ${TAG}"
git push
