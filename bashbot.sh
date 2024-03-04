#!/bin/bash

# Initialize colors
GREEN=$(tput setaf 2)  # Green color for AI msgs
PURPLE=$(tput setaf 5) # Purple for the title text
NORMAL=$(tput sgr0)    # Reset color

# Define the endpoint URL
endpoint_url='https://worker-quiet-term-d7d6.davis-vilcans.workers.dev'

# Function to send message
send_message() {
    message="$1"
    # Prepare the payload
    payload="{\"message\": \"$message\"}"
    # Make the request
    response=$(curl -s -X POST -H "Content-Type: application/json" -d "$payload" "$endpoint_url")
    # Check if request was successful
    if [ $? -eq 0 ]; then
        # Extract AI response
        ai_response=$(echo "$response" | jq -r '.[0].response.response')
        # Display AI response without header if -m option is used
        if [ -n "$ai_response" ]; then
            if [ "$2" != "-m" ]; then
                echo ""
                echo -e "${GREEN}AI: $ai_response\n"
            else
                echo "$ai_response"
            fi
        else
            echo "Error: Empty response from server"
        fi
    else
        echo "Error: Failed to send message"
    fi
}

# Function to display help page
display_help() {
    echo "Usage: bashbot [options]"
    echo "Options:"
    echo "  --help            Display this help message"
    echo "  -v, --version     Display the version of Bashbot"
    echo "  -m, --message     MESSAGE   Send a message to Bashbot"
    echo ""
    echo "Description:"
    echo "  Bashbot is a script that allows you to interact with an AI-powered chatbot."
    echo ""
    echo "Interactive Mode:"
    echo "  To launch Bashbot in interactive mode, simply run 'bashbot' without any options."
    echo "  In interactive mode, you can type messages directly into the terminal and receive responses from the chatbot."
    echo ""
    echo "Examples:"
    echo "  bashbot                          # Launches Bashbot in interactive mode"
    echo "  bashbot -m \"Hello, Bashbot!\"     # Sends a message to Bashbot"
    echo "  bashbot --help                   # Displays this help message"
    echo "  bashbot -v                       # Displays the version of Bashbot"
}

# Check for command-line arguments
if [[ $# -gt 0 ]]; then
    while [[ $# -gt 0 ]]; do
        key="$1"
        case $key in
            --help)
                display_help
                exit 0
                ;;
            -v|--version)
                echo "v.0.9-WIP"
                exit 0
                ;;
            -m|--message)
                send_message "$2" "-m"
                exit 0
                ;;
            *)
                echo "Unknown option: $key"
                exit 1
                ;;
        esac
        shift
    done
fi

# Function to display header
display_header() {
    clear
    echo ""
    echo -e "${PURPLE}██████╗  █████╗ ███████╗██╗  ██╗██████╗  ██████╗ ████████╗
██╔══██╗██╔══██╗██╔════╝██║  ██║██╔══██╗██╔═══██╗╚══██╔══╝
██████╔╝███████║███████╗███████║██████╔╝██║   ██║   ██║   
██╔══██╗██╔══██║╚════██║██╔══██║██╔══██╗██║   ██║   ██║   
██████╔╝██║  ██║███████║██║  ██║██████╔╝╚██████╔╝   ██║   
╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═════╝  ╚═════╝    ╚═╝   
                                                        "
    echo -e "${NORMAL}Welcome to Bashbot! \n\nType \"clear\" to clear the screen, \"q\" or \"exit\" to quit."
}

# Display header for interactive mode
display_header

# Main loop
while true; do
    # Move cursor to bottom
    tput cup $(tput lines) 0

    # Read user input
    read -p "${NORMAL}> " input_text
    
    # Check if the user wants to clear the screen
    if [ "$input_text" = "clear" ]; then
        display_header
        continue
    fi    
    
    # Check if the user wants to exit
    if [ "$input_text" = "exit" ] || [ "$input_text" = "q" ]; then
        clear
        exit 0
    fi

    # Send message
    send_message "$input_text"
done
