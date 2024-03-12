import 'package:flutter/material.dart';
import 'package:password/component/Button.dart';

import '../routes/router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
                '密碼管理服務\nPasswordMangement',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 50),
            CustomButton(
                onPressed: () {
                  print('Account Page Button Pressed');
                  router.go('/login');
                },
                text: 'Account\nMangement',
                color: Colors.blue,
                textColor: Colors.white,
                width: 23, height: 15
            ),
            const SizedBox(height: 20),
            CustomButton(
                onPressed: () {
                  print('PasswordMangement Page Button Pressed');
                  router.go('/password');
                },
                text: 'Password\nMangement',
                color: Colors.orange,
                textColor: Colors.white,
                width: 23, height: 15
            ),
            const SizedBox(height: 20),
            CustomButton(
                onPressed: () {
                  print('RandomPassword Page Button Pressed');
                  router.go('/random');
                },
                text: 'Random\nPassword',
                color: Colors.green,
                textColor: Colors.white,
                width: 30, height: 15
            ),
          ],
        ),
      ),
    );
  }
}