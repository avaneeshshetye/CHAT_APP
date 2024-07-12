import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/screens/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_app/screens/chat.dart';
import 'package:my_app/screens/splash.dart';
import 'firebase_options.dart';

void main() async {
  // Ensure that plugin services are initialized before calling runApp.
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
// await Firebase.initializeApp(
//       options: const FirebaseOptions(
//           apiKey: "AIzaSyDtW8jvzykVBd4q2FVtWI2qYyUR73qUKT8",
//           appId: "1:51190346557:web:80eb8e64ef6941a4690b54",
//           messagingSenderId: "51190346557",
//           projectId: "flutter-chat-app-8abb8"));
  // Run the app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 63, 17, 177),
        ),
      ),
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SplashScreen();
              }
              return const ChatScreen();
            }
            return const AuthScreen();
          }),
    );
  }
}
