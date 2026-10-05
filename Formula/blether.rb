# Generated from the v0.1.6 release manifest by cmd/mkformula; edit the generator, not this file.
class Blether < Formula
  desc "Terminal chat client for Status"
  homepage "https://github.com/forkthis-tech/blether-releases"
  version "0.1.6"
  license :cannot_represent

  on_macos do
    on_arm do
      depends_on macos: :sonoma
      url "https://github.com/forkthis-tech/blether-releases/releases/download/v0.1.6/blether_v0.1.6_darwin_arm64.tar.gz"
      sha256 "ba48c99bf1da9b21df46c816b4a81c6cd47f2af62116ddfa7206ee97c8f6b521"

      resource "backend" do
        url "https://github.com/forkthis-tech/blether-releases/releases/download/v0.1.6/status-backend_v10.35.3_darwin_arm64.tar.gz"
        sha256 "b67368ef015898deac9757a34deab6f8437f0a11648be700c8211fe55bd0a553"
      end
    end
    on_intel do
      depends_on macos: :ventura
      url "https://github.com/forkthis-tech/blether-releases/releases/download/v0.1.6/blether_v0.1.6_darwin_amd64.tar.gz"
      sha256 "ac36f1636140a9d9fb1ffc0e4f81ec40b3ea502617b3e9454f008a391bd8540a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/forkthis-tech/blether-releases/releases/download/v0.1.6/blether_v0.1.6_linux_arm64.tar.gz"
      sha256 "678221fe7e00c0ed098cf387b1869423efc35a770df82ff14fcf30c4387d625f"

      resource "backend" do
        url "https://github.com/forkthis-tech/blether-releases/releases/download/v0.1.6/status-backend_v10.35.3_linux_arm64.tar.gz"
        sha256 "81ff7655f445285116f15bb5603b5bcd7356ce45158990a9b29519b259cd5931"
      end
    end
    on_intel do
      url "https://github.com/forkthis-tech/blether-releases/releases/download/v0.1.6/blether_v0.1.6_linux_amd64.tar.gz"
      sha256 "121c48df3cd2a6d9706a234ac8a0c126ce83149dcd77d0bd1c0acb3cbb942e12"

      resource "backend" do
        url "https://github.com/forkthis-tech/blether-releases/releases/download/v0.1.6/status-backend_v10.35.3_linux_amd64.tar.gz"
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
    assert_match "blether v0.1.6", shell_output("#{bin}/blether version")
  end
end
