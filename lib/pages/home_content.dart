import 'package:flutter/material.dart';

void main() {
  runApp(const HomeContent());
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Home Content'),
        ),
      ),
    );
  }
}
