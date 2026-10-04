# Generated from the v0.1.4 release manifest by cmd/mkformula; edit the generator, not this file.
class Blether < Formula
  desc "Terminal chat client for Status"
  homepage "https://github.com/forkthis-tech/blether-releases"
  version "0.1.4"
  license :cannot_represent

  on_macos do
    on_arm do
      depends_on macos: :sonoma
      url "https://github.com/forkthis-tech/blether-releases/releases/download/v0.1.4/blether_v0.1.4_darwin_arm64.tar.gz"
      sha256 "d504d62f38ebdda830f5be6e83daca7f5a31da54299d7a39ec660a9d05c43fdc"

      resource "backend" do
        url "https://github.com/forkthis-tech/blether-releases/releases/download/v0.1.4/status-backend_v10.35.3_darwin_arm64.tar.gz"
        sha256 "b67368ef015898deac9757a34deab6f8437f0a11648be700c8211fe55bd0a553"
      end
    end
    on_intel do
      depends_on macos: :ventura
      url "https://github.com/forkthis-tech/blether-releases/releases/download/v0.1.4/blether_v0.1.4_darwin_amd64.tar.gz"
      sha256 "5c95fd5888cd1ac2f4fee7ee8b462da300f8153901c8236cd671ff170b6ac8d3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/forkthis-tech/blether-releases/releases/download/v0.1.4/blether_v0.1.4_linux_arm64.tar.gz"
      sha256 "3d8a6c44a006bca9ad1017601663043b219b3336ca73fb64195d72001984cf2e"

      resource "backend" do
        url "https://github.com/forkthis-tech/blether-releases/releases/download/v0.1.4/status-backend_v10.35.3_linux_arm64.tar.gz"
        sha256 "81ff7655f445285116f15bb5603b5bcd7356ce45158990a9b29519b259cd5931"
      end
    end
    on_intel do
      url "https://github.com/forkthis-tech/blether-releases/releases/download/v0.1.4/blether_v0.1.4_linux_amd64.tar.gz"
      sha256 "e3cc630b793cfcce40ebccdf8c5f8396c1f3f1d3ddbe1193359391a07992e269"

      resource "backend" do
        url "https://github.com/forkthis-tech/blether-releases/releases/download/v0.1.4/status-backend_v10.35.3_linux_amd64.tar.gz"
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
    assert_match "blether v0.1.4", shell_output("#{bin}/blether version")
  end
end
