import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_firebase_authentication/src/app.dart';
import 'firebase_options.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

void main() async {
  // https://api.flutter.dev/flutter/widgets/WidgetsFlutterBinding/ensureInitialized.html
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  if (kIsWeb) {
    // initialiaze the facebook javascript SDK
    await FacebookAuth.instance.webInitialize(
      appId: "833106107736731",
      cookie: true,
      xfbml: true,
      version: "v13.0",
    );
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: App(),
    );
  }
}
