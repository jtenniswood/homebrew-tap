cask "espdesktop" do
  version "1.4.1"
  sha256 "968f0a4710d91a98b46559fbdbf47f3fa22cc43fc7996d65e1cbcaece41a324e"

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
