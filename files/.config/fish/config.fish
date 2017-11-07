source ~/.config/fish/vars.fish

if set -q __mats_prompt_simple
  function fish_prompt;       fish_prompt_simple; end
  function fish_right_prompt; fish_right_prompt_simple; end
else
  function fish_prompt;       fish_prompt_powerline; end
  function fish_right_prompt; fish_right_prompt_powerline; end
end

function safari;  open -a Safari $argv; end
function spotify; open -a Spotify $argv; end
function slack;   open -a Slack $argv; end
function trello;  safari https://trello.com $argv; end
function e;       emacs $argv &; end
function para;    trello; spotify; slack; emacs &; end

abbr -a -- -       'cd -'
abbr -a -- ...     '../..'
abbr -a -- ....    '../../..'
abbr -a -- .....   '../../../..'
abbr -a -- ......  '../../../../..'
abbr -a -- ....... '../../../../../..'
abbr -a -- .2      '../..'
abbr -a -- .3      '../../..'
abbr -a -- .4      '../../../..'
abbr -a -- .5      '../../../../..'
abbr -a -- .6      '../../../../../..'

if command -s hub >/dev/null
  function git; hub $argv; end
end

function g --wraps git; git $argv; end

function psg; ps aux | grep -i $argv; end
function hs;  history | grep -i $argv; end

function extip;    curl ip.appspot.com; end
function localips; ifconfig | awk '/inet.*broadcast/ { print $2; }'; end

function fs; stat -f '%z bytes'; end

function fa; find . -iname $argv; end
function ff; find . -type f -iname $argv; end
function fd; find . -type d -iname $argv; end

function be; bundle exec $argv; end
function jbe; jruby -S bundle exec $argv; end

set -x EDITOR vim
set -x LANGUAGE en_US.UTF-8
set -x LC_ALL en_US.UTF-8
set -g default_user mats
set -x GPG_TTY (tty)
test -d /usr/local/sbin ; and set -x PATH /usr/local/sbin $PATH
test -d {$HOME}/.local/bin ; and set -x PATH {$HOME}/.local/bin $PATH
test -d {$HOME}/.jenv/bin ; and set -x PATH {$HOME}/.jenv/bin $PATH
test -d {$HOME}/.composer/vendor/bin ; and set -x PATH {$HOME}/.composer/vendor/bin $PATH
test -d /Library/TeX/texbin ; and set -x PATH /Library/TeX/texbin $PATH
test -d {$HOME}/Library/Android/sdk ; and set -x ANDROID_HOME {$HOME}/Library/Android/sdk
test -d {$ANDROID_HOME}/tools ; and set -x PATH {$ANDROID_HOME}/tools $PATH
test -d {$ANDROID_HOME}/platform-tools ; and set -x PATH {$ANDROID_HOME}/platform-tools $PATH

command -s yarn >/dev/null; and set -x PATH $PATH (yarn global bin)

if command -s rbenv >/dev/null
  status --is-interactive; and source (rbenv init -|psub)
end

if test -d ~/.jenv/shims
  jenv global >/dev/null
end
