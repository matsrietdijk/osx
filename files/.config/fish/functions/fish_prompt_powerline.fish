# Prompt style and implementation mostly taken from bobthefish theme:
# https://github.com/bpinto/oh-my-fish/blob/master/themes/bobthefish

# Helper functions
function __mats_pretty_parent -d 'Print a parent directory, shortened to fit the prompt'
  echo -n (dirname $argv[1]) | sed -e 's#/private##' -e "s#^$HOME#~#" -e 's#/\(\.\{0,1\}[^/]\)\([^/]*\)#/\1#g' -e 's#/$##'
end

# Segment handling
function __mats_start_left_segment -d 'Start a segment and close previous if exists'
  set -l bg $argv[1]
  set -e argv[1]
  set -l fg $argv[1]
  set -e argv[1]

  set_color normal
  set_color -b $bg
  set_color $fg $argv

  if [ "$__mats_current_left_bg" = 'NONE' ]
    echo -n ' '
  else
    if [ "$bg" = "$__mats_current_left_bg" ]
      echo -n "$__mats_right_arrow_glyph "
    else
      set_color $__mats_current_left_bg
      echo -n "$__mats_right_black_arrow_glyph "
      set_color $fg $argv
    end
  end

  set -g __mats_current_left_bg $bg
end

function __mats_finish_left_segments -d 'Close open prompt segments'
  if [ -n $__mats_current_left_bg -a $__mats_current_left_bg != 'NONE' ]
    set_color $__mats_current_left_bg -b 000
    echo -n "$__mats_right_black_arrow_glyph "
    set_color normal
  end

  set -g __mats_current_left_bg NONE
end

# Prompt segments
function __mats_prompt_status -d 'Display symbols for non zero exit status, root and background jobs'
  set -l nonzero
  set -l superuser
  set -l bj_jobs

  if [ $status -ne 0 ]
    set nonzero $__mats_nonzero_exit_glyph
  end

  if not set -q __mats_prompt_simple
    set -l uid (id -u $USER)
    if [ $uid -eq 0 ]
      set superuser $__mats_superuser_glyph
    end

    if [ (jobs -l | wc -l) -gt 0 ]
      set bg_jobs $__mats_bg_job_glyph
    end
    if [ "$nonzero" -o "$superuser" -o "$bg_jobs" ]
      __mats_start_left_segment fff 000
      if [ "$nonzero" ]
        set_color $__mats_med_red --bold
        echo -n $__mats_nonzero_exit_glyph
      end

      if [ "$superuser" ]
        set_color $__mats_med_green --bold
        echo -n $__mats_superuser_glyph
      end

      if [ "$bg_jobs" ]
        set_color $__mats_slate_blue --bold
        echo -n $__mats_bg_job_glyph
      end

      set_color normal
    end
  end
end

function __mats_prompt_dir -d 'Display current working directory'
  if [ -w "$PWD" ]
    __mats_start_left_segment $__mats_dk_grey $__mats_med_grey
  else
    __mats_start_left_segment $__mats_dk_red $__mats_lt_red
  end

  set -l directory
  set -l parent

  switch "$PWD"
    case /
      set directory '/'
    case "$HOME"
      set directory '~'
    case '*'
      set parent  (__mats_pretty_parent "$PWD")
      set parent  "$parent/"
      set directory (basename "$PWD")
  end

  [ "$parent" ]; and echo -n -s "$parent"
  set_color fff
  echo -n "$directory "
  set_color normal
end

function __mats_prompt_user -d 'Dislpay current user and host'
  if [ "$USER" != "$default_user" -o -n "$SSH_CLIENT" ]
    __mats_start_left_segment $__mats_lt_grey $__mats_slate_blue
    echo -n -s (whoami) '@' (hostname | cut -d . -f 1) ' '
  end
end

# Fish prompt
function fish_prompt_powerline --description 'Write out the prompt'
  __mats_prompt_status
  __mats_prompt_user
  __mats_prompt_dir
  __mats_finish_left_segments
end
