import 'package:flutter/material.dart';

void main() {
  runApp(const Preloved());
}

class Preloved extends StatelessWidget {
  const Preloved({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Preloved'),
        ),
      ),
    );
  }
}
