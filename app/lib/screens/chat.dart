import 'package:flutter/material.dart';
import 'package:iism_2025/viewmodel/user.dart';

class AskSimhiScreen extends StatefulWidget {
  final UserViewModel _userViewModel;
  const AskSimhiScreen({super.key, required UserViewModel user})
    : _userViewModel = user;

  @override
  State<AskSimhiScreen> createState() => _AskSimhiScreenState();
}

class _AskSimhiScreenState extends State<AskSimhiScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> messages = [];

  bool get hasMessages => messages.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: hasMessages
                ? _ChatSection(messages: messages)
                : _WelcomeSection(user: widget._userViewModel),
          ),
        ),
        _InputArea(controller: _controller, onSend: sendMessage),
      ],
    );
  }

  void sendMessage() {
    if (_controller.text.trim().isEmpty) return;

    final now = TimeOfDay.now().format(context);

    setState(() {
      messages.add({
        "text": _controller.text.trim(),
        "isUser": true,
        "time": now,
      });
    });

    _controller.clear();

    Future.delayed(const Duration(milliseconds: 400), () {
      final botTime = TimeOfDay.now().format(context);
      setState(() {
        messages.add({
          "text": "This is a sample response.",
          "isUser": false,
          "time": botTime,
        });
      });
    });
  }
}

// ---------------------- CHAT SECTION ----------------------

class _ChatSection extends StatelessWidget {
  final List<Map<String, dynamic>> messages;

  const _ChatSection({required this.messages});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      key: const ValueKey("chat"),
      padding: const EdgeInsets.all(16),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final msg = messages[index];

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Column(
            crossAxisAlignment: msg["isUser"]
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              // 💬 CHAT BUBBLE
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: msg["isUser"]
                      ? const Color(0xFFEDE8D3)
                      : const Color(0xFFFFD3A3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(msg["text"], style: const TextStyle(fontSize: 15)),
              ),

              const SizedBox(height: 4),

              // 🕒 TIMESTAMP BELOW THE BUBBLE
              Text(
                msg["time"] ?? "",
                style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ---------------------- INPUT AREA ----------------------

class _InputArea extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  const _InputArea({required this.controller, required this.onSend});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade400),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText: "Type...",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: onSend,
            child: Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Color(0xFFFF8C2A),
              ),
              child: const Icon(Icons.arrow_forward, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------- WELCOME SECTION ----------------------

class _WelcomeSection extends StatelessWidget {
  final UserViewModel _userViewModel;
  const _WelcomeSection({required UserViewModel user}) : _userViewModel = user;

  @override
  Widget build(BuildContext context) {
    final userName = _userViewModel.me!.firstName;
    return Column(
      key: const ValueKey("welcome"),
      children: [
        const SizedBox(height: 30),

        CircleAvatar(
          radius: 55,
          backgroundImage: AssetImage("assets/simhi.png"),
        ),

        const SizedBox(height: 18),
        Text(
          "Hi $userName,\nHow can I help you?",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            color: Color(0xFF4A4A9D),
            fontWeight: FontWeight.w500,
          ),
        ),

        const Spacer(),
      ],
    );
  }
}
