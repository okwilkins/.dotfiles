#!/usr/bin/env bash

playerctl metadata --format '{{status}} {{title}}' --follow | while read -r status title; do
    if [[ "$status" == "Stopped" ]] || [[ -z "$status" ]]; then
        echo "" 
    else
        title="${title//\"/\\\"}"
        echo "{\"text\": \"$title\", \"alt\": \"$status\", \"class\": \"$status\"}"
    fi
done

