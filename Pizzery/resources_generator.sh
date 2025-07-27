# generate Strings class from Localizable.xcstrings
# need instal jq ( brew install jq )

STRINGS_DIR="./Resources/Localizable.xcstrings"
OUTPUT_SWIFT="./Resources/Strings.swift"

SWIFT_RESERVED_WORDS=(
    associatedtype class deinit enum extension fileprivate func import init
    inout internal let open operator private protocol public rethrows return
    static struct subscript typealias var where while true false nil if else
    switch case default break fallthrough for continue do try catch throw
    repeat guard async await any some final nonisolated convenience required
)

is_reserved_word() {
    local word="$1"
    for reserved in "${SWIFT_RESERVED_WORDS[@]}"; do
        if [[ "$word" == "$reserved" ]]; then return 0; fi
    done
    return 1
}

to_camel_case() {
    local key="$1"
    if [[ "$key" =~ ^[a-zA-Z][a-zA-Z0-9]*$ && "$key" =~ [A-Z] ]]; then
        result="$key"
    else
        local clean=$(echo "$key" | sed 's/[^a-zA-Z0-9]/ /g')
        local result=""
        local i=0
        for part in $clean; do
            if [[ $i -eq 0 ]]; then
                result+=$(echo "$part" | awk '{print tolower($0)}')
            else
                result+=$(echo "$part" | awk '{print toupper(substr($0,1,1)) tolower(substr($0,2))}')
            fi
            ((i++))
        done
    fi
    if [[ -z "$result" || "$result" =~ ^[0-9] ]]; then
        if command -v md5sum &> /dev/null; then
            result="key$(echo -n "$key" | md5sum | cut -c1-8)"
        else
            result="key$(echo -n "$key" | md5 | cut -c1-8)"
        fi
    fi
    if is_reserved_word "$result"; then result="${result}_"; fi
    echo "$result"
}

[ -f "$STRINGS_DIR" ] || { echo "❌ $STRINGS_DIR not found."; exit 1; }

TMPFILE=$(mktemp)

cat <<EOF > "$TMPFILE"
// This file is generated automatically using the
// Resources Generator bash script.
// Do not try to change it manually.

import Foundation

enum Strings {
EOF

jq -r '.strings | keys[]' "$STRINGS_DIR" | while read -r key; do
    echo "" >> "$TMPFILE"
    var_name=$(to_camel_case "$key")
    doc=$(jq -r --arg k "$key" \
        '.strings[$k].localizations.ru.stringUnit.value // empty' \
        "$STRINGS_DIR" | tr '\n' ' ')
    [[ -n "$doc" ]] && echo "    /// $doc" >> "$TMPFILE"

    # получаем исходное значение, чтобы посчитать %@
    value=$(jq -r --arg k "$key" \
        '.strings[$k].localizations.ru.stringUnit.value' \
        "$STRINGS_DIR")

    # считаем, сколько %@
    count=$(grep -o '%@' <<< "$value" | wc -l | tr -d ' ')

if ((count == 0)); then
    echo "    static var $var_name: String { localizedStr(\"$key\") }" >> "$TMPFILE"
else
    params=()
    interp=""
    for i in $(seq 1 $count); do
        params+=("arg$i: String")
        interp+=", arg$i"
    done
    IFS=", " read -r param_list <<< "${params[*]}"
    interp_str="${interp}"
    
cat <<EOF >> "$TMPFILE"
    static func $var_name($param_list) -> String {
        let localizedStr = NSLocalizedString("$key", comment: "$key")
        return String(format: localizedStr$interp_str)
    }
EOF
fi
done

cat <<EOF >> "$TMPFILE"

    private static func localizedStr(_ key: String) -> String {
        return NSLocalizedString(key, comment: key)
    }
}
EOF

mkdir -p "$(dirname "$OUTPUT_SWIFT")"
mv "$TMPFILE" "$OUTPUT_SWIFT"
echo "✅ $OUTPUT_SWIFT"
