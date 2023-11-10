import 'package:chat_app/pages/auth/services/auth_services.dart';
import 'package:chat_app/pages/message_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // instance d'authentification
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // Déconnexion de l'utilisateur
  void signOut() {
    // obtient le service d'authentification
    final authService = Provider.of<AuthService>(
      context,
      listen: false,
    );
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Page d'accueil"),
        actions: [
          // boutton de deconnexion
          IconButton(
            onPressed: signOut,
            icon: const Icon(Icons.logout_outlined),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text(
              'Liste de discussion',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            // message
            Expanded(
              child: _buildUserList(),
            ),
          ],
        ),
      ),
    );
  }

 // construit la liste des utilisateurs à l'exception de l'utilisateur actuellement connecté
  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Erreur');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Page en chargement...');
        }
        return ListView(
          children: snapshot.data!.docs
              .map<Widget>((doc) => _buildUserListItem(doc))
              .toList(),
        );
      },
    );
  }

  // crée des éléments de liste d'utilisateurs individuels
  Widget _buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
    // affiche tous les utilisateurs sauf l'utilisateur actuel
    if (_auth.currentUser!.email != data['email']) {
      return ListTile(
        title: Text(data['email']),
        onTap: () {
          // transmet l'UID de l'utilisateur cliqué à la page de discussion
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MessageriePage(
                receiverUserEmail: data['email'],
                receiverUserID: data['uid'],
              ),
            ),
          );
        },
      );
    } else {
      // renvoie le conteneur vide
      return Container();
    }
  }
}
