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
    // 修改 '/account' 路徑的路由定義，並在 'builder' 中傳遞 'ID' 參數
    GoRoute(
      path: '/account',
      builder: (context, state) => AccountPage(),
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
