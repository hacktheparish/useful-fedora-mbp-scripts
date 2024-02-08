#!/bin/bash

# Create the directory if it doesn't exist
mkdir -p ~/.mbp-scripts

# Define the path to turnscreen.sh
turnscreen_script="$HOME/.mbp-scripts/turnscreen.sh"

# Check if the file already exists
if [ -f "$turnscreen_script" ]; then
    echo "File already exists: $turnscreen_script"
    exit 1
fi

# Create the turnscreen.sh file
cat > "$turnscreen_script" << EOF
#!/bin/bash

# Check for the argument
if [ "\$#" -ne 1 ]; then
    echo "Usage: \$0 [on|off]"
    exit 1
fi

# Define the path to brightness file
brightness_file="/sys/class/backlight/intel_backlight/brightness"
max_brightness_file="/sys/class/backlight/intel_backlight/max_brightness"
max_brightness=\$(cat "\$max_brightness_file")

# Turn screen on or off based on the argument
case "\$1" in
    on)
        echo "\$max_brightness" > "\$brightness_file"
        ;;
    off)
        echo "0" > "\$brightness_file"
        ;;
    *)
        echo "Invalid argument. Usage: \$0 [on|off]"
        exit 1
        ;;
esac
EOF

# Make turnscreen.sh executable
chmod +x "$turnscreen_script"

echo "Script created: $turnscreen_script"

