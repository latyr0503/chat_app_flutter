import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/pages/auth/services/auth_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:chat_app/pages/auth/services/auth_gate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthService(),
      child: const ChatApp(),
    ),
  );
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthGate(),
    );
  }
}
