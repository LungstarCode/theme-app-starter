import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScreenOne extends StatelessWidget {
  const ScreenOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Test App")),
      body: Center(
        child: ElevatedButton.icon(
          icon: Icon(Icons.settings),
          label: Text("Settings"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber,
            foregroundColor: Colors.black45,
          ),
          onPressed: () {
            context.go("/settings");
          },
        ),
      ),
    );
  }
}
