# Generated from the v0.1.8 release manifest by cmd/mkformula; edit the generator, not this file.
class Blether < Formula
  desc "Terminal chat client for Status"
  homepage "https://github.com/forkthis-tech/blether-releases"
  version "0.1.8"
  license :cannot_represent

  on_macos do
    on_arm do
      depends_on macos: :sonoma
      url "https://github.com/forkthis-tech/blether-releases/releases/download/v0.1.8/blether_v0.1.8_darwin_arm64.tar.gz"
      sha256 "52e6731b2325510b8b3fcab1c459a023bd0568c4d83cecb95242316b16bde5bf"

      resource "backend" do
        url "https://github.com/forkthis-tech/blether-releases/releases/download/v0.1.8/status-backend_v10.35.3_darwin_arm64.tar.gz"
        sha256 "b67368ef015898deac9757a34deab6f8437f0a11648be700c8211fe55bd0a553"
      end
    end
    on_intel do
      depends_on macos: :ventura
      url "https://github.com/forkthis-tech/blether-releases/releases/download/v0.1.8/blether_v0.1.8_darwin_amd64.tar.gz"
      sha256 "f404b32d2fa6e0ed2dd7296c817f01bf265b7ec1fc4dd0797a9a4970efb4cdb1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/forkthis-tech/blether-releases/releases/download/v0.1.8/blether_v0.1.8_linux_arm64.tar.gz"
      sha256 "f931b4730ce2c1f8e74ba6dc30daf349bca475e47b613b0b4e955f3bb017b5dc"

      resource "backend" do
        url "https://github.com/forkthis-tech/blether-releases/releases/download/v0.1.8/status-backend_v10.35.3_linux_arm64.tar.gz"
        sha256 "81ff7655f445285116f15bb5603b5bcd7356ce45158990a9b29519b259cd5931"
      end
    end
    on_intel do
      url "https://github.com/forkthis-tech/blether-releases/releases/download/v0.1.8/blether_v0.1.8_linux_amd64.tar.gz"
      sha256 "589cc86d81177967fe26e522edc9e3a864daa8c63b4824f6e26ce67ac3611630"

      resource "backend" do
        url "https://github.com/forkthis-tech/blether-releases/releases/download/v0.1.8/status-backend_v10.35.3_linux_amd64.tar.gz"
        sha256 "1c324b85b5b03142402e5f8766a69d001dee233d9c77f38762e5963a3b7ee26a"
      end
    end
  end

  def install
    bin.install "blether"
    if resources.any? { |r| r.name == "backend" }
      resource("backend").stage { (libexec/"backend").install Dir["*"] }
    end
    generate_completions_from_executable(bin/"blether", "completion")
  end

  def caveats
    return unless OS.mac?
    return unless Hardware::CPU.intel?

    if Hardware::CPU.in_rosetta2?
      <<~EOS
        This Homebrew runs under Rosetta, so it installed the Intel build, which has no backend.
        Homebrew for Apple silicon installs the Apple-silicon build and its backend:
          brew uninstall blether
          /opt/homebrew/bin/brew install forkthis-tech/tap/blether
      EOS
    else
      <<~EOS
        There is no ready-made backend for Intel Macs, so Blether cannot run on this Mac yet.
      EOS
    end
  end

  test do
    assert_match "blether v0.1.8", shell_output("#{bin}/blether version")
  end
end
