import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CommonDrawer {
  static Drawer getDrawer(BuildContext context) {
    final router = GoRouter.of(context);

    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title: const Text('Home'),
            onTap: () {
              router.go('/');
            },
          ),
          ListTile(
            title: const Text('Login'),
            onTap: () {
              router.go('/login');
            },
          ),
          ListTile(
            title: const Text('SignUp'),
            onTap: () {
              router.go('/signUp');
            },
          ),
          ListTile(
            title: const Text('Account'),
            onTap: () {
              router.go('/account');
            },
          ),
          ListTile(
            title: const Text('Password'),
            onTap: () {
              router.go('/password');
            },
          ),
          ListTile(
            title: const Text('Random'),
            onTap: () {
              router.go('/random');
            },
          ),
        ],
      ),
    );
  }
}