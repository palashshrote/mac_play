import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final String? msg;
  const ErrorScreen({super.key, required this.msg});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(msg == "" ? "E R R O R !" : msg!),
      ),
      body: Text("E R R O R !"),
    );
  }
}
