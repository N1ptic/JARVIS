# JARVIS Voice Assistant 🗣️🤖✨

![JARVIS Logo](jarvis.png)

**Your Advanced AI Voice Companion with a Sci-Fi GUI, Powered by Local LLMs**

JARVIS Voice Assistant is a Python-based interactive voice application that listens to your commands, processes them using a local Large Language Model (LLM) via Ollama, and responds with synthesized speech. It features a graphical user interface (GUI) with voice waveform visualization, continuous listening mode, global hotkeys, and custom command capabilities.

---

## 🌟 Features

*   **Interactive GUI**: Built with `customtkinter` for a modern, "sci-fi" themed interface.
*   **Voice Waveform Visualization**: Displays a waveform of your spoken input after each utterance.
*   **Continuous Conversation Mode**: JARVIS actively listens for follow-up commands after responding, until explicitly stopped.
*   **Global Hotkey Control**: Toggle listening mode on/off using **Ctrl+J**.
*   **Voice-to-Text (STT)**: Utilizes `SpeechRecognition` to capture your voice commands.
*   **Intelligent Response Generation**: Leverages Ollama and a local LLM (e.g., `llama3.2`) to understand and generate human-like responses.
*   **Text-to-Speech (TTS)**: Uses the `kokoro` library for clear and natural-sounding voice output.
*   **Custom Voice Commands**:
    *   **"Jarvis open chrome"**: Launches the Google Chrome browser.
    *   **"Jarvis type [your text]"**: Types the specified text into the currently active window.
*   **Customizable LLM**: Easily configurable to use different models available through Ollama.
*   **Platform-Aware Audio Playback**: Uses `winsound` on Windows and `playsound` on other OS for reliable audio output.
*   **Robust Error Handling**: Includes checks for common issues and provides feedback.
*   **Timestamped Audio Files**: Saves each audio response with a unique filename (though these are temporary and deleted after playback).

---

## 🚀 Installation

Follow these steps to get JARVIS up and running on your system:

**Automated Helper Scripts:**

We provide helper scripts to automate parts of the installation (Python environment setup and dependency installation).
*   **Windows**: Run `install.bat` by double-clicking it or running it from the command prompt.
*   **macOS/Linux**: Make the script executable (`chmod +x install.sh`) and then run it (`./install.sh`).

These scripts will guide you through the Python-specific setup and remind you of the manual steps required for `espeak-ng` and `Ollama`.

**Manual Installation Steps (if not using or in addition to helper scripts):**

