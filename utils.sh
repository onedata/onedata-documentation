#!/bin/bash

# Authors: Jakub Liput
# Copyright (C) 2025 Onedata (onedata.org)
# This software is released under the MIT license cited in 'LICENSE.txt'

# Source this file for utility functions in onedata-documentation scripts:
# - strip_version - transforms full version string to major version, e.g.
#   21.02.2 -> 21.02, 25.1.2 -> 25
# - get_release - prints full release version string from RELEASE file
# - get_major_release - prints only major component of version, e.g. "21.02" or "25".

strip_to_major_version() {
    local version="$1"
    local first_number
    first_number=$(echo "$version" | grep -oE '^[0-9]+')

    if [[ -n "$first_number" ]]; then
        if (( first_number > 21 )); then
            echo "$first_number"
        else
            echo "$version" | sed -E 's/^([0-9]+\.[0-9]+).*/\1/'
        fi
    else
        echo "$version"
    fi
}

get_release() {
    # xargs trims whitespaces
    echo `cat ./RELEASE | xargs`
}

get_major_release() {
    strip_to_major_version $(get_release)
}