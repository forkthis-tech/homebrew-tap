# Generated from the v0.1.10 release manifest by cmd/mkformula; edit the generator, not this file.
class Blether < Formula
  desc "Terminal chat client for Status"
  homepage "https://github.com/forkthis-tech/blether-releases"
  version "0.1.10"
  license :cannot_represent

  on_macos do
    on_arm do
      depends_on macos: :sonoma
      url "https://github.com/forkthis-tech/blether-releases/releases/download/v0.1.10/blether_v0.1.10_darwin_arm64.tar.gz"
      sha256 "a647e83d270295bb0853a5aca6e2a5d52f6847976117f195bcb144c179cd7221"

      resource "backend" do
        url "https://github.com/forkthis-tech/blether-releases/releases/download/v0.1.10/status-backend_v10.35.3_darwin_arm64.tar.gz"
        sha256 "b67368ef015898deac9757a34deab6f8437f0a11648be700c8211fe55bd0a553"
      end
    end
    on_intel do
      depends_on macos: :ventura
      url "https://github.com/forkthis-tech/blether-releases/releases/download/v0.1.10/blether_v0.1.10_darwin_amd64.tar.gz"
      sha256 "687bceb4d0766af828851633aff1e2f913f79b280a2431113eb227b2867af1a8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/forkthis-tech/blether-releases/releases/download/v0.1.10/blether_v0.1.10_linux_arm64.tar.gz"
      sha256 "b297d4c692673ca828f16a90b297b3df41dbffed7cf3c02da751f2e9588f6c41"

      resource "backend" do
        url "https://github.com/forkthis-tech/blether-releases/releases/download/v0.1.10/status-backend_v10.35.3_linux_arm64.tar.gz"
        sha256 "81ff7655f445285116f15bb5603b5bcd7356ce45158990a9b29519b259cd5931"
      end
    end
    on_intel do
      url "https://github.com/forkthis-tech/blether-releases/releases/download/v0.1.10/blether_v0.1.10_linux_amd64.tar.gz"
      sha256 "30f43302ff704468172971e40f06f875f7ba7247ba048522710ac7d21ad9c575"

      resource "backend" do
        url "https://github.com/forkthis-tech/blether-releases/releases/download/v0.1.10/status-backend_v10.35.3_linux_amd64.tar.gz"
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
    assert_match "blether v0.1.10", shell_output("#{bin}/blether version")
  end
end
