# Homebrew formula for rushtex, bottle-less: it installs the release's prebuilt binary (the
# core build). A template: packaging/homebrew/update.sh vX.Y.Z fills VERSION and the four
# sha256 values from that release's SHA256SUMS and writes the formula for the tap
# (packaging/README.md).
class Rushtex < Formula
  desc "LaTeX to PDF compiler, output identical to pdfLaTeX, in pure safe Rust"
  homepage "https://abhksinha.github.io/RushTeX/"
  version "0.1.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    depends_on macos: :ventura

    on_arm do
      url "https://github.com/abhksinha/RushTeX/releases/download/v#{version}/rushtex-aarch64-apple-darwin.tar.gz"
      sha256 "9ad37ff12680069ffb5908e7947f4789384346eeaedc5acd09d3e36b5a39ca12"
    end
    on_intel do
      url "https://github.com/abhksinha/RushTeX/releases/download/v#{version}/rushtex-x86_64-apple-darwin.tar.gz"
      sha256 "bd83e7ab452aa57b719e59354febfecbfc092881f7939cb51f4dbac05a6e00c5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/abhksinha/RushTeX/releases/download/v#{version}/rushtex-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "8542ef88abcd4a87188e3e970c5b2c40b1b83d679d6b3d577b718bf402da9281"
    end
    on_intel do
      url "https://github.com/abhksinha/RushTeX/releases/download/v#{version}/rushtex-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "26a3d97b2fa5e58ed4425e702a7b9b045eb0de68c5e43d3b4d9df4f84102caaa"
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
