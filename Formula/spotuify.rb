class Spotuify < Formula
  desc "spotify in ur terminal"
  homepage "https://github.com/austin-smith/spotuify"
  version "0.1.0"
  url "https://github.com/austin-smith/spotuify/releases/download/v0.1.0/spotuify-v0.1.0-darwin-arm64.tar.gz"
  sha256 "f88388d0ddcf9939b6c1c8d5b95a64736ac56e1becb51144d252f87a7a2818a5"
  license "MIT"

  depends_on macos: :ventura
  depends_on arch: :arm64

  def install
    libexec.install "spotuify", "spotuify-engine"
    (bin/"spotuify").write_env_script libexec/"spotuify", SPOTUIFY_INSTALL_SOURCE: "homebrew"
  end

  test do
    assert_match "spotuify #{version}", shell_output("#{bin}/spotuify --version")
    assert_match "spotuify-engine #{version}", shell_output("#{libexec}/spotuify-engine --version")
    assert_match "spotuify third-party software notices", shell_output("#{bin}/spotuify licenses")
  end
end
