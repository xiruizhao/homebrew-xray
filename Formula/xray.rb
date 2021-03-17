# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Xray < Formula
  desc "Xray, Penetrates Everything. Also the best v2ray-core, with XTLS support. Fully compatible configuration."
  homepage "https://t.me/projectxray"
  # download binary from upstream directly
  if Hardware::CPU.intel?
    url "https://github.com/XTLS/Xray-core/releases/download/v1.3.1/Xray-macos-64.zip"
    sha256 "0f31c36d7c2b5ea49e56acae116f47796e46b29111d6678062b43eb595c7776e" # intel
  else
    url "https://github.com/XTLS/Xray-core/releases/download/v1.3.1/Xray-macos-arm64-v8a.zip"
    sha256 "0bb7c60ac3ba00b49be2aced01029587f9d925cd8f7d03d58dfac50257586da4" # apple
  end
  version "1.3.1-deletion"
  license "Mozilla Public License Version 2.0"

  def install
    STDERR.puts '    DEPRECATED: run `brew uninstall xray && brew untap xiruizhao/xray`\n    and use the homebrew-core fomula via `brew install xray` now!'
    exit(1)
    bin.install "xray"
    pkgshare.install "geoip.dat" # installed to /usr/local/Cellar/xray/{version}/share/xray, symlinked to /usr/local/share/xray
    pkgshare.install "geosite.dat"
    (etc/"xray").mkpath
  end

  def caveats
    <<~EOS
      check out example configs at https://github.com/XTLS/Xray-examples
      and save your config.json to #{etc}/xray
    EOS
  end

  test do
    system "#{bin}/xray", "version"
  end

  plist_options :manual => "xray run -c #{HOMEBREW_PREFIX}/etc/xray/config.json"

  def plist
    <<~EOS
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
        <dict>
          <key>KeepAlive</key>
          <true/>
          <key>RunAtLoad</key>
          <true/>
          <key>Label</key>
          <string>#{plist_name}</string>
          <key>ProgramArguments</key>
          <array>
            <string>#{bin}/xray</string>
            <string>run</string>
            <string>-config</string>
            <string>#{etc}/xray/config.json</string>
          </array>
        </dict>
      </plist>
    EOS
  end
end
