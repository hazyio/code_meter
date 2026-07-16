import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _goToSettingsPage() {
    Navigator.pushNamed(context, '/settings');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,

      //   title: Text(widget.title),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            const Text('Home Page'),

            FilledButton(
              onPressed: _goToSettingsPage,
              child: const Text('Go to Settings'),
            ),
          ],
        ),
      ),
    );
  }
}
