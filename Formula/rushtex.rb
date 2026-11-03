# Homebrew formula for rushtex, bottle-less: it installs the release's prebuilt binary (the
# core build). A template: packaging/homebrew/update.sh vX.Y.Z fills VERSION and the four
# sha256 values from that release's SHA256SUMS and writes the formula for the tap
# (packaging/README.md).
class Rushtex < Formula
  desc "LaTeX to PDF compiler, output identical to pdfLaTeX, in pure safe Rust"
  homepage "https://abhksinha.github.io/RushTeX/"
  version "0.1.1"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    depends_on macos: :ventura

    on_arm do
      url "https://github.com/abhksinha/RushTeX/releases/download/v#{version}/rushtex-aarch64-apple-darwin.tar.gz"
      sha256 "cd604112a95b9a4af6fc5c3df6480789743559a98c63128e7781421a99606199"
    end
    on_intel do
      url "https://github.com/abhksinha/RushTeX/releases/download/v#{version}/rushtex-x86_64-apple-darwin.tar.gz"
      sha256 "c950d6e71115939aa9562b4d38ce7135dcfdb0d4900376bb33961f86f8f9a0b7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/abhksinha/RushTeX/releases/download/v#{version}/rushtex-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b63cbbeb036d38bb3596ae9fc2e5c96b87828fd1e1a44fa5db5a3fda0d9b72be"
    end
    on_intel do
      url "https://github.com/abhksinha/RushTeX/releases/download/v#{version}/rushtex-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "74bf6032d2786c8b18664ffbbcaafab700b7c933a78d90f1ff6bbfad15b6ce14"
    end
  end

  def install
    bin.install "rushtex"
  end

  test do
    (testpath/"t.tex").write <<~TEX
      \\documentclass{article}
      \\begin{document}
      Hello, $x^2$.
      \\end{document}
    TEX
    system bin/"rushtex", "t.tex"
    assert_path_exists testpath/"t.pdf"
  end
end
