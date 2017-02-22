set -x GPG_TTY (tty)

function __refresh_gpg_agent_info -d "Re-load ~/.gnupg/.gpg-agent-info into environment"
    cat ~/.gnupg/.gpg-agent-info | sed 's/=/ /' | while read key value
        set -e $key
        set -U -x $key "$value"
    end
end

if not set -q -x GPG_AGENT_INFO
    gpg-agent --daemon >/dev/null
end

if test -f ~/.gnupg/.gpg-agent-info
    __refresh_gpg_agent_info

    gpg-connect-agent /bye ^/dev/null
    if test $status -eq 1
        pkill -U $USER gpg-agent
        gpg-agent --daemon >/dev/null
        __refresh_gpg_agent_info
    end
end
