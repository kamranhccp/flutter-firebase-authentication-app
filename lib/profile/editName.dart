import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserFirstName extends StatelessWidget {
  final String documentID;

  const UserFirstName({Key? key, required this.documentID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser?.uid;
    CollectionReference users = FirebaseFirestore.instance.collection("users");

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentID).get(),
      builder: ((context, snapshot){
        if(snapshot.connectionState == ConnectionState.done){
          Map<String, dynamic> data = snapshot.data!.data() as Map<String , dynamic>;
          // if(data[documentID] == user){
            return Text("First Name: ${data['firstName']}");
          // }
        }
        return const Text("Loading...");
      }),
    );
  }
}


