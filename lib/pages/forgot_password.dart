import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_email_pass_auth/constants/global_constants.dart';
import 'package:flutter_firebase_email_pass_auth/pages/login.dart';
import 'package:flutter_firebase_email_pass_auth/pages/sign_up.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();

  var email = "";

  // to retrieve current value
  final emailController = TextEditingController();

  @override
  void dispose(){
    // dispose method to clean up and not cause memory leakage
    emailController.dispose();
    super.dispose();
  }

  resetPassword() async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Text("Password Reset Email sent to your Account.",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context)=> const Login(),
        ),
      );
    }on FirebaseAuthException catch(e){
      if(e.code == 'user-not-found'){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text("Email not associated with an Account.",
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.w400,
              ),
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
        title: const Center(child: Text("Firebase Forgot Password", style: MyAppBarStyle.mainAppBarStyle,)),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: ListView(
            // for scrolling
            children: [
              Container(
                height: 45,
                width: 45,
                margin: const EdgeInsets.only(top: 20),
                child: Image.asset("assests/images/icons8-forgot-password-64.png"),
              ),
              Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 30,),
                  child: const Text("Reset Your Password", style: MyTextStyle.mainTextStyle),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  autofocus: false,
                  obscureText: false,
                  decoration: InputDecoration(
                      enabledBorder: MyBorderStyle.mainBorderStyle,
                      fillColor: Colors.indigo,
                      labelText: "Email",
                      labelStyle: MyLabelStyle.mainLabelStyle,
                      errorStyle: MyErrorStyle.mainErrorStyle,
                      border: MyBorderStyle.mainBorderStyle
                  ),
                  controller: emailController,
                  // email validation
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'Please Enter your Email';
                    } else if(!value.contains("@")){
                      return 'Please Enter Valid Email';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(left: 10, right: 23,),
                child: const Text(
                      "An Email will be sent to your Account.",
                      style: TextStyle(
                    color: Colors.purpleAccent,
                    fontWeight: FontWeight.w500,
                    fontSize: 14),),
                ),
              Container(
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

                    // validation if form is true
                    if(_formKey.currentState!.validate()){
                      setState(() {
                        email = emailController.text;
                      });
                      resetPassword();
                    }
                  },
                  child: const Text(
                    "Reset Password",
                    style: MyButtonTextStyle.mainButtonTextStyle,),
                ),
              ),

              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(left: 23, right: 23, top: 15),
                child: Center(
                  child: TextButton(
                    onPressed: () => {
                      Navigator.pushAndRemoveUntil(
                          context,
                          PageRouteBuilder(
                              pageBuilder: (context, a, b) => const Signup(),
                              transitionDuration: const Duration(seconds: 0)),
                              (route) => false)
                    },
                    child: const Text(
                        "Don't have an Account? Sign up",
                        style: MySmallTextStyle.mainSmallTextStyle),
                  ),
                ),
              ),
              Row(children: <Widget>[
                Expanded(
                  child: Container(
                      margin: const EdgeInsets.only(left: 30, right: 5),
                      child: const Divider(
                        color: Colors.purpleAccent,
                        height: 50,
                        thickness: 1.7,
                      )),
                ),
                const Text(" OR ",
                  style: TextStyle(
                      color: Colors.purpleAccent,
                      fontWeight: FontWeight.w600,
                      fontSize: 18),),
                Expanded(
                  child: Container(
                      margin: const EdgeInsets.only(left: 5, right: 30),
                      child: const Divider(
                        color: Colors.purpleAccent,
                        height: 50,
                        thickness: 1.7,
                      )),
                ),
              ]),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(left: 23, right: 23),
                child: Center(
                  child: TextButton(
                    onPressed: () => {
                      Navigator.pushAndRemoveUntil(
                          context,
                          PageRouteBuilder(
                              pageBuilder: (context, a, b) => const Login(),
                              transitionDuration: const Duration(seconds: 0)),
                              (route) => false)
                    },
                    child: const Text(
                        "Already have an Account? Login",
                        style: MySmallTextStyle.mainSmallTextStyle),
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
