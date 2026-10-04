# Generated from the v0.1.3 release manifest by cmd/mkformula; edit the generator, not this file.
class Blether < Formula
  desc "Terminal chat client for Status"
  homepage "https://github.com/forkthis-tech/blether-releases"
  version "0.1.3"
  license :cannot_represent

  on_macos do
    on_arm do
      depends_on macos: :sonoma
      url "https://github.com/forkthis-tech/blether-releases/releases/download/v0.1.3/blether_v0.1.3_darwin_arm64.tar.gz"
      sha256 "65c634bcc1d2e22029914cf7ee3cb8b232fb148ffd6e0ce4f4524e8c53410ec7"

      resource "backend" do
        url "https://github.com/forkthis-tech/blether-releases/releases/download/v0.1.3/status-backend_v10.35.3_darwin_arm64.tar.gz"
        sha256 "b67368ef015898deac9757a34deab6f8437f0a11648be700c8211fe55bd0a553"
      end
    end
    on_intel do
      depends_on macos: :ventura
      url "https://github.com/forkthis-tech/blether-releases/releases/download/v0.1.3/blether_v0.1.3_darwin_amd64.tar.gz"
      sha256 "32c94fcb9879a5dca871de63c98abb83759ce5d218fde8ce90ea1597b024f1ef"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/forkthis-tech/blether-releases/releases/download/v0.1.3/blether_v0.1.3_linux_arm64.tar.gz"
      sha256 "a61772e84e25d79d30fdd74ba5ea486a7637e4cb211b608bbcc31c98677cff30"

      resource "backend" do
        url "https://github.com/forkthis-tech/blether-releases/releases/download/v0.1.3/status-backend_v10.35.3_linux_arm64.tar.gz"
        sha256 "81ff7655f445285116f15bb5603b5bcd7356ce45158990a9b29519b259cd5931"
      end
    end
    on_intel do
      url "https://github.com/forkthis-tech/blether-releases/releases/download/v0.1.3/blether_v0.1.3_linux_amd64.tar.gz"
      sha256 "29146a75b918d9369e425171a11e55e031936c1608a1aef9959c9a6e6507c6a0"

      resource "backend" do
        url "https://github.com/forkthis-tech/blether-releases/releases/download/v0.1.3/status-backend_v10.35.3_linux_amd64.tar.gz"
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
    assert_match "blether v0.1.3", shell_output("#{bin}/blether version")
  end
end
