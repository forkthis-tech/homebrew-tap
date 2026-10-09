# Generated from the v0.1.13 release manifest by cmd/mkformula; edit the generator, not this file.
class Blether < Formula
  desc "Terminal chat client for Status"
  homepage "https://github.com/forkthis-tech/blether-releases"
  version "0.1.13"
  license :cannot_represent

  on_macos do
    on_arm do
      depends_on macos: :sonoma
      url "https://github.com/forkthis-tech/blether-releases/releases/download/v0.1.13/blether_v0.1.13_darwin_arm64.tar.gz"
      sha256 "e1ddba75efaae8cb6db2240365ad0c1517dd485fcd7cfb0b1edba716c472c593"

      resource "backend" do
        url "https://github.com/forkthis-tech/blether-releases/releases/download/v0.1.13/status-backend_v10.35.3_darwin_arm64.tar.gz"
        sha256 "b67368ef015898deac9757a34deab6f8437f0a11648be700c8211fe55bd0a553"
      end
    end
    on_intel do
      depends_on macos: :ventura
      url "https://github.com/forkthis-tech/blether-releases/releases/download/v0.1.13/blether_v0.1.13_darwin_amd64.tar.gz"
      sha256 "8321cf3619c6d224e8d90d45d2b59f50e07f2f9c31573c8ecc1cc6476efeee4e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/forkthis-tech/blether-releases/releases/download/v0.1.13/blether_v0.1.13_linux_arm64.tar.gz"
      sha256 "f960f3300ddeeb7039da7e216cfe3807fe52aedcac1940e5cee7968cd0e76a14"

      resource "backend" do
        url "https://github.com/forkthis-tech/blether-releases/releases/download/v0.1.13/status-backend_v10.35.3_linux_arm64.tar.gz"
        sha256 "81ff7655f445285116f15bb5603b5bcd7356ce45158990a9b29519b259cd5931"
      end
    end
    on_intel do
      url "https://github.com/forkthis-tech/blether-releases/releases/download/v0.1.13/blether_v0.1.13_linux_amd64.tar.gz"
      sha256 "775cce4d2567de96fface8566b12119be9c44dd46b9fbae9951e0d38af397cba"

      resource "backend" do
        url "https://github.com/forkthis-tech/blether-releases/releases/download/v0.1.13/status-backend_v10.35.3_linux_amd64.tar.gz"
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
    assert_match "blether v0.1.13", shell_output("#{bin}/blether version")
  end
end
