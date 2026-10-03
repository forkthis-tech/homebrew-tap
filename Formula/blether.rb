# Generated from the v0.1.2 release manifest by cmd/mkformula; edit the generator, not this file.
class Blether < Formula
  desc "Terminal chat client for Status"
  homepage "https://github.com/forkthis-tech/blether-releases"
  version "0.1.2"
  license :cannot_represent

  on_macos do
    on_arm do
      depends_on macos: :sonoma
      url "https://github.com/forkthis-tech/blether-releases/releases/download/v0.1.2/blether_v0.1.2_darwin_arm64.tar.gz"
      sha256 "c8d852a6c7b7489a94ab5e6bc8de415f171059758b94ac2465016cb05902737b"

      resource "backend" do
        url "https://github.com/forkthis-tech/blether-releases/releases/download/v0.1.2/status-backend_v10.35.3_darwin_arm64.tar.gz"
        sha256 "b67368ef015898deac9757a34deab6f8437f0a11648be700c8211fe55bd0a553"
      end
    end
    on_intel do
      depends_on macos: :ventura
      url "https://github.com/forkthis-tech/blether-releases/releases/download/v0.1.2/blether_v0.1.2_darwin_amd64.tar.gz"
      sha256 "b389502f507c20c95736f8f88f68c3b0d2cad561b8d4d8c35c3ec2854b04ccbd"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/forkthis-tech/blether-releases/releases/download/v0.1.2/blether_v0.1.2_linux_arm64.tar.gz"
      sha256 "b2f2001c7a89ad8790bd2263d926f7578d95616467c900675955adfca6525623"

      resource "backend" do
        url "https://github.com/forkthis-tech/blether-releases/releases/download/v0.1.2/status-backend_v10.35.3_linux_arm64.tar.gz"
        sha256 "81ff7655f445285116f15bb5603b5bcd7356ce45158990a9b29519b259cd5931"
      end
    end
    on_intel do
      url "https://github.com/forkthis-tech/blether-releases/releases/download/v0.1.2/blether_v0.1.2_linux_amd64.tar.gz"
      sha256 "ad76fe28d3c08422e677da0b828bb44399645536905a690c937f54037d6e893d"

      resource "backend" do
        url "https://github.com/forkthis-tech/blether-releases/releases/download/v0.1.2/status-backend_v10.35.3_linux_amd64.tar.gz"
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
        There is no ready-made backend for Intel Macs. Run it in Docker:
          docker build -t status-backend:866240cb3 https://github.com/status-im/status-go.git#866240cb3b59abc1fb6ea221ce6a8cf80fabb0a5
          export BLETHER_BACKEND_IMAGE=status-backend:866240cb3
      EOS
    end
  end

  test do
    assert_match "blether v0.1.2", shell_output("#{bin}/blether version")
  end
end
