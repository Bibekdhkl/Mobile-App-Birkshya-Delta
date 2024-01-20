import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';

import 'package:project_app/view/chatbot/chat_page.dart';

class SummaryDetail extends StatelessWidget {
  final String date;
  final String title;
  final String summary;

  SummaryDetail(
      {required this.date, required this.title, required this.summary});

  @override
  Widget build(BuildContext context) {
    // Split the summary into paragraphs
    List<String> sentences = summary.split('. ');

// Generate a random index
    int randomIndex = Random().nextInt(sentences.length);

    return Scaffold(
      appBar: AppBar(
        title: Text('Summary Detail'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.chat),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$title',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Created at: ${DateFormat('dd MMMM, yyyy').format(DateTime.parse(date))}',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Column(
              children: [
                Text(
                  summary,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16.0),
              ],
            ),
            Text(
              'Points to remember:',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            Text(
              '${sentences[randomIndex]}',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
