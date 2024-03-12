import 'package:flutter/material.dart';

import '../routes/router.dart';

class PasswordPage extends StatefulWidget {
  PasswordPage({super.key});

  _PasswordPageState createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            print('Back to Home');
            router.go('/');
          },
        ),
      ),
    );
  }
}