import 'package:flutter/material.dart';

class PrivatePage extends StatelessWidget {
  const PrivatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Private Page')),
      body: const Center(
        child: Text(
          'Welcome to the Private Page!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}