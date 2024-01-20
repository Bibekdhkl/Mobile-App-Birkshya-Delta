import 'package:flutter/material.dart';
import 'dart:async';

class ChatPage extends StatefulWidget {
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> _qaPairs = [
    {"question": "What is your name?", "answer": "My name is Arjun"},
    {"question": "What is your age?", "answer": "32"},
  ];

  List<Map<String, dynamic>> _messages = [];

  bool _isTyping = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Chat with BrikshyaAI',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return ListTile(
                  title: Align(
                    alignment: message['isAI']
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: message['isAI'] ? Colors.blue : Colors.green,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        message['text'],
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          _isTyping
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "BrikshyaAI is typing...",
                      )),
                )
              : Container(),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          _buildMessageComposer(),
        ],
      ),
    );
  }

  Widget _buildMessageComposer() {
    return Container(
      color: Theme.of(context).cardColor,
      child: IconTheme(
        data: IconThemeData(color: Colors.accents.first),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: <Widget>[
              Flexible(
                child: TextField(
                  controller: _controller,
                  onSubmitted: _handleSubmit,
                  decoration: InputDecoration.collapsed(
                    hintText: "Type a message...",
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: () => _handleSubmit(_controller.text),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleSubmit(String text) {
    _controller.clear();

    // User's message
    _addMessage(text, false);

    // Simulate AI typing
    _simulateTyping();

    // Simulate AI response after 2 seconds
    Future.delayed(Duration(seconds: 2), () {
      _handleAIResponse(text);
      _stopTyping();
    });
  }

  void _simulateTyping() {
    setState(() {
      _isTyping = true;
    });
  }

  void _stopTyping() {
    setState(() {
      _isTyping = false;
    });
  }

  void _handleAIResponse(String question) {
    for (var qaPair in _qaPairs) {
      if (qaPair['question'] == question) {
        // AI's response
        _addMessage(qaPair['answer'], true);
        return;
      }
    }
    // Default response if no match is found
    _addMessage("I'm not sure how to answer that.", true);
  }

  void _addMessage(String text, bool isAI) {
    setState(() {
      _messages.insert(
        0,
        {"text": text, "isAI": isAI},
      );
    });
  }
}
