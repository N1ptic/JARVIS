@echo off
echo J.A.R.V.I.S. Voice Assistant - Installation Helper for Windows
echo ============================================================
echo.

REM Check for Python
echo Checking for Python installation...
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Python is not found in your PATH.
    echo Please install Python 3.7+ from https://www.python.org/downloads/
    echo Make sure to check "Add Python to PATH" during installation.
    pause
    exit /b 1
) else (
    echo Python found!
)
echo.

REM Manual Installation Steps Reminder
echo IMPORTANT MANUAL STEPS:
echo -------------------------
echo 1. Install espeak-ng:
echo    - Download and install from: https://github.com/espeak-ng/espeak-ng/releases
echo    - CRITICAL: Ensure the espeak-ng installation directory (e.g., C:\Program Files\eSpeak NG)
echo      is added to your system's PATH environment variable.
echo.
echo 2. Install Ollama and Pull a Model:
echo    - Download and install Ollama from: https://ollama.com/
echo    - After installation, open your terminal/PowerShell and run:
echo      ollama pull llama3.2
echo    - (Or any other model you prefer, then update jarvis_voice.py if needed)
echo    - Ensure the Ollama application is running before starting JARVIS.
echo.
echo Press any key to continue with Python environment setup and dependency installation...
pause >nul
echo.

REM Create Virtual Environment
echo Creating Python virtual environment (./.venv)...
python -m venv .venv >nul
if %errorlevel% neq 0 (
    echo Failed to create virtual environment. Please check your Python installation.
    pause
    exit /b 1
)
echo Virtual environment created.
echo.

REM Activate Virtual Environment and Install Requirements
echo Activating virtual environment and installing dependencies from requirements.txt...
call .\.venv\Scripts\activate.bat
pip install -r requirements.txt
if %errorlevel% neq 0 (
    echo Failed to install Python dependencies.
    echo Please check the error messages above. Common issues include:
    echo - PyAudio: May require precompiled wheels or Microsoft C++ Build Tools.
    echo   See PyAudio documentation for Windows installation.
    echo - Other network issues or package conflicts.
    call .\.venv\Scripts\deactivate.bat
    pause
    exit /b 1
)
echo Python dependencies installed successfully.
echo.

echo Deactivating virtual environment for now.
call .\.venv\Scripts\deactivate.bat
echo.

echo ============================================================
echo INSTALLATION HELPER FINISHED
echo ============================================================
echo.
echo TO RUN J.A.R.V.I.S.:
echo 1. Ensure Ollama is running.
echo 2. Open a new terminal/Command Prompt.
echo 3. Navigate to this directory (%~dp0).
echo 4. Activate the virtual environment: .\.venv\Scripts\activate
echo 5. Run the script: python jarvis_voice.py
echo.
echo NOTE: The 'keyboard' library (for Ctrl+J hotkey) might require
echo       you to run 'python jarvis_voice.py' from a terminal
echo       that was "Run as administrator".
echo.
pause