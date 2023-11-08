import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/pages/auth/services/auth_gate.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const DoctorApp());
}

class DoctorApp extends StatelessWidget {
  const DoctorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: "Poppins"),
        initialRoute: '/',
        routes: {
          '/': (context) => const AuthGate(),
          // '/visits': (context) => const VisitesPage(),
          // '/message': (context) => const MessagePage(),
          // '/profile': (context) => const ProfilePage(),
        },
      ),
    );
  }
}
