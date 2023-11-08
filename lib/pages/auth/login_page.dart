import 'package:chat_app/pages/auth/services/auth_services.dart';
import 'package:chat_app/widgets/my_button.dart';
import 'package:chat_app/widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text_controllers
  final emailController = TextEditingController();
  final passcordController = TextEditingController();

  // sign In
  Future<void> signIn() async {
    // get the auth services
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signInWithEmailandPassword(
        emailController.text,
        passcordController.text,
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //logo
                const Icon(Icons.message_outlined, size: 80, color: Colors.blue),
                const SizedBox(height: 60),
                //welcome back message
                const Text(
                  "Bienvenue tu nous a manque !",
                  style: TextStyle(fontSize: 18),
                ),
                // espacement
                const SizedBox(height: 30),
                //email textfield
                MyTextFiel(
                    controller: emailController,
                    hintText: 'Email...',
                    obscureText: false),
                // espacement
                const SizedBox(height: 30),
                //password textfield
                MyTextFiel(
                    controller: passcordController,
                    hintText: 'Mot de passe...',
                    obscureText: true),
                // espacement
                const SizedBox(height: 60),
                //sign in button
                MyButton(
                  text: 'Se Connecter',
                  onTap: signIn,
                ),
                //not a member? register now
                const SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Vous n'etes pas un membre ?"),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        "Creer un compte",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
