import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_email_pass_auth/pages/login.dart';

import '../constants/global_constants.dart';

class FirebaseSettings extends StatefulWidget {
  const FirebaseSettings({Key? key}) : super(key: key);

  @override
  State<FirebaseSettings> createState() => _FirebaseSettingsState();
}

class _FirebaseSettingsState extends State<FirebaseSettings> {

  final userEmail = FirebaseAuth.instance.currentUser!.email;
  User? user = FirebaseAuth.instance.currentUser;
  verifyEmail() async{
    if(user != null && !user!.emailVerified){
      await user!.sendEmailVerification();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Text("Verification Email has been Sent.",
            style: TextStyle(
              fontSize: 17.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      );
    } else if(user != null && user!.emailVerified){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Text("Email already Verified.",
            style: TextStyle(
              fontSize: 17.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text("Firebase Setting",
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
          margin: const EdgeInsets.only(top: 25),
          child: Image.asset("assests/images/icons8-settings-64.png"),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(left: 23, right: 23, top: 20),
          child: const Center(
            child: Text(
                "Settings",
                style: MyHomeTextStyle.mainHomeTextStyle),
          ),
        ),
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 15, right: 23, top: 30),
            child: Row(children: [
              const Text("Email: ", style: MyHomeDetailStyle.mainHomeDetailTextStyle),
              Text("$userEmail", style: MyHomeDetailFirebaseStyle.mainHomeDetailFirebaseTextStyle,)
            ],),
          ),
        ),
        user!.emailVerified ? Container(
          height: 49,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(left: 23, right: 23, top: 22),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35)),
              side: const BorderSide(color: Colors.blueAccent, width: 2),
            ),
            onPressed: (){
              verifyEmail();
            },
            child: const Text(
              "Email Verified",
              style: MyButtonTextStyle.mainButtonTextStyle,),


          ),
        ) : Container(
          height: 49,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(left: 23, right: 23, top: 22),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35)),
              side: const BorderSide(color: Colors.blueAccent, width: 2),
            ),
            onPressed: (){
              verifyEmail();
            },
            child: const Text(
              "Verify Email",
              style: MyButtonTextStyle.mainButtonTextStyle,),


          ),
        ),
      ],),
    );
  }
}