1.  **Python Installation**:
    *   Ensure you have Python 3.7+ installed. You can download it from [python.org](https://www.python.org/downloads/).

2.  **Clone the Repository (or download the files)**:
    *   Ensure you have `jarvis_voice.py`, `requirements.txt`, `install.bat` (for Windows), and `install.sh` (for macOS/Linux) in your project directory.

3.  **Install espeak-ng (Kokoro TTS Dependency)**:
    *   `kokoro` relies on `espeak-ng`. Install it based on your OS:
        *   **Windows**: Download and install from the [espeak-ng GitHub releases](https://github.com/espeak-ng/espeak-ng/releases). **Ensure the installation directory is added to your system's PATH.** Alternatively, try `choco install espeak-ng`.
        *   **Debian/Ubuntu**: `sudo apt-get install espeak-ng`
        *   **macOS**: `brew install espeak-ng`

4.  **Install Ollama & Pull LLM Model**:
    *   Download and install Ollama from [ollama.com](https://ollama.com/).
    *   Pull your desired LLM model. The script is configured for `llama3.2` by default:
        ```bash
        ollama pull llama3.2
        ```
    *   **Ensure the Ollama application is running before starting JARVIS.**

5.  **Create a Virtual Environment (Recommended)**:
    ```bash
    python -m venv .venv
    ```
    Activate it:
    *   Windows: `.venv\Scripts\activate`
    *   macOS/Linux: `source .venv/bin/activate`

6.  **Install Python Dependencies**:
    *   With your virtual environment activated, install the required packages using the `requirements.txt` file:
        ```bash
        pip install -r requirements.txt
        ```
    *   **Dependency List**: The `requirements.txt` file includes:
        *   `kokoro`
        *   `soundfile`
        *   `torch`
        *   `SpeechRecognition`
        *   `PyAudio`
        *   `numpy`
        *   `playsound==1.2.2`
        *   `ollama`
        *   `customtkinter`
        *   `keyboard`
    *   **PyAudio Notes**: If `pip install PyAudio` (or installing via `requirements.txt`) fails:
        *   **Windows**: You might need to install from a precompiled wheel or use `pipwin install pyaudio`.
        *   **Linux**: You might need `portaudio19-dev` (e.g., `sudo apt-get install portaudio19-dev`).
    *   **Keyboard Library Notes**: The `keyboard` library (for global hotkeys) may require administrator/root privileges to function correctly, especially on Windows and macOS. If the Ctrl+J hotkey doesn't work, try running the script with elevated privileges.

---

## 🎧 Usage

1.  **Ensure Ollama is Running**: Start your Ollama application and make sure the `llama3.2` (or your configured) model is available.
2.  **Activate Virtual Environment** (if you created one):
    *   Windows: `.\.venv\Scripts\activate`
    *   macOS/Linux: `source .venv/bin/activate`
3.  **Run the Script**:
    ```bash
    python JARVIS/jarvis_voice.py
    ```
    *   If the Ctrl+J hotkey doesn't work, you might need to run with administrator/root privileges. For example, on Windows, open Command Prompt or PowerShell as Administrator, navigate to the project directory, activate the venv, and then run the script.

4.  **Interacting with JARVIS GUI**:
    *   The application will launch a graphical user interface.
    *   **Status Bar**: Shows the current status of JARVIS (e.g., "Initializing...", "Listening...", "Kokoro TTS Initialized. Ready.").
    *   **Conversation Log**: Displays a transcript of your interactions with JARVIS, including system messages.
    *   **Waveform Display**: After you speak, a visual representation of your voice waveform will appear in this area.
    *   **Start/Stop Listening Button**:
        *   Click "🎙️ Start Listening" to activate continuous conversation mode. JARVIS will listen, respond, and then immediately listen for your next command.
        *   The button will change to "🛑 Stop Listening". Click it to deactivate continuous listening.
    *   **Ctrl+J Hotkey**: Press `Ctrl+J` at any time (while the application window is active or in the background) to toggle the listening mode, same as clicking the button.
    *   **Exit Button**: Click "🚪 Exit" to close the application.

5.  **Voice Commands**:
    *   **General Conversation**: Speak naturally when JARVIS is listening. It will use the LLM to respond.
    *   **"Jarvis open chrome"** or **"open chrome browser"**: Opens Google Chrome.
    *   **"Jarvis type [your desired text]"** or **"type this [your desired text]"**: JARVIS will type the text that follows the command phrase into the currently active window. There's a short delay to allow you to switch focus.
    *   **"Exit"**, **"Quit"**, **"Goodbye Jarvis"**, **"Jarvis shutdown"**: These phrases will shut down the JARVIS application.

---

## ⚙️ How It Works (Simplified)

1.  **GUI & Control**: `customtkinter` manages the user interface. The `keyboard` library handles global hotkeys.
2.  **Speech-to-Text (STT)**: [`listen_for_command()`](JARVIS/jarvis_voice.py) uses `speech_recognition` to capture audio and transcribe it. It also returns raw audio data for waveform visualization.
3.  **Command Processing**:
    *   The main listening loop checks for custom commands ("open chrome", "type this").
    *   If no custom command is matched, the transcribed text goes to [`get_jarvis_response()`](JARVIS/jarvis_voice.py).
4.  **LLM Interaction**: [`get_jarvis_response()`](JARVIS/jarvis_voice.py) sends the text to Ollama for processing by the local LLM.
5.  **Text-to-Speech (TTS)**: The LLM's response is synthesized into audio by [`generate_speech()`](JARVIS/jarvis_voice.py) using `kokoro`.
6.  **Audio Playback**: The generated audio is played using `winsound` (Windows) or `playsound` (other OS).
7.  **Waveform Visualization**: Raw audio data is processed and drawn onto a `tkinter.Canvas` in the GUI.

---

## 🛠️ Troubleshooting

*   **Kokoro / espeak-ng Issues**:
    *   Ensure `espeak-ng` is correctly installed AND its installation directory is in your system's PATH.
    *   Verify Kokoro's language and voice settings if modified.
*   **Ollama Errors**:
    *   Confirm Ollama application is running and the specified model (e.g., `llama3.2`) is pulled (`ollama pull llama3.2`).
*   **PyAudio Installation**: See notes in the installation section for OS-specific dependencies.
*   **Ctrl+J Hotkey Not Working**:
    *   The `keyboard` library often needs administrator/root privileges. Try running `jarvis_voice.py` with elevated permissions.
    *   Check the console for error messages related to hotkey registration.
*   **"No speech detected"**: Check microphone settings, speak clearly, or adjust `timeout` values in [`listen_for_command()`](JARVIS/jarvis_voice.py).
*   **Audio File Deletion Errors (`WinError 32`)**: The script now uses `winsound` on Windows and includes `winsound.PlaySound(None, winsound.SND_PURGE)` which should significantly mitigate this. If it persists, it might be an OS-level file locking issue.

---

## 🔮 Future Enhancements (Ideas from previous README)

*   **Wake Word Detection**: Implement a wake word (e.g., "Hey JARVIS").
*   **Offline STT**: Explore local/offline Speech-to-Text engines.
*   **More Sophisticated Conversation Management**: Context memory for multi-turn conversations.
*   **Plugin System**: For actions like checking weather, controlling smart home devices.
*   **Alternative TTS Engines**: Support for other TTS engines.
*   **Configuration File**: For settings like LLM model name, voice, etc.
*   **Live Waveform**: A waveform that animates *while* speaking (more complex).
*   **Sci-Fi Sound Effects**: For UI interactions.

---

Enjoy your advanced conversations with JARVIS!