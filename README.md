# JARVIS Voice Assistant 🗣️🤖

**Your Personal AI Voice Companion Powered by Local LLMs**

JARVIS Voice Assistant is a Python-based interactive voice application that listens to your commands, processes them using a local Large Language Model (LLM) via Ollama, and responds with synthesized speech. It's designed to be a more conversational and intelligent alternative to simple command-echoing scripts.

---

## ✨ Features

*   **Voice-to-Text (STT)**: Utilizes `SpeechRecognition` to capture your voice commands.
*   **Intelligent Response Generation**: Leverages Ollama and a local LLM (e.g., `llama3.2`) to understand and generate human-like responses.
*   **Text-to-Speech (TTS)**: Uses the `kokoro` library for clear and natural-sounding voice output.
*   **Conversational Flow**: Designed for more natural back-and-forth interaction.
*   **Customizable LLM**: Easily configurable to use different models available through Ollama.
*   **Automatic Audio Playback**: Responses are played automatically using `playsound`.
*   **Robust Error Handling**: Includes checks for common issues like empty LLM responses and audio file conflicts.
*   **Timestamped Audio Files**: Saves each audio response with a unique filename to prevent overwriting issues.

---

## 🚀 Installation

Follow these steps to get JARVIS up and running on your system:

1.  **Python Installation**:
    *   Ensure you have Python 3.7+ installed. You can download it from [python.org](https://www.python.org/downloads/).

2.  **Clone the Repository (or download the script)**:
    ```bash
    # If this were a git repo:
    # git clone <repository_url>
    # cd jarvis-voice-assistant
    ```
    For now, ensure you have `jarvis_voice.py` and the newly created `requirements.txt` in a project directory.

3.  **Install espeak-ng (Kokoro TTS Dependency)**:
    *   `kokoro` relies on `espeak-ng`. Install it based on your OS:
        *   **Windows**: Download and install from the [espeak-ng GitHub releases](https://github.com/espeak-ng/espeak-ng/releases). Ensure the installation directory is added to your system's PATH. Alternatively, try `choco install espeak-ng`.
        *   **Debian/Ubuntu**: `sudo apt-get install espeak-ng`
        *   **macOS**: `brew install espeak-ng`

4.  **Install Ollama & Pull LLM Model**:
    *   Download and install Ollama from [ollama.com](https://ollama.com/).
    *   Pull your desired LLM model. The script is configured for `llama3.2` by default:
        ```bash
        ollama pull llama3.2
        ```
    *   Ensure the Ollama application is running before starting JARVIS.

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
    *   **PyAudio Notes**: If `pip install PyAudio` (or installing via `requirements.txt`) fails:
        *   **Windows**: You might need to install from a precompiled wheel or use `pipwin install pyaudio`.
        *   **Linux**: You might need `portaudio19-dev` (e.g., `sudo apt-get install portaudio19-dev`).

---

## 🎧 Usage

1.  **Ensure Ollama is Running**: Start your Ollama application and make sure the `llama3.2` (or your configured) model is available.
2.  **Activate Virtual Environment** (if you created one):
    *   Windows: `.\.venv\Scripts\activate`
    *   macOS/Linux: `source .venv/bin/activate`
3.  **Run the Script**:
    ```bash
    python jarvis_voice.py
    ```
4.  **Interact with JARVIS**:
    *   The script will calibrate the microphone for ambient noise.
    *   When you see "JARVIS is listening...", speak your command or question.
    *   JARVIS will process your speech, send it to the LLM, get a response, synthesize it into audio, and play it back.
    *   Say "exit" or "quit" to end the session.

---

## ⚙️ How It Works

JARVIS operates in a three-stage pipeline:

1.  **Speech-to-Text (STT)**:
    *   The [`listen_for_command()`](jarvis_voice.py) function uses the `speech_recognition` library with your microphone.
    *   It captures your audio, then uses Google Speech Recognition (online) to transcribe it into text.

2.  **LLM Processing**:
    *   The transcribed text is passed to the [`get_jarvis_response()`](jarvis_voice.py) function.
    *   This function communicates with your local Ollama instance using the `ollama` Python client.
    *   It sends the user's text along with a system prompt (instructing the LLM to act as JARVIS) to the specified model (e.g., `llama3.2`).
    *   The LLM generates a text-based response.

3.  **Text-to-Speech (TTS)**:
    *   The LLM's text response is then passed to the [`generate_speech()`](jarvis_voice.py) function.
    *   This function uses the `kokoro` library (which relies on `espeak-ng`) to synthesize the text into an audio waveform.
    *   The audio is saved as a uniquely named `.wav` file (e.g., `jarvis_response_YYYYMMDD_HHMMSSffffff.wav`).
    *   Finally, `playsound` is used to play the generated audio file.

---

## 🛠️ Troubleshooting

*   **`playsound` installation error (`OSError: could not get source code`)**:
    *   This was addressed by pinning `playsound==1.2.2` in `requirements.txt`. Ensure you install this specific version.

*   **Error opening `jarvis_response.wav`: System error**:
    *   This was addressed by generating unique, timestamped filenames for each audio output. This prevents conflicts if the previous audio file is still locked.

*   **No audio generated by Kokoro / Kokoro initialization failure**:
    *   Ensure `espeak-ng` is correctly installed and accessible in your system's PATH.
    *   Check if the text being sent to Kokoro is not empty or just whitespace (the script now has checks for this).
    *   Verify Kokoro's language and voice settings if you've modified them.

*   **Ollama errors ("model not found", "connection refused", etc.)**:
    *   Make sure the Ollama application is running.
    *   Verify that you have pulled the correct model (e.g., `ollama pull llama3.2`).
    *   Check your network connection if Ollama is running on a different machine (though typically it's local).

*   **PyAudio installation issues**:
    *   Refer to the installation notes for OS-specific dependencies like `portaudio19-dev` on Linux or using precompiled wheels on Windows.

*   **"JARVIS: No speech detected within the time limit."**:
    *   Speak more clearly or closer to the microphone.
    *   Check your microphone settings in your OS.
    *   The `timeout` and `phrase_time_limit` in [`listen_for_command()`](jarvis_voice.py) can be adjusted if needed.

---

## 🔮 Future Enhancements

*   **Wake Word Detection**: Implement a wake word (e.g., "Hey JARVIS") to activate listening instead of continuous listening prompts.
*   **Offline STT**: Explore options for local/offline Speech-to-Text engines to remove the Google Speech Recognition dependency.
*   **More Sophisticated Conversation Management**: Implement context memory for multi-turn conversations.
*   **Plugin System**: Allow integration with other APIs or local scripts to perform actions (e.g., check weather, control smart home devices).
*   **GUI**: Develop a simple graphical user interface.
*   **Alternative TTS Engines**: Add support for other TTS engines, potentially local ones.
*   **Configuration File**: Move settings like LLM model name, voice, etc., to a configuration file.

---

Enjoy your conversations with JARVIS!