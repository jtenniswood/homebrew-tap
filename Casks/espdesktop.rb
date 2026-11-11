cask "espdesktop" do
  version "1.2.5"
  sha256 "1c31d76ca5996942e078d922212a3a6acd93270b2651a37ffb83d921d8ebe9f2"

  url "https://github.com/jtenniswood/espdesktop/releases/download/v#{version}/EspDesktop-#{version}.zip"
  name "EspDesktop"
  desc "Companion app for an ESP32 touchscreen controller"
  homepage "https://jtenniswood.github.io/espdesktop/"

  livecheck do
    url :url
    regex(/\Av?(\d+(?:\.\d+){2})\z/i)
    strategy :github_releases do |json, regex|
      json.filter_map do |release|
        next if release["draft"] || release["prerelease"]

        version = release["tag_name"]&.[](regex, 1)
        next unless version

        has_zip = release["assets"].any? do |asset|
          asset["name"] == "EspDesktop-#{version}.zip" && asset["state"] == "uploaded"
        end
        version if has_zip
      end
    end
  end

  auto_updates true
  depends_on arch: :arm64, macos: :ventura

  app "EspDesktop.app"

  uninstall quit: "io.espdesktop.app"
end
