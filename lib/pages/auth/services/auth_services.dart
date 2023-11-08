import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  // instance of auth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // instqnce of fireStore
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

//utilisateur connecter
  Future<UserCredential> signInWithEmailandPassword(
    String email,
    String password,
  ) async {
    try {
      // connexion
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // ajouter un nouveau document pour l'utilisateur dans la collection des utilisateurs s'il n'existe pas déjà
      _fireStore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
      }, SetOptions(merge: true));
      return userCredential;
    }
    // cath any error
    on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // inscrption d'un nouveau utilisateur
  Future<UserCredential> signUpWithEmailandPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // après la création de l'utilisateur, créer un nouveau document pour l'utilisateur dans la collection des utilisateurs
      _fireStore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);  
    }
  }

  // deconnexion de l'utilisateur
  Future<void> signOut() async {
    return await FirebaseAuth.instance.signOut();
  }
}
