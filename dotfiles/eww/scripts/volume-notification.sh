#!/usr/bin/env bash

# Show volume notification temporarily
show_volume_notification() {
    # Open the volume notification window
    eww open volume-notification
    
    # Hide it after 3 seconds
    sleep 3
    eww close volume-notification
}

# Show notification in background
show_volume_notification &