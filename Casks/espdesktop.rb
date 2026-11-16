cask "espdesktop" do
  version "1.3.1"
  sha256 "adf7a61dcec8770873b78aa6fc210877ee57e9ec2be3d24a1768d012144b2383"

  url "https://github.com/jtenniswood/espdesktop/releases/download/v#{version}/EspDesktop-#{version}.zip"
  name "EspDesktop"
  desc "Companion app for an ESP32 touchscreen controller"
  homepage "https://espdesktop.com/"

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
