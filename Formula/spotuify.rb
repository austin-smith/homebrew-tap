class Spotuify < Formula
  desc "spotify in ur terminal"
  homepage "https://github.com/austin-smith/spotuify"
  version "0.2.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/austin-smith/spotuify/releases/download/v0.2.0/spotuify-v0.2.0-darwin-arm64.tar.gz"
      sha256 "01b7893bba861805eaf8710679b0469efc0fca234dbab036d9d0016638c48684"
    end
    depends_on arch: :arm64
    depends_on macos: :ventura
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/austin-smith/spotuify/releases/download/v0.2.0/spotuify-v0.2.0-linux-arm64.tar.gz"
      sha256 "860d9574ca99531b9dd4899647134a4c8ff16502a27ea477f4f435bbfbe6d714"
    else
      url "https://github.com/austin-smith/spotuify/releases/download/v0.2.0/spotuify-v0.2.0-linux-x64.tar.gz"
      sha256 "53a956b04c072f9e809c0de998fc344d8bdcae541df405d9728fe6c5d6c489d9"
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
