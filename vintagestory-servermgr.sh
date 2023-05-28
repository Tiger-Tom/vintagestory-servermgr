#!/bin/bash

# Header
## Variables
#: "${VARIABLE:=DEFAULT_VALUE}"
: "${SERVICE_NAME:=vintagestory-server.service}"
: "${SOCKET_PATH:=/run/vintagestory-server.stdin}"

# Commands
usage() {
    echo "Usage: $0 COMMAND [OPTION]..."
    echo
    echo " send TEXT...     Sends text to the server's STDIN"
    echo " sendloop         Streams STDIN to the server's STDIN until EOF"
    echo " follow           Follows/tails the server's systemd journal (log)"
    echo " stream           Creates a stream session, where STDIN is sent to the server, and the service journal is followed (basically a combination of follow and sendloop)"
}
send() {
    echo "$*" > "$SOCKET_PATH"
}
sendloop() {
    while (true); do
        read || break
        send $REPLY
    done
}
follow() {
    journalctl -fu "$SERVICE_NAME"
}
stream() {
    follow & sendloop
}

# Parse commands
case $1 in
    send) send ${*:2} ;;
    sendloop) sendloop ;;
    follow) follow ;;
    stream) stream ;;
    *) usage ;;
esac