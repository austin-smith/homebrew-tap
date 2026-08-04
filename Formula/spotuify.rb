class Spotuify < Formula
  desc "spotify in ur terminal"
  homepage "https://github.com/austin-smith/spotuify"
  version "0.2.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/austin-smith/spotuify/releases/download/v0.2.0/spotuify-v0.2.0-darwin-arm64.tar.gz"
      sha256 "c8acd1db00284b7136061e249c4f7d216c9f2aeb7bd030aa634496482cb5e90a"
    end
    depends_on arch: :arm64
    depends_on macos: :ventura
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/austin-smith/spotuify/releases/download/v0.2.0/spotuify-v0.2.0-linux-arm64.tar.gz"
      sha256 "61fa9ff387166723adf37c32456594666902ceaa0a445bb86abc261958682185"
    else
      url "https://github.com/austin-smith/spotuify/releases/download/v0.2.0/spotuify-v0.2.0-linux-x64.tar.gz"
      sha256 "fe8e26963b7238998757bbbe12145d08a8e679d29523e59fffabe5167a5d97d5"
    end
    depends_on "patchelf" => :build
    depends_on "alsa-lib"
  end

  def install
    libexec.install "spotuify", "spotuify-engine"
    system "patchelf", "--set-rpath", formula_opt_lib("alsa-lib"), libexec/"spotuify-engine" if OS.linux?
    (bin/"spotuify").write_env_script libexec/"spotuify", SPOTUIFY_INSTALL_SOURCE: "homebrew"
  end

  test do
    assert_match "spotuify #{version}", shell_output("#{bin}/spotuify --version")
    assert_match "spotuify-engine #{version}", shell_output("#{libexec}/spotuify-engine --version")
    assert_match "spotuify third-party software notices", shell_output("#{bin}/spotuify licenses")
  end
end
