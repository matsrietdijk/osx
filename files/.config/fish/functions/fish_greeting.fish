function fish_greeting --description "Shell welcome message"
  if not set -q __mats_prompt_simple
    if not set -q __fish_hostname
      set -g __fish_hostname (hostname | cut -d . -f 1)
    end
    if not set -q __fish_prompt_normal
      set -g __fish_prompt_normal (set_color normal)
    end

    set_color 777 ; echo (uptime | sed 's/^ //')
    set_color ddd ; echo -n $USER
    set_color 777 ; echo -n ' at '
    set_color ddd ; echo -n $__fish_hostname
    set_color 777 ; echo -n ' in '
    set_color ddd ; echo -n $PWD
    set_color 777 ; echo -n ' with '
    set_color ddd ; echo -n '><((*>'
    echo $__fish_prompt_normal
  end
end
