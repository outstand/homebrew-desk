class Desk < Formula
  desc "Lightweight workspace manager for the shell"
  homepage "https://github.com/jamesob/desk"
  url "https://github.com/outstand/desk/archive/v0.6.0-load.tar.gz"
  sha256 "f31bf13b515d2732a5af19d652b3f4cc032c506e4201efdc1f4875f5795da372"
  version "v0.6.0-load"

  bottle :unneeded

  def install
    bin.install "desk"
    bash_completion.install "shell_plugins/bash/desk"
    zsh_completion.install "shell_plugins/zsh/_desk"
    fish_completion.install "shell_plugins/fish/desk.fish"
  end

  def caveats
    <<~EOS
      For `desk go` to work, add the following to your $HOME/.bashrc or $HOME/.zshrc:
        # Hook for desk activation
        [ -n "$DESK_ENV" ] && source "$DESK_ENV" || true
    EOS
  end

  test do
    (testpath/".desk/desks/test-desk.sh").write("#\n# Description: A test desk\n#")
    list = pipe_output("#{bin}/desk list")
    assert_match /test-desk/, list
    assert_match /A test desk/, list
  end
end
