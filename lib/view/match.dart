import 'package:flutter/material.dart';

class MatchScreen extends StatelessWidget {
  const MatchScreen({
    super.key,
    required this.title,
    required this.description,
    required this.opponent,
    required this.wasWon,
  });

  final String title;
  final String description;
  final String opponent;
  final bool wasWon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: [
          Text(title),
          Text(description),
          Text(opponent),
          Text(wasWon ? 'Won' : 'Lost'),
        ],
      ),
    );
  }
}
