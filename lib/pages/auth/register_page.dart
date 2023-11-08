import 'package:chat_app/widgets/my_button.dart';
import 'package:chat_app/widgets/my_text_field.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text_controllers
  final emailController = TextEditingController();
  final passcordController = TextEditingController();
  final confirmPasscordController = TextEditingController();
  // int money = 20;
  //sign up user
  void signUp() {}
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
                    controller: passcordController,
                    hintText: 'Mot de passe...',
                    obscureText: true),
                // espacement
                const SizedBox(height: 15),
                //confirme password textfield
                MyTextFiel(
                    controller: confirmPasscordController,
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
