<div align="center">

# 💬 Harmony Hub

### 🚀 Real-Time Flutter Chat Applications using WebSockets

A simple real-time chat system built with **Flutter** and **Python WebSockets** to demonstrate bidirectional communication between two independent Flutter applications.

![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?style=for-the-badge&logo=dart)
![Python](https://img.shields.io/badge/Python-3.x-3776AB?style=for-the-badge&logo=python)
![WebSocket](https://img.shields.io/badge/WebSocket-Real--Time-success?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-blue?style=for-the-badge)

</div>

---

# ✨ Overview

Harmony Hub is a lightweight real-time chat demonstration consisting of **two independent Flutter applications** connected through a **Python WebSocket server**.

The project was created as a skill verification assignment to showcase:

- Flutter Development
- WebSocket Communication
- JSON Messaging
- Real-Time Synchronization
- Client-Server Architecture

---

# 📂 Project Structure

```text
Harmony_Hub
│
├── flutter-chat-app-1/
│   └── Blue themed chat application
│
├── flutter-chat-app-2/
│   └── Green themed chat application
│
├── python-websocket-server/
│   ├── server.py
│   └── requirements.txt
│
└── README.md
```

---

# 🚀 Features

✅ Two independent Flutter applications

✅ Real-time messaging

✅ Python WebSocket Server

✅ Broadcast messaging

✅ Live connection status

✅ Username based chat

✅ JSON communication

✅ Cross-platform Flutter support

---

# 🛠 Tech Stack

| Technology | Usage |
|------------|-------|
| Flutter | UI Development |
| Dart | Frontend Logic |
| Python | Backend Server |
| WebSockets | Real-time Communication |
| JSON | Data Exchange |

---

# ⚙️ Installation

## 1️⃣ Clone Repository

```bash
git clone https://github.com/kartikshukla2301-eng/Harmony_Hub.git

cd Harmony_Hub
```

---

## 2️⃣ Run Python Server

```bash
cd python-websocket-server

pip install -r requirements.txt

python server.py
```

Server starts on

```text
ws://127.0.0.1:8765
```

---

## 3️⃣ Run App 1

```bash
cd flutter-chat-app-1

flutter pub get

flutter run
```

---

## 4️⃣ Run App 2

```bash
cd flutter-chat-app-2

flutter pub get

flutter run
```

---

# 📡 Architecture

```
        WebSocket

      Flutter App 1
            │
            │
            ▼
     Python WebSocket Server
            ▲
            │
            │
      Flutter App 2
```

The server receives incoming messages from one client and instantly broadcasts them to all connected clients.

---

# 💡 How it Works

1. User enters a username.
2. Flutter connects to the Python WebSocket server.
3. Messages are encoded as JSON.
4. The server broadcasts incoming messages.
5. Every connected Flutter application receives updates instantly.

---

# 📸 Demo

Example Conversation

```
KARTIK
Hello Buddy!

↓

ADMIN
Hi Kartik! How may I help you?
```

---

# 📈 Future Improvements

- Authentication
- Private Messaging
- Message History
- Online Users
- File Sharing
- Typing Indicator
- Read Receipts
- Dark Theme

---

# 👨‍💻 Author

### Kartik Shukla

B.Tech Computer Science Engineering (2027)

Full Stack Developer • Flutter Enthusiast • Python Developer

📧 Email

```text
kartikshukla2301@gmail.com
```

🌐 Portfolio

https://kartik-portfolio-chi-eight.vercel.app

💼 LinkedIn

https://www.linkedin.com/in/kartik-shukla-cse

🐙 GitHub

https://github.com/kartikshukla2301-eng

---

<div align="center">

### ⭐ If you found this project useful, consider giving it a Star.

Made with ❤️ by Kartik Shukla

</div>
