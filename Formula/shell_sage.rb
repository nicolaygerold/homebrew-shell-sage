class ShellSage < Formula
    include Language::Python::Virtualenv

    desc "AI-powered shell commands in your terminal"
    homepage "https://github.com/nicolaygerold/shell-sage"
    url "https://github.com/nicolaygerold/shell-sage/archive/refs/tags/v0.0.1.tar.gz"
    sha256 "21900dd1c3761f670bf6bc2546f6a6a2a044183296482c60ca71cdeb3e49c067"
    license "Apache-2.0"

    depends_on "python@3.12"
    depends_on "rust"
    depends_on "maturin" => :build

    resource "aisuite" do
      url "https://files.pythonhosted.org/packages/source/a/aisuite/aisuite-0.1.6.tar.gz"
      sha256 "0937372a4aa369ad63fa2350cf58780fdad6914e651e97ca7f6192a517e933b7"
    end

    resource "anthropic" do
      url "https://files.pythonhosted.org/packages/source/a/anthropic/anthropic-0.40.0.tar.gz"
      sha256 "3efeca6d9e97813f93ed34322c6c7ea2279bf0824cd0aa71b59ce222665e2b87"
    end

    resource "openai" do
      url "https://files.pythonhosted.org/packages/source/o/openai/openai-1.57.0.tar.gz"
      sha256 "76f91971c4bdbd78380c9970581075e0337b5d497c2fbf7b5255078f4b31abf9"
    end

    resource "rich" do
      url "https://files.pythonhosted.org/packages/source/r/rich/rich-13.9.4.tar.gz"
      sha256 "439594978a49a09530cff7ebc4b5c7103ef57baf48d5ea3184f21d9a2befa098"
    end

    resource "typer" do
      url "https://files.pythonhosted.org/packages/source/t/typer/typer-0.15.1.tar.gz"
      sha256 "a0588c0a7fa68a1978a069818657778f86abe6ff5ea6abf472f940a08bfe4f0a"
    end

    resource "httpx" do
      url "https://files.pythonhosted.org/packages/source/h/httpx/httpx-0.26.0.tar.gz"
      sha256 "451b55c30d5185ea6b23c2c793abf9bb237d2a7dfb901ced6ff69ad37ec1dfaf"
    end

    resource "httpcore" do
      url "https://files.pythonhosted.org/packages/source/h/httpcore/httpcore-1.0.2.tar.gz"
      sha256 "9fc092e4799b26174648e54b74ed5f683132a464e95643b226e00c2ed2fa6535"
    end

    resource "anyio" do
      url "https://files.pythonhosted.org/packages/source/a/anyio/anyio-4.3.0.tar.gz"
      sha256 "f75253795a87df48568485fd18cdd2a3fa5c4f7c5be8e5e36637733fce06fed6"
    end

    resource "certifi" do
      url "https://files.pythonhosted.org/packages/source/c/certifi/certifi-2024.2.2.tar.gz"
      sha256 "0569859f95fc761b18b45ef421b1290a0f65f147e92a1e5eb3e635f9a5e4e66f"
    end

    resource "distro" do
      url "https://files.pythonhosted.org/packages/source/d/distro/distro-1.9.0.tar.gz"
      sha256 "2fa77c6fd8940f116ee1d6b94a2f90b13b5ea8d019b98bc8bafdcabcdd9bdbed"
    end

    resource "h11" do
      url "https://files.pythonhosted.org/packages/source/h/h11/h11-0.14.0.tar.gz"
      sha256 "8f19fbbe99e72420ff35c00b27a34cb9937e902a8b810e2c88300c6f0a3b699d"
    end

    resource "idna" do
      url "https://files.pythonhosted.org/packages/source/i/idna/idna-3.6.tar.gz"
      sha256 "9ecdbbd083b06798ae1e86adcbfe8ab1479cf864e4ee30fe4e46a003d12491ca"
    end

    resource "sniffio" do
      url "https://files.pythonhosted.org/packages/source/s/sniffio/sniffio-1.3.1.tar.gz"
      sha256 "f4324edc670a0f49750a81b895f35c3adb843cca46f0530f79fc1babb23789dc"
    end

    resource "jiter" do
      url "https://files.pythonhosted.org/packages/source/j/jiter/jiter-0.8.0.tar.gz"
      sha256 "86fee98b569d4cc511ff2e3ec131354fafebd9348a487549c31ad371ae730310"
    end

    def install
      virtualenv_install_with_resources
    end

    test do
      assert_match "ShellSage", shell_output("#{bin}/ssage --help")
    end
  end