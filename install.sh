#!/bin/bash

echo "J.A.R.V.I.S. Voice Assistant - Installation Helper for macOS/Linux"
echo "================================================================"
echo

# Check for Python
echo "Checking for Python installation..."
if ! command -v python3 &> /dev/null && ! command -v python &> /dev/null; then
    echo "Python is not found in your PATH."
    echo "Please install Python 3.7+."
    echo "For macOS, you can use Homebrew: brew install python"
    echo "For Linux, use your distribution's package manager (e.g., sudo apt install python3)."
    exit 1
else
    # Prefer python3 if available
    PYTHON_CMD=$(command -v python3 || command -v python)
    echo "Python found using: $PYTHON_CMD"
fi
echo

# Manual Installation Steps Reminder
echo "IMPORTANT MANUAL STEPS:"
echo "-------------------------"
echo "1. Install espeak-ng:"
echo "   - macOS: brew install espeak-ng"
echo "   - Debian/Ubuntu: sudo apt-get update && sudo apt-get install espeak-ng"
echo "   - Other Linux: Use your distribution's package manager."
echo "     (Ensure it's in your PATH if installed manually from source)."
echo
echo "2. Install Ollama and Pull a Model:"
echo "   - Download and install Ollama from: https://ollama.com/"
echo "   - After installation, open your terminal and run:"
echo "     ollama pull llama3.2"
echo "   - (Or any other model you prefer, then update jarvis_voice.py if needed)"
echo "   - Ensure the Ollama application is running before starting JARVIS."
echo
echo "Press Enter to continue with Python environment setup and dependency installation..."
read -r
echo

# Create Virtual Environment
echo "Creating Python virtual environment (./.venv)..."
$PYTHON_CMD -m venv .venv
if [ $? -ne 0 ]; then
    echo "Failed to create virtual environment. Please check your Python installation."
    exit 1
fi
echo "Virtual environment created."
echo

# Activate Virtual Environment and Install Requirements
echo "Activating virtual environment and installing dependencies from requirements.txt..."
source ./.venv/bin/activate
pip install -r requirements.txt
if [ $? -ne 0 ]; then
    echo "Failed to install Python dependencies."
    echo "Please check the error messages above. Common issues include:"
    echo "- PyAudio: May require development headers (e.g., portaudio19-dev on Debian/Ubuntu)."
    echo "  Example: sudo apt-get install portaudio19-dev"
    echo "- Other network issues or package conflicts."
    deactivate
    exit 1
fi
echo "Python dependencies installed successfully."
echo

echo "Deactivating virtual environment for now."
deactivate
echo

echo "================================================================"
echo "INSTALLATION HELPER FINISHED"
echo "================================================================"
echo
echo "TO RUN J.A.R.V.I.S.:"
echo "1. Ensure Ollama is running."
echo "2. Open a new terminal."
echo "3. Navigate to this directory ($(pwd))."
echo "4. Activate the virtual environment: source ./.venv/bin/activate"
echo "5. Run the script: $PYTHON_CMD jarvis_voice.py"
echo
echo "NOTE: The 'keyboard' library (for Ctrl+J hotkey) might require"
echo "      you to run '$PYTHON_CMD jarvis_voice.py' with sudo on Linux if it"
echo "      cannot access /dev/input devices, or grant accessibility permissions"
echo "      on macOS for the terminal application."
echo
echo "You might need to make this script executable first: chmod +x install.sh"
echo