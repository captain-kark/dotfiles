#!/bin/bash

__term="${1?Usage: TERM}"
__logs="/tmp/kubgrep-${__term}.log"

trap sortlogs INT

sortlogs () {
    echo "Sorting all logs streamed to $__logs"
    sort "$__logs" -o "$__logs"
    $EDITOR --no-wait "$__logs"
}

__query=("worker|api")
__include=("-i" "$__term")
__exclude=("-e" "- DEBUG -|aiohttp.access")
__since=("-s" "2h")
__template=("--template" "{{.Namespace}}{{.Message}}")

args=()
for arg in "${@:2}"; do
    case "$arg" in
        -q|--query)
            __query=()
            continue
        ;;
        -i|--include)
            __include=()
        ;;
        -e|--exclude)
            __exclude=()
        ;;
        -s|--since)
            __since=()
        ;;
        --template)
            __template=()
        ;;
    esac
    __args+=("$arg")
done

function __ts_sort() {
    sed -E 's/^(.+)?([0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}:[0-9]{2}\.[0-9]{5})([0-9]+)?Z/\2Z \1/' <&0
}

stern "${__args[@]}" "${__query[@]}" "${__include[@]}" "${__exclude[@]}" "${__since[@]}" "${__template[@]}" -t -o raw | tee >(__ts_sort > "$__logs") | __ts_sort
