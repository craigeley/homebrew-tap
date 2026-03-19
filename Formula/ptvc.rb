class Ptvc < Formula
  include Language::Python::Virtualenv

  desc "Pro Tools Version Control — versioned snapshots of Pro Tools sessions via PTSL"
  homepage "https://github.com/craigeley/ptvc"
  url "https://github.com/craigeley/ptvc/archive/refs/tags/v0.5.2.tar.gz"
  sha256 "58dfa48dfe2b48961d1ba4b2b5e7b24e79c83608607ab302dbd2e3ff3b4f592c"
  license "MIT"

  depends_on "python@3.13"

  resource "pyyaml" do
    url "https://files.pythonhosted.org/packages/05/8e/961c0007c59b8dd7729d542c61a4d537767a59645b82a0b521206e1e25c2/pyyaml-6.0.3.tar.gz"
    sha256 "d76623373421df22fb4cf8817020cbb7ef15c725b9d5e45f17e189bfc384190f"
  end

  resource "protobuf" do
    url "https://files.pythonhosted.org/packages/ba/25/7c72c307aafc96fa87062aa6291d9f7c94836e43214d43722e86037aac02/protobuf-6.33.5.tar.gz"
    sha256 "6ddcac2a081f8b7b9642c09406bc6a4290128fce5f471cddd165960bb9119e5c"
  end

  resource "setuptools" do
    url "https://files.pythonhosted.org/packages/4f/db/cfac1baf10650ab4d1c111714410d2fbb77ac5a616db26775db562c8fab2/setuptools-82.0.1.tar.gz"
    sha256 "7d872682c5d01cfde07da7bccc7b65469d3dca203318515ada1de5eda35efbf9"
  end

  resource "typing-extensions" do
    url "https://files.pythonhosted.org/packages/72/94/1a15dd82efb362ac84269196e94cf00f187f7ed21c242792a923cdb1c61f/typing_extensions-4.15.0.tar.gz"
    sha256 "0cea48d173cc12fa28ecabc3b837ea3cf6f38c6d1136f85cbaaf598984861466"
  end

  def install
    venv = virtualenv_create(libexec, "python3.13")

    # Install grpcio from PyPI using pre-built wheel.
    # Homebrew's pip helpers force --no-binary=:all: which requires compiling
    # grpcio's C core from source — this fails without a full Xcode install.
    # Third-party taps don't have bottling CI, so we bypass this for grpcio.
    python = Formula["python@3.13"].opt_bin/"python3.13"
    system python, "-m", "pip",
           "--python=#{libexec}/bin/python",
           "install", "--no-deps", "--ignore-installed",
           "grpcio==1.78.0"

    # Install remaining pure-Python resources normally
    venv.pip_install resources

    # Install ptvc itself
    venv.pip_install_and_link buildpath
  end

  test do
    # ptvc requires Pro Tools to be running, so just verify the CLI loads
    assert_match "usage: ptvc", shell_output("#{bin}/ptvc --help")
    assert_match "ptvc 0.5.2", shell_output("#{bin}/ptvc --version")
  end
end
