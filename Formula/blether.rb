# Generated from the v0.1.11 release manifest by cmd/mkformula; edit the generator, not this file.
class Blether < Formula
  desc "Terminal chat client for Status"
  homepage "https://github.com/forkthis-tech/blether-releases"
  version "0.1.11"
  license :cannot_represent

  on_macos do
    on_arm do
      depends_on macos: :sonoma
      url "https://github.com/forkthis-tech/blether-releases/releases/download/v0.1.11/blether_v0.1.11_darwin_arm64.tar.gz"
      sha256 "441188d377d241d5dea593ab329f278a562582162af8593d04c8d2445947621d"

      resource "backend" do
        url "https://github.com/forkthis-tech/blether-releases/releases/download/v0.1.11/status-backend_v10.35.3_darwin_arm64.tar.gz"
        sha256 "b67368ef015898deac9757a34deab6f8437f0a11648be700c8211fe55bd0a553"
      end
    end
    on_intel do
      depends_on macos: :ventura
      url "https://github.com/forkthis-tech/blether-releases/releases/download/v0.1.11/blether_v0.1.11_darwin_amd64.tar.gz"
      sha256 "493926cdc50ac573e1db4129482ed9a67152c7588ad946eda4ee213c92a107f7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/forkthis-tech/blether-releases/releases/download/v0.1.11/blether_v0.1.11_linux_arm64.tar.gz"
      sha256 "4140e7cc6ab83fc8ada9c4433eb59696d513b261cbc07cb555b6086e7408a468"

      resource "backend" do
        url "https://github.com/forkthis-tech/blether-releases/releases/download/v0.1.11/status-backend_v10.35.3_linux_arm64.tar.gz"
        sha256 "81ff7655f445285116f15bb5603b5bcd7356ce45158990a9b29519b259cd5931"
      end
    end
    on_intel do
      url "https://github.com/forkthis-tech/blether-releases/releases/download/v0.1.11/blether_v0.1.11_linux_amd64.tar.gz"
      sha256 "04423f80ec6171ea873d1cf0dbcca7a4f9897e72ff4daa44f8882e3fd306eebd"

      resource "backend" do
        url "https://github.com/forkthis-tech/blether-releases/releases/download/v0.1.11/status-backend_v10.35.3_linux_amd64.tar.gz"
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
    assert_match "blether v0.1.11", shell_output("#{bin}/blether version")
  end
end
