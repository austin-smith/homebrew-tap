class Spotuify < Formula
  desc "spotify in ur terminal"
  homepage "https://github.com/austin-smith/spotuify"
  version "0.1.1"
  url "https://github.com/austin-smith/spotuify/releases/download/v0.1.1/spotuify-v0.1.1-darwin-arm64.tar.gz"
  sha256 "974d8531e64f48e86b371f815d9fabf8cac8187fab80dc66be51e7bd2844a811"
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
