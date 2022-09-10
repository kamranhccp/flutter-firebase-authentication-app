import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_email_pass_auth/pages/login.dart';
import '../constants/global_constants.dart';
import 'package:intl/intl.dart';

class FlutterHome extends StatefulWidget {
  const FlutterHome({Key? key}) : super(key: key);

  @override
  State<FlutterHome> createState() => _FlutterHomeState();
}

class _FlutterHomeState extends State<FlutterHome> {

  // creation date format
  // Users Details
  final userID = FirebaseAuth.instance.currentUser!.uid;
  final userEmail = FirebaseAuth.instance.currentUser!.email;
  final userAccountDateCreation = FirebaseAuth.instance.currentUser!.metadata.creationTime;
  final userLastSignIn = FirebaseAuth.instance.currentUser!.metadata.lastSignInTime;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text("Firebase Home",
              style: MyAppBarStyle.mainAppBarStyle,)),
        actions: [
          GestureDetector(
              onTap:  () async => {
                await FirebaseAuth.instance.signOut(),
                Navigator.pushReplacement(
                  context, MaterialPageRoute(
                  builder: (context)=> const Login(),
                ),
                ),
              },
              child: Image.asset(
                "assests/images/logout2.png",
                height: 60,
                width: 60,
              ))
        ],
      ),
      body: Column(children: [
        Container(
          height: 45,
          width: 45,
          margin: const EdgeInsets.only(top: 20),
          child: Image.asset("assests/images/icons8-dashboard-64.png"),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(left: 23, right: 23, top: 15),
          child: const Center(
            child: Text(
                "Dashboard",
                style: MyHomeTextStyle.mainHomeTextStyle),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(left: 15, right: 23, top: 25),
          child: Row(children: [
            const Text("ID: ", style: MyHomeDetailStyle.mainHomeDetailTextStyle),
            Text("$userID", style: MyHomeDetailFirebaseStyle.mainHomeDetailFirebaseTextStyle,)
          ],),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(left: 15, right: 23, top: 10),
          child: Row(children: [
            const Text("Email: ", style: MyHomeDetailStyle.mainHomeDetailTextStyle),
            Text("$userEmail", style: MyHomeDetailFirebaseStyle.mainHomeDetailFirebaseTextStyle,)

          ],),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(left: 15, right: 23, top: 10),
          child: Row(children: [
            const Text("Creation Date: ", style: MyHomeDetailStyle.mainHomeDetailTextStyle),
            Text("$userAccountDateCreation", style: MyHomeDetailFirebaseStyle.mainHomeDetailFirebaseTextStyle,)

          ],),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(left: 15, right: 23, top: 10),
          child: Row(children: [
            const Text("Last Signin: ", style: MyHomeDetailStyle.mainHomeDetailTextStyle),
            Text("$userLastSignIn", style: MyHomeDetailFirebaseStyle.mainHomeDetailFirebaseTextStyle,)

          ],),
        ),
      ],
      ),

    );
  }
}
