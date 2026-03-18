class Ptvc < Formula
  include Language::Python::Virtualenv

  desc "Pro Tools Version Control — versioned snapshots of Pro Tools sessions via PTSL"
  homepage "https://github.com/craigeley/ptvc"
  url "https://github.com/craigeley/ptvc/archive/refs/tags/v0.3.1.tar.gz"
  sha256 "5c013c476368a40dcc428f1d38650b9754c2811f8956d7a6bb88bbcc191c4788"
  license "MIT"

  depends_on "python@3.13"

  resource "grpcio" do
    url "https://files.pythonhosted.org/packages/55/06/0b78408e938ac424100100fd081189451b472236e8a3a1f6500390dc4954/grpcio-1.78.0-cp313-cp313-macosx_11_0_universal2.whl"
    sha256 "2bf5e2e163b356978b23652c4818ce4759d40f4712ee9ec5a83c4be6f8c23a3a"
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
