# Generated from the v0.1.7 release manifest by cmd/mkformula; edit the generator, not this file.
class Blether < Formula
  desc "Terminal chat client for Status"
  homepage "https://github.com/forkthis-tech/blether-releases"
  version "0.1.7"
  license :cannot_represent

  on_macos do
    on_arm do
      depends_on macos: :sonoma
      url "https://github.com/forkthis-tech/blether-releases/releases/download/v0.1.7/blether_v0.1.7_darwin_arm64.tar.gz"
      sha256 "d51bfdd692f2cf7300d309013afe1e0a0da66e629ea04e626e454d9499dff276"

      resource "backend" do
        url "https://github.com/forkthis-tech/blether-releases/releases/download/v0.1.7/status-backend_v10.35.3_darwin_arm64.tar.gz"
        sha256 "b67368ef015898deac9757a34deab6f8437f0a11648be700c8211fe55bd0a553"
      end
    end
    on_intel do
      depends_on macos: :ventura
      url "https://github.com/forkthis-tech/blether-releases/releases/download/v0.1.7/blether_v0.1.7_darwin_amd64.tar.gz"
      sha256 "36cf51c9c9fb4bc9d117c55a7a28e7940213b30d85d1bc5fca38fe3c19bca44c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/forkthis-tech/blether-releases/releases/download/v0.1.7/blether_v0.1.7_linux_arm64.tar.gz"
      sha256 "a2bbd87eedc6ad31933fc1eadf3c9b7d63f260bfef091e57264a8c7bfd5bfa23"

      resource "backend" do
        url "https://github.com/forkthis-tech/blether-releases/releases/download/v0.1.7/status-backend_v10.35.3_linux_arm64.tar.gz"
        sha256 "81ff7655f445285116f15bb5603b5bcd7356ce45158990a9b29519b259cd5931"
      end
    end
    on_intel do
      url "https://github.com/forkthis-tech/blether-releases/releases/download/v0.1.7/blether_v0.1.7_linux_amd64.tar.gz"
      sha256 "95ad1199cbe2fbff460b4464cdeef0fab8446204132a9289ee7a6529ba2c55e8"

      resource "backend" do
        url "https://github.com/forkthis-tech/blether-releases/releases/download/v0.1.7/status-backend_v10.35.3_linux_amd64.tar.gz"
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
    assert_match "blether v0.1.7", shell_output("#{bin}/blether version")
  end
end
