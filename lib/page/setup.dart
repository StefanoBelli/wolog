import 'package:flutter/material.dart';

class SetupPage extends StatefulWidget {
  const SetupPage({super.key});

  @override
  State<StatefulWidget> createState() => _SetupPageState();
}

enum _SetupPagePhase {
  noDbFound,
}

class _SetupPageState extends State<StatefulWidget> {
  final _SetupPagePhase _currentPhase = _SetupPagePhase.noDbFound;

  Widget _buildNoDbFound(BuildContext context) =>
    const Scaffold();

  @override
  Widget build(BuildContext context) {
    return _buildNoDbFound(context);
  }

}