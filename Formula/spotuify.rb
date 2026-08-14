class Spotuify < Formula
  desc "spotify in ur terminal"
  homepage "https://github.com/austin-smith/spotuify"
  version "0.2.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/austin-smith/spotuify/releases/download/v0.2.2/spotuify-v0.2.2-darwin-arm64.tar.gz"
      sha256 "a750a7aa18e6375ca4edf80fe5ee46798bba2bf96eeb6f4523ba09566695e81d"
    end
    depends_on arch: :arm64
    depends_on macos: :ventura
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/austin-smith/spotuify/releases/download/v0.2.2/spotuify-v0.2.2-linux-arm64.tar.gz"
      sha256 "cc4ba6cbec484fa285dd5bb1a131ac3ba66c4f21e69b4c75f86f36e3f4f578dd"
    else
      url "https://github.com/austin-smith/spotuify/releases/download/v0.2.2/spotuify-v0.2.2-linux-x64.tar.gz"
      sha256 "6e2955ff9e814a20edd6a6ca142e8799eaf3b6d981ffcd40e5ab9143384bf4be"
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
