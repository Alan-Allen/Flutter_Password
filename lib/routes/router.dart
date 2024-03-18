import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:password/page/AccountPage.dart';
import 'package:password/page/PasswordPage.dart';
import 'package:password/page/RandomPage.dart';

import '../page/HomePage.dart';
import '../page/LoginPage.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      name: 'account',
      path: '/account/:id',
      builder: (context, state) {
        final id = state.pathParameters['id'];
        if (id != null) {
          return AccountPage(id: id);
        } else {
          return const Scaffold(
            body: Center(
              child: Text('ID not found'),
            ),
          );
        }
      },
    ),
    GoRoute(
      path: '/password',
      builder: (context, state) => PasswordPage(),
    ),
    GoRoute(
      path: '/random',
      builder: (context, state) => const RandomPage(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginPage(),
    ),
    GoRoute(
      path: '/signUp',
      builder: (context, state) => const HomePage(),
    ),
  ],
);