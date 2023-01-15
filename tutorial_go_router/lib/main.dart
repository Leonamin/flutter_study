import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tutorial_go_router/all_new_all_different_page.dart';
import 'package:tutorial_go_router/error_page.dart';
import 'package:tutorial_go_router/go_router_app.dart';
import 'package:tutorial_go_router/home_page.dart';
import 'package:tutorial_go_router/house_of_m_page.dart';
import 'package:tutorial_go_router/settings_page.dart';

void main() {
  runApp(GoRouterApp());
}

// 기본적인 go router routes
// final GoRouter _router = GoRouter(routes: [
//   GoRoute(
//     path: '/',
//     builder: (context, state) => const HomePage(),
//   ),
//   GoRoute(
//     path: '/settings',
//     builder: (context, state) => const SettingsPage(),
//   ),
// ]);

// 서브 라우트 사용법
// 위젯 인스펙터로 살펴볼시 일반 라우트는 go 할 때마다 기존 스택이 사라져서 계속 1개의 스택만 남지만
// 서브 라우트는 서브 라우트 계층 마다 스택이 1개씩 남는다. 물론 복잡한 라우팅 구성이 아니라서 제대로 확인한건 아니다.
// 즉 home -> settings -> anad -> settings -> anad -> hod로 가도 최종 스택에는 home -> anad -> hod만 남게된다.
final GoRouter _subRouter = GoRouter(
  routes: [
    GoRoute(
      name: 'home',
      path: '/',
      builder: (context, state) => const HomePage(),
      routes: [
        GoRoute(
          name: 'settings',
          path: 'settings/:name',
          builder: (context, state) {
            // 쿼리 파람 얻기!
            state.queryParams.forEach(
              (key, value) {
                print("$key:$value");
              },
            );
            return SettingsPage(
              name: state.params['name']!,
            );
          },
        ),
        GoRoute(
          path: 'all_new_all_different',
          builder: (context, state) => AllNewAllDifferentPage(),
          routes: [
            GoRoute(
              path: 'house_of_m',
              builder: (context, state) => HouseOfMPage(),
            ),
          ],
        ),
      ],
    ),
  ],
  errorBuilder: (context, state) => const ErrorPage(),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'GOGO ROUTER',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: _subRouter,
    );
  }
}
