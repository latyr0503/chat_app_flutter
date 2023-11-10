import 'package:chat_app/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatService extends ChangeNotifier {
  // obtenir une instance d'authentification et de Firestore
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  // send message
  Future<void> sendMessage(String receiverId, String message) async {
    // obtenir des informations sur l'utilisateur actuel
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    // créer un nouveau message
    Message newMessage = Message(
        senderEmail: currentUserEmail,
        senderId: currentUserId,
        receiverId: receiverId,
        timestamp: timestamp,
        message: message);

    // construire l'identifiant de la salle de discussion à partir de l'identifiant de l'utilisateur actuel et de l'identifiant du destinataire (triés pour garantir l'unicité)
    List<String> ids = [currentUserId, receiverId];
    ids.sort(); // trier les identifiants (cela garantit que l'identifiant de la salle de discussion est toujours le même pour n'importe quelle paire de personnes)
    String chatRoomId = ids.join(
        "_"); //combinez les identifiants en une seule chaîne à utiliser comme identifiant de salle de discussion
    // ajouter un nouveau message à la base de données
    await _fireStore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('message')
        .add(newMessage.toMap());
  }

  // GET MESSAGE
  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    // construire l'identifiant de la salle de discussion à partir des identifiants des utilisateurs
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");

    return _fireStore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('message')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
