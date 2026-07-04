import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

// Change this value depending on your environment:
// - Local machine:  ws://127.0.0.1:8765
// - Android emulator: ws://10.0.2.2:8765
// - Deployed server: ws://<your-server-ip-or-domain>:8765
const String serverUrl = 'ws://localhost:8765';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App 1',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const UsernameScreen(),
    );
  }
}

class UsernameScreen extends StatefulWidget {
  const UsernameScreen({super.key});
  @override
  State<UsernameScreen> createState() => _UsernameScreenState();
}

class _UsernameScreenState extends State<UsernameScreen> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat App 1 – Enter Name')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final name = _controller.text.trim();
                if (name.isEmpty) return;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChatScreen(username: name),
                  ),
                );
              },
              child: const Text('Join Chat'),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  final String username;
  const ChatScreen({super.key, required this.username});
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late WebSocketChannel _channel;
  final _msgController = TextEditingController();
  final List<Map<String, String>> _messages = [];
  bool _connected = false;

  @override
  void initState() {
    super.initState();
    _connect();
  }

  void _connect() {
    try {
      _channel = WebSocketChannel.connect(Uri.parse(serverUrl));
      _channel.ready.then((_) {
        setState(() => _connected = true);
      }).catchError((e) {
        debugPrint('WebSocket ready error: $e');
        setState(() => _connected = false);
      });
      _channel.stream.listen(
        (data) {
          final msg = jsonDecode(data as String);
          setState(() {
            _messages.add({
              'sender': msg['sender'] as String,
              'text': msg['text'] as String,
            });
          });
        },
        onDone: () => setState(() => _connected = false),
        onError: (e) {
          debugPrint('WebSocket stream error: $e');
          setState(() => _connected = false);
        },
      );
    } catch (e) {
      debugPrint('WebSocket connect error: $e');
      setState(() => _connected = false);
    }
  }

  void _send() {
    final text = _msgController.text.trim();
    if (text.isEmpty || !_connected) return;
    final payload = jsonEncode({'sender': widget.username, 'text': text});
    _channel.sink.add(payload);
    _msgController.clear();
  }

  @override
  void dispose() {
    _channel.sink.close();
    _msgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat – ${widget.username}'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Center(
              child: Text(
                _connected ? '🟢 Connected' : '🔴 Disconnected',
                style: const TextStyle(fontSize: 13),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _messages.length,
              itemBuilder: (_, i) {
                final m = _messages[i];
                final isMe = m['sender'] == widget.username;
                return Align(
                  alignment:
                      isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isMe ? Colors.blue[100] : Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          m['sender']!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        Text(m['text']!),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _msgController,
                    decoration: const InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _send(),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _send,
                  child: const Text('Send'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
