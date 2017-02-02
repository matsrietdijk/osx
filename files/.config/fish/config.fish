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

function -;       cd -; end
function ...;     cd ../..; end
function ....;    cd ../../..; end
function .....;   cd ../../../..; end
function ......;  cd ../../../../..; end
function .......; cd ../../../../../..; end
function .2;      cd ../..; end
function .3;      cd ../../..; end
function .4;      cd ../../../..; end
function .5;      cd ../../../../..; end
function .6;      cd ../../../../../..; end

if type hub > /dev/null
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
test -d /usr/local/sbin ; and set -x PATH /usr/local/sbin $PATH
test -d {$HOME}/.local/bin ; and set -x PATH {$HOME}/.local/bin $PATH
test -d {$HOME}/.jenv/bin ; and set -x PATH {$HOME}/.jenv/bin $PATH
test -d {$HOME}/.composer/vendor/bin ; and set -x PATH {$HOME}/.composer/vendor/bin $PATH
test -d /usr/local/opt/android-sdk ; and set -x ANDROID_HOME /usr/local/opt/android-sdk
test -d /Library/TeX/texbin ; and set -x PATH /Library/TeX/texbin $PATH

command -s yarn >/dev/null; and set -x PATH $PATH (yarn global bin)

# test -d (brew --prefix homebrew/php/php56)/bin ; and set -x PATH (brew --prefix homebrew/php/php56)/bin $PATH
# test -d (brew --prefix homebrew/php/php70)/bin ; and set -x PATH (brew --prefix homebrew/php/php70)/bin $PATH
# 
# if type rbenv > /dev/null
#   rbenv init - | source
# end

if test -d ~/.jenv/shims
  jenv global > /dev/null
end
