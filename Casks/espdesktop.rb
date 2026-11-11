cask "espdesktop" do
  version "1.2.0"
  sha256 "38d2ec66cbac62bdb8a3336495011229323d7d515cae36c24bb29dd1f7025cde"

  url "https://github.com/jtenniswood/espdesktop/releases/download/v#{version}/EspDesktop-#{version}.zip"
  name "EspDesktop"
  desc "Mac companion for the EspDesktop touchscreen controller"
  homepage "https://jtenniswood.github.io/espdesktop/"

  auto_updates true
  depends_on arch: :arm64, macos: :ventura

  app "EspDesktop.app"

  uninstall quit: "io.espdesktop.app"
end
