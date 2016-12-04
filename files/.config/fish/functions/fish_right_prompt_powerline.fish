# Prompt style and implementation mostly taken from bobthefish theme:
# https://github.com/bpinto/oh-my-fish/blob/master/themes/bobthefish

# Helper functions
function __mats_git_branch -d 'Get the current git branch (or commitish)'
  set -l ref (command git symbolic-ref HEAD ^/dev/null)
  if [ $status -gt 0 ]
  set -l branch (command git show-ref --head -s --abbrev | head -n1 ^/dev/null)
  set ref "$__mats_detached_glyph $branch"
  end
  echo $ref | sed  "s#refs/heads/#$__mats_branch_glyph #"
end

# Segment handling
function __mats_start_right_segment -d 'Start a segment'
  set -l bg $argv[1]
  set -e argv[1]
  set -l fg $argv[1]
  set -e argv[1]

  set_color normal

  if [ -n $__mats_current_right_bg -a $__mats_current_right_bg != 'NONE' ]
    if [ "$bg" = "$__mats_current_right_bg" ]
      set_color -b $bg
      set_color $fg $argv
      echo -n "$__mats_left_arrow_glyph"
    else
      set_color $bg -b $__mats_current_right_bg
      echo -n "$__mats_left_black_arrow_glyph"
    end
  else
    set_color $bg -b 000
    echo -n "$__mats_left_black_arrow_glyph"
  end

  set_color -b $bg
  set_color $fg $argv

  set -g __mats_current_right_bg $bg
end

function __mats_finish_right_segments -d 'Close open prompt segments'
  if [ "$__mats_current_right_bg" != 'NONE' ]
    set_color -b $__mats_current_right_bg
    echo -n ' '
    set_color normal
  end

  set -g __mats_current_right_bg NONE
end

# Prompt segments
function __mats_prompt_date
  set_color $__mats_dk_grey
  date "+%H:%M:%S "
  set_color normal
end

function __mats_prompt_git
  __mats_start_right_segment $__mats_dk_grey $__mats_med_grey
  echo -n ' '
  __mats_git_branch
  echo -n ' '

  set -l dirty   (command git diff --no-ext-diff --quiet --exit-code; or echo -n $__mats_dirty_glyph)
  set -l staged  (command git diff --cached --no-ext-diff --quiet --exit-code; or echo -n $__mats_staged_glyph)
  set -l stashed (command git rev-parse --verify --quiet refs/stash >/dev/null; and echo -n $__mats_stashed_glyph)
  set -l new (command git ls-files --other --exclude-standard);
  [ "$new" ]; and set new $__mats_new_glyph

  set -l flag_bg $__mats_lt_green
  set -l flag_fg $__mats_dk_green
  if [ "$dirty" -o "$staged" ]
    set flag_bg $__mats_med_red
    set flag_fg fff
  else if [ "$stashed" ]
    set flag_bg $__mats_lt_orange
    set flag_fg $__mats_dk_orange
  end

  __mats_start_right_segment $flag_bg $flag_fg --bold

  set -l flags "$new$staged$stashed$dirty"
  [ "$flags" ]; and echo -n "$flags"; or echo -n $__mats_clean_glyph

  set_color normal
end

# Fish right prompt
function fish_right_prompt_powerline
  __mats_prompt_date
  if git rev-parse --is-inside-work-tree >/dev/null 2>&1
  __mats_prompt_git
  end
  __mats_finish_right_segments
end
