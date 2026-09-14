mkdir -p "$HOME/Library/Services"

create_service() {
  local name="$1"
  local command="$2"
  local dir="$HOME/Library/Services/$name.workflow/Contents"

  mkdir -p "$dir"

  /usr/libexec/PlistBuddy -c "Clear dict" "$dir/document.wflow" 2>/dev/null || true

  cat > "$dir/document.wflow" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
  "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>AMApplicationBuild</key>
  <string>Automator</string>

  <key>AMDocumentVersion</key>
  <string>2</string>

  <key>actions</key>
  <array>
    <dict>
      <key>action</key>
      <dict>
        <key>AMAccepts</key>
        <dict>
          <key>Container</key>
          <string>List</string>
          <key>Optional</key>
          <true/>
          <key>Types</key>
          <array>
            <string>com.apple.cocoa.string</string>
          </array>
        </dict>

        <key>AMProvides</key>
        <dict>
          <key>Container</key>
          <string>List</string>
          <key>Types</key>
          <array>
            <string>com.apple.cocoa.string</string>
          </array>
        </dict>

        <key>ActionBundlePath</key>
        <string>/System/Library/Automator/Run Shell Script.action</string>

        <key>ActionName</key>
        <string>Run Shell Script</string>

        <key>ActionParameters</key>
        <dict>
          <key>COMMAND_STRING</key>
          <string><![CDATA[
$command
]]></string>

          <key>CheckedForUserDefaultShell</key>
          <true/>

          <key>inputMethod</key>
          <integer>1</integer>

          <key>shell</key>
          <string>/bin/bash</string>

          <key>source</key>
          <string></string>
        </dict>

        <key>BundleIdentifier</key>
        <string>com.apple.RunShellScript</string>

        <key>CFBundleVersion</key>
        <string>2.0.3</string>

        <key>CanShowSelectedItemsWhenRun</key>
        <false/>

        <key>CanShowWhenRun</key>
        <true/>

        <key>Category</key>
        <array>
          <string>AMCategoryUtilities</string>
        </array>

        <key>Class Name</key>
        <string>RunShellScriptAction</string>

        <key>InputUUID</key>
        <string>INPUT</string>

        <key>OutputUUID</key>
        <string>OUTPUT</string>

        <key>UUID</key>
        <string>ACTION</string>
      </dict>

      <key>isViewVisible</key>
      <false/>
    </dict>
  </array>

  <key>connectors</key>
  <dict/>

  <key>variables</key>
  <array/>

  <key>workflowMetaData</key>
  <dict>
    <key>serviceApplicationBundleID</key>
    <string>com.apple.finder</string>

    <key>serviceApplicationPath</key>
    <string>/System/Library/CoreServices/Finder.app</string>

    <key>serviceInputTypeIdentifier</key>
    <string>com.apple.Automator.fileSystemObject.image</string>

    <key>serviceOutputTypeIdentifier</key>
    <string>com.apple.Automator.nothing</string>

    <key>serviceProcessesInput</key>
    <integer>0</integer>

    <key>workflowTypeIdentifier</key>
    <string>com.apple.Automator.servicesMenu</string>
  </dict>
</dict>
</plist>
EOF

  plutil -lint "$dir/document.wflow"
}

create_service "Image - Quality 80%" '
MAGICK="/opt/homebrew/bin/magick"

for file in "$@"; do
  [ -f "$file" ] || continue

  ext="${file##*.}"
  ext="$(printf "%s" "$ext" | tr "[:upper:]" "[:lower:]")"

  if [ "$ext" = "webp" ]; then
    "$MAGICK" "$file" "${file%.*}.png"
  else
    tmp="${file%.*}.imagemagick-tmp.${file##*.}"
    "$MAGICK" "$file" -quality 80 "$tmp" &&
      mv -f "$tmp" "$file"
  fi
done
'

create_service "Image - Max 1200 Quality 80%" '
MAGICK="/opt/homebrew/bin/magick"

for file in "$@"; do
  [ -f "$file" ] || continue

  ext="${file##*.}"
  ext="$(printf "%s" "$ext" | tr "[:upper:]" "[:lower:]")"

  if [ "$ext" = "webp" ]; then
    "$MAGICK" "$file" \
      -resize "1200x1200>" \
      "${file%.*}.png"
  else
    tmp="${file%.*}.imagemagick-tmp.${file##*.}"
    "$MAGICK" "$file" \
      -resize "1200x1200>" \
      -quality 80 \
      "$tmp" &&
      mv -f "$tmp" "$file"
  fi
done
'

killall Finder 2>/dev/null || true

open "$HOME/Library/Services"