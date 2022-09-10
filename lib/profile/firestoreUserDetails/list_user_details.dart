import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_email_pass_auth/pages/profile.dart';
import 'package:flutter_firebase_email_pass_auth/profile/firestoreUserDetails/profile_final.dart';

class ListUserDetails extends StatefulWidget {
   ListUserDetails({Key? key}) : super(key: key);

  @override
  State<ListUserDetails> createState() => _ListUserDetailsState();
}

class _ListUserDetailsState extends State<ListUserDetails> {

  final Stream<QuerySnapshot> usersStream = FirebaseFirestore
      .instance.collection('users').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: usersStream,
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(snapshot.hasError){
            print("Something went Wrong");
          }
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // getting data to list
          final List firestoreDataList = [];
          snapshot.data.docs.map((DocumentSnapshot document){
            Map aMap = document.data() as Map<String, dynamic>;
            firestoreDataList.add(aMap);
          }).toList();

          return const MaterialApp(
            home: FirestoreProfile(),
          );
        }
        );
  }
}
