import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  final String data;

  const ErrorMessage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Text("Hiba történt: $data");
  }
}