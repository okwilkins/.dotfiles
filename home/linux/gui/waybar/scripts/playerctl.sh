#!/usr/bin/env bash

FORMAT=$(printf '{{status}}\t{{playerName}}\t{{markup_escape(title)}}\t{{markup_escape(artist)}}')

playerctl metadata --format "$FORMAT" -F | \
while IFS=$'\t' read -r status player title artist; do
    [[ -z "$status" ]] && continue

    if [[ -z "$artist" ]]; then
        tooltip="$player: $title"
    else
        tooltip="$player: $artist - $title"
    fi

    jq -n --unbuffered \
        --arg text "$title" \
        --arg tooltip "$tooltip" \
        --arg alt "$status" \
        --arg class "$status" \
        '{text: $text, tooltip: $tooltip, alt: $alt, class: $class}'
done

