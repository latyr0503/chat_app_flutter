import 'package:chat_app/pages/auth/services/chat/chat_service.dart';
import 'package:chat_app/widgets/chat_bubble.dart';
import 'package:chat_app/widgets/my_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class MessageriePage extends StatefulWidget {
  final String receiverUserEmail;
  final String receiverUserID;
  const MessageriePage(
      {super.key,
      required this.receiverUserEmail,
      required this.receiverUserID});

  @override
  State<MessageriePage> createState() => _MessageriePageState();
}

class _MessageriePageState extends State<MessageriePage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    // n'envoyer un message que s'il y a quelque chose à envoyer
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receiverUserID, _messageController.text);
      //effacer le contrôleur après avoir envoyé le message
      _messageController.clear();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiverUserEmail),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // message
            Expanded(
              child: _buildMessageList(),
            ),
            // entrée utilisateur
            _buildMessageInput(),
          ],
        ),
      ),
    );
  }

  //créer une liste de messages
  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _chatService.getMessages(
          widget.receiverUserID, _firebaseAuth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Erreur${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Message en chargement');
        }
        return ListView(
          children: snapshot.data!.docs
              .map((document) => _buildMessageItem(document))
              .toList(),
        );
      },
    );
  }

  //créer un élément de message
  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    //aligner le message à droite si l'expéditeur est l'utilisateur actuel, sinon à gauche
    var alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment:
              (data['senderId'] == _firebaseAuth.currentUser!.uid)
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
          mainAxisAlignment:
              (data['senderId'] == _firebaseAuth.currentUser!.uid)
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
          children: [
            Text(data['senderEmail']),
            const SizedBox(height: 5,),
            ChatBubble(message: data['message']),
          ],
        ),
      ),
    );
  }

  // créer une entrée de message
  Widget _buildMessageInput() {
    return Row(
      children: [
        // textField
        Expanded(
          child: MyTextFiel(
            controller: _messageController,
            hintText: "Entrer votre message",
            obscureText: false,
          ),
        ),

        // boutton d'envoi
        IconButton(
          onPressed: sendMessage,
          icon: const Icon(
            Icons.arrow_upward,
            size: 30,
          ),
        ),
      ],
    );
  }
}
