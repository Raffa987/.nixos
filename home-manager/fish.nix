{
  ...
}:


{
  programs.fish = {
    enable = true;
    functions = {
      fish_greeting = {
        body = "if not set -q NO_FASTFETCH
          fastfetch
          end";
      };
      fish_prompt = {
        body = ''
          if test -n "$SSH_TTY"
          echo -n (set_color brred)"$USER"(set_color white)'@'(set_color yellow)(prompt_hostname)' '
          end

          echo -n (set_color white)(prompt_pwd)' '

          set_color -o
          if fish_is_root_user
              echo -n (set_color red)'# '
          end
          echo -n (set_color blue)'<(´= ⩊ =`)> '
          
          set_color normal
        '';
      };
    };
  };
  }