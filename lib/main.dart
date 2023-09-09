import 'package:flutter/material.dart';

void main() {
  runApp(const WologApp());
}

class WologApp extends StatelessWidget {
  const WologApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'wolog',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true,
      ),
      home: const ExcercisePerformanceOverviewPage(),
    );
  }
}

class ExcercisePerformanceOverviewPage extends StatelessWidget {
  const ExcercisePerformanceOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("wolog"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const Center(child: Text("wolog")),
    );
  }
}