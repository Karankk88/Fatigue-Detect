import 'package:flutter/material.dart';

class AlertToggle extends StatefulWidget {
  final String title;
  const AlertToggle({required this.title});

  @override
  State<AlertToggle> createState() => _AlertToggleState();
}

class _AlertToggleState extends State<AlertToggle> {
  bool isEnabled = true;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(widget.title),
      value: isEnabled,
      onChanged: (val) => setState(() => isEnabled = val),
    );
  }
}