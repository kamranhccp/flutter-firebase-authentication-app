import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_email_pass_auth/constants/global_constants.dart';
import 'package:flutter_firebase_email_pass_auth/pages/login.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  ChangePasswordState createState() => ChangePasswordState();
}

class ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();

  var newPassword = "";
  // Create a text controller and use it to retrieve the current value
  // of the TextField.

  final newPasswordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    newPasswordController.dispose();
    super.dispose();
  }


  final currentUser = FirebaseAuth.instance.currentUser;
  changePassword() async {
    try {
      await currentUser!.updatePassword(newPassword);
      FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Text(
            'Password Changed. Login again!',
            style: TextStyle(
              fontSize: 17.0,
              fontWeight: FontWeight.w400,),
          ),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              'Password provided too weak.',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.w400,),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text("Firebase Change Password",
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
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  autofocus: false,
                  obscureText: true,
                  decoration: InputDecoration(
                    enabledBorder: MyBorderStyle.mainBorderStyle,
                    fillColor: Colors.indigo,
                    labelText: "Change Password",
                    labelStyle: MyLabelStyle.mainLabelStyle,
                    errorStyle: MyErrorStyle.mainErrorStyle,
                    border: MyBorderStyle.mainBorderStyle,
                  ),
                  controller: newPasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Password';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                height: 49,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(left: 23, right: 23, top: 12),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35)),
                    side: const BorderSide(color: Colors.blueAccent, width: 2),
                  ),
                  onPressed: () {
                    // Validate returns true if the form is valid, otherwise false.
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        newPassword = newPasswordController.text;
                      });
                      changePassword();
                    }
                  },
                  child: const Text(
                    'Change Password',
                    style: MyButtonTextStyle.mainButtonTextStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
