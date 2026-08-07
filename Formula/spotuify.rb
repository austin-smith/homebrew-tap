class Spotuify < Formula
  desc "spotify in ur terminal"
  homepage "https://github.com/austin-smith/spotuify"
  version "0.2.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/austin-smith/spotuify/releases/download/v0.2.1/spotuify-v0.2.1-darwin-arm64.tar.gz"
      sha256 "b2e8d294621141e669dad2a3edb505242bd0767219e37478b9cb2e6179ca2b29"
    end
    depends_on arch: :arm64
    depends_on macos: :ventura
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/austin-smith/spotuify/releases/download/v0.2.1/spotuify-v0.2.1-linux-arm64.tar.gz"
      sha256 "9582c2ae2e6ca347420030ca2e9cc550971efb1654b35f36e15339c0e229a278"
    else
      url "https://github.com/austin-smith/spotuify/releases/download/v0.2.1/spotuify-v0.2.1-linux-x64.tar.gz"
      sha256 "44c31d8759cac57516326b22af350b78b1aff1d16edb40e1fd3b5eb31014ee15"
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
