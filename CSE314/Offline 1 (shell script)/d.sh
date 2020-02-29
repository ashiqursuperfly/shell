walk() {
        local indent="${2:-0}"
        printf "%*s%s\n" $indent '' "$1"
        for entry in "$1"/*; do
                [[ -d "$entry" ]] && walk "$entry" $((indent+4))
        done
}
walk "$1"
