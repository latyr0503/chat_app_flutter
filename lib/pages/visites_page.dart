import 'package:flutter/material.dart';

class VisitesPage extends StatelessWidget {
  const VisitesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visites Page'),
      ),
      body: const Center(
        child: Text('Visites Page Content'),
      ),
    );
  }
}