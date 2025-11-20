# 📌 GoLink — Quick URL Launcher (Portable Tool)

A very light and 100% portable tool that instantly opens your favorite link in the default browser with just a double-click.

Designed for those who need extremely fast access to a site they use daily (YouTube, Google, dashboard, local server, etc.).

The tool automatically saves the last URL you entered and opens it directly every time you run it afterward.

🚀 **Features**
*   Fully portable (no installation required)
*   Saves the last URL and opens it automatically
*   Asks for the URL only the first time
*   Automatically adds `http://` or `https://` if you forget
*   Available in two versions: EXE + BAT (you can read the code easily)
*   Size is less than 100 KB
*   Works instantly without any delay

📁 **Project Structure**
```
GoLink/
├── v1.0.0/
│   ├── GoLinkV1.0.0.exe
│   ├── GoLink_batV1.0.0.bat
│   ├── GoLink_ico.ico
│   └── GoLink_png.png
│
├── v2.0.0/
│   ├── GoLinkV2.0.0.exe
│   ├── GoLink_batV2.0.0.bat
│   ├── last_url.txt            ← Automatically created after the first run
│   ├── GoLink_ico.ico
│   └── GoLink_png.png
│
└── LICENSE
```

🧩 **How it Works**
**First Run:**
1.  Checks if `last_url.txt` exists.
2.  If it doesn't exist → displays a window asking you to enter the URL.
3.  Saves the URL and opens it instantly.

**Subsequent Runs:**
1.  Reads the saved URL and opens it directly without any prompt.

🔧 **Requirements**
*   Windows 7 / 8 / 10 / 11 (32-bit or 64-bit)
*   Any installed and set as default internet browser

🛠️ **Source and Compilation**
*   **EXE Version:**
    *   Written entirely in Batch Script (the `.bat` file is included and you can read it).
    *   Converted to EXE using Bat To Exe Converter v4.2 with the icon added.
*   **BAT Version:** The raw Batch Script file.

📜 **License**
*   Completely open source - refer to the `LICENSE` file.

---

You can now edit this file directly in the chat by clicking the ✏️ **Edit** button.
(Tell me anything you want to change or add, and I'll modify it immediately!)