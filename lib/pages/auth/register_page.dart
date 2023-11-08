import 'package:chat_app/pages/auth/services/auth_services.dart';
import 'package:chat_app/widgets/my_button.dart';
import 'package:chat_app/widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text_controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  // int money = 20;
  //sign up user
  void signUp() async {
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Verifier les mots de pass entre ne correspond pas"),
        ),
      );
      return;
    }
    // get auth service
    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      await authService.signUpWithEmailandPassword(
        emailController.text,
        passwordController.text,
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
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
                const Icon(Icons.message, size: 80, color: Colors.blue),
                const SizedBox(height: 60),
                //create account message
                const Text(
                  "Bienvenue Creer un compte pour vous !",
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
                const SizedBox(height: 15),
                //password textfield
                MyTextFiel(
                    controller: passwordController,
                    hintText: 'Mot de passe...',
                    obscureText: true),
                // espacement
                const SizedBox(height: 15),
                //confirme password textfield
                MyTextFiel(
                    controller: confirmPasswordController,
                    hintText: 'Confirmer votre Mot de passe...',
                    obscureText: true),
                // espacement
                const SizedBox(height: 60),
                //sign in button
                MyButton(
                  text: "S'inscrire",
                  onTap: signUp,
                ),
                //not a member? register now
                const SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Vous etes deja un membre ?"),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        "Se connecter",
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
