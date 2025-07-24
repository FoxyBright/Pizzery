# generate R class from iOS app resources (Assets & Localizable)
# need instal jq ( brew install jq )

INPUT_JSON="./Resources/Localizable.xcstrings"
ASSETS_DIR="./Resources/Assets.xcassets"
OUTPUT_SWIFT="./Resources/R.swift"

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

collect_drawables() {
    local assets_dir="$1"
    find "$assets_dir" -type d -name "*.imageset" | while read -r path; do
        basename "$path" .imageset
    done | sort -u
}

[ -f "$INPUT_JSON" ] || { echo "❌ $INPUT_JSON not found."; exit 1; }
[ -d "$ASSETS_DIR" ] || { echo "❌ $ASSETS_DIR not found."; exit 1; }

TMPFILE=$(mktemp)

echo "import Foundation" > "$TMPFILE"
echo "" >> "$TMPFILE"
echo "enum R {" >> "$TMPFILE"

echo "    enum strings {" >> "$TMPFILE"
jq -r '.strings | keys[]' "$INPUT_JSON" | while read -r key; do
    var_name=$(to_camel_case "$key")
    doc=$(jq -r --arg k "$key" '.strings[$k].localizations.ru.stringUnit.value // empty' "$INPUT_JSON" | tr '\n' ' ')
    [[ -n "$doc" ]] && echo "        /// $doc" >> "$TMPFILE"
    echo "        static var $var_name: String { localizedStr(\"$key\") }" >> "$TMPFILE"
done
echo "    }" >> "$TMPFILE"
echo "" >> "$TMPFILE"

echo "    enum drawable {" >> "$TMPFILE"
collect_drawables "$ASSETS_DIR" | while read -r image_name; do
    var_name=$(to_camel_case "$image_name")
    echo "        static var $var_name: String { \"$image_name\" }" >> "$TMPFILE"
done
echo "    }" >> "$TMPFILE"
echo "" >> "$TMPFILE"

cat <<EOF >> "$TMPFILE"
    private static func localizedStr(_ key: String) -> String {
        return NSLocalizedString(key, comment: key)
    }
}
EOF

mkdir -p "$(dirname "$OUTPUT_SWIFT")"
mv "$TMPFILE" "$OUTPUT_SWIFT"
echo "✅ $OUTPUT_SWIFT"
