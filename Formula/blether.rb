# Generated from the v0.1.5 release manifest by cmd/mkformula; edit the generator, not this file.
class Blether < Formula
  desc "Terminal chat client for Status"
  homepage "https://github.com/forkthis-tech/blether-releases"
  version "0.1.5"
  license :cannot_represent

  on_macos do
    on_arm do
      depends_on macos: :sonoma
      url "https://github.com/forkthis-tech/blether-releases/releases/download/v0.1.5/blether_v0.1.5_darwin_arm64.tar.gz"
      sha256 "e437fd7ee5f2e568903739581ff6f3cf03a1cb6e7afa0058139206d0d89d65e2"

      resource "backend" do
        url "https://github.com/forkthis-tech/blether-releases/releases/download/v0.1.5/status-backend_v10.35.3_darwin_arm64.tar.gz"
        sha256 "b67368ef015898deac9757a34deab6f8437f0a11648be700c8211fe55bd0a553"
      end
    end
    on_intel do
      depends_on macos: :ventura
      url "https://github.com/forkthis-tech/blether-releases/releases/download/v0.1.5/blether_v0.1.5_darwin_amd64.tar.gz"
      sha256 "b4ceca168fd3c149766b8625810615c5bb11ba9b728767b4a613bbb1c25903a2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/forkthis-tech/blether-releases/releases/download/v0.1.5/blether_v0.1.5_linux_arm64.tar.gz"
      sha256 "b8f73a968ff5118789fa742e1438821384d77e290efb35ede7529272292344ad"

      resource "backend" do
        url "https://github.com/forkthis-tech/blether-releases/releases/download/v0.1.5/status-backend_v10.35.3_linux_arm64.tar.gz"
        sha256 "81ff7655f445285116f15bb5603b5bcd7356ce45158990a9b29519b259cd5931"
      end
    end
    on_intel do
      url "https://github.com/forkthis-tech/blether-releases/releases/download/v0.1.5/blether_v0.1.5_linux_amd64.tar.gz"
      sha256 "4395a01a2d142ee7d35d2e2417a205babb580ba4cf95b7348052d304c3b4dbe7"

      resource "backend" do
        url "https://github.com/forkthis-tech/blether-releases/releases/download/v0.1.5/status-backend_v10.35.3_linux_amd64.tar.gz"
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
    assert_match "blether v0.1.5", shell_output("#{bin}/blether version")
  end
end
