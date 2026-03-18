class Ptvc < Formula
  include Language::Python::Virtualenv

  desc "Pro Tools Version Control — versioned snapshots of Pro Tools sessions via PTSL"
  homepage "https://github.com/craigeley/ptvc"
  url "https://github.com/craigeley/ptvc/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "62e18f0154a4b9cc5df072917a5ea49caf034216b1c8007979878dbd4472226b"
  license "MIT"

  depends_on "python@3.13"

  resource "grpcio" do
    url "https://files.pythonhosted.org/packages/06/8a/3d098f35c143a89520e568e6539cc098fcd294495910e359889ce8741c84/grpcio-1.78.0.tar.gz"
    sha256 "7382b95189546f375c174f53a5fa873cef91c4b8005faa05cc5b3beea9c4f1c5"
  end

  resource "grpcio-tools" do
    url "https://files.pythonhosted.org/packages/8b/d1/cbefe328653f746fd319c4377836a25ba64226e41c6a1d7d5cdbc87a459f/grpcio_tools-1.78.0.tar.gz"
    sha256 "4b0dd86560274316e155d925158276f8564508193088bc43e20d3f5dff956b2b"
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
    virtualenv_install_with_resources
  end

  test do
    # ptvc requires Pro Tools to be running, so just verify the CLI loads
    assert_match "usage: ptvc", shell_output("#{bin}/ptvc --help")
  end
end
