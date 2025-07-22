#!/usr/bin/env bash

# Show brightness notification temporarily
show_brightness_notification() {
    # Open the brightness notification window
    eww open brightness-notification
    
    # Hide it after 3 seconds
    sleep 3
    eww close brightness-notification
}

# Show notification in background
show_brightness_notification &