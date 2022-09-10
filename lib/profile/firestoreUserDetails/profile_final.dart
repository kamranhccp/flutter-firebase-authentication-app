import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_email_pass_auth/pages/login.dart';
import 'package:flutter_firebase_email_pass_auth/profile/firestoreUserDetails/list_user_details.dart';

import '../../constants/global_constants.dart';

class ProfileFinal extends StatefulWidget {
  const ProfileFinal({Key? key}) : super(key: key);

  @override
  State<ProfileFinal> createState() => _ProfileFinalState();
}

class _ProfileFinalState extends State<ProfileFinal> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text("Firebase Profile",
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
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: ListView(
              children: [
                Container(
                  height: 45,
                  width: 45,
                  margin: const EdgeInsets.only(top: 20),
                  child: Image.asset("assests/images/profile.png"),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(left: 23, right: 23, top: 15),
                  child: const Center(
                    child: Text(
                        "Profile",
                        style: MyHomeTextStyle.mainHomeTextStyle),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 30,
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(top: 30),
                      child: const Text("Email",
                        style: MyProfileTextStyle.mainProfileTextStyle,),
                    ),
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(top: 0),
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.purple, width: 1.5)
                      ),
                      child: ListView(
                        children: [

                        ],
                      ),
                    ),
                  ],
                )
              ]
          ),
        ),
      ),
    );
  }
}
