class Desk < Formula
  desc "Lightweight workspace manager for the shell"
  homepage "https://github.com/jamesob/desk"
  url "https://github.com/outstand/desk/archive/v0.6.0-load2.tar.gz"
  sha256 "ed5543c3367b96cb21354991be45a858741ce388e8809b3c2f68a503f140a92e"
  version "v0.6.0-load2"

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
