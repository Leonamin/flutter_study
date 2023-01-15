import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tutorial_go_router/all_new_all_different_page.dart';
import 'package:tutorial_go_router/error_page.dart';
import 'package:tutorial_go_router/home_page.dart';
import 'package:tutorial_go_router/house_of_m_page.dart';
import 'package:tutorial_go_router/login_notifier.dart';
import 'package:tutorial_go_router/login_page.dart';
import 'package:tutorial_go_router/settings_page.dart';

class GoRouterApp extends StatelessWidget {
  GoRouterApp({Key? key}) : super(key: key);

  final LoginNotifier _loginNotifier = LoginNotifier();

  @override
  Widget build(BuildContext context) {
    print("앱에서 보면 ${_loginNotifier.loggedIn}");
    return ChangeNotifierProvider<LoginNotifier>.value(
      value: _loginNotifier,
      child: MaterialApp.router(
        title: 'GOGO ROUTER',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routerConfig: _router,
      ),
    );
  }

  late final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        name: 'home',
        path: '/',
        builder: (context, state) => const HomePage(),
        // 라우트 레벨 리디렉션은 해당 라우트 아래의 routes에 있는 GoRoute로
        // 이동이 가능하다.
        // 수평으로 선언된 GoRoute는 참조가 안되는 거 같다.
        // Route-Level Redirection
        redirect: (context, state) {
          debugPrint("Home Route-Level Redirection");
          final bool loggedIn = _loginNotifier.loggedIn;
          final bool loggingIn = state.subloc == '/login';
          if (!loggedIn) {
            print('헤헤헤');
            return '/login';
          }
          if (loggingIn) {
            return '/';
          }
          return '/';
        },
        routes: [
          // 라우트 레벨일 경우
          GoRoute(
            name: 'login',
            path: 'login',
            builder: (context, state) => LoginPage(),
          ),
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
      // 탑레벨일 경우
      // GoRoute(
      //   name: 'login',
      //   path: '/login',
      //   builder: (context, state) => LoginPage(),
      // ),
    ],
    // Top-Level Redirection
    // redirect: (context, state) {
    //   debugPrint("Top-Level Redirection");
    // final bool loggedIn = _loginNotifier.loggedIn;
    // final bool loggingIn = state.subloc == '/login';
    // if (!loggedIn) {
    //   return '/login';
    // }
    // if (loggingIn) {
    //   return '/';
    // }
    // return null;
    // return '/';
    // },
    errorBuilder: (context, state) => const ErrorPage(),
    refreshListenable: _loginNotifier,
  );
}
