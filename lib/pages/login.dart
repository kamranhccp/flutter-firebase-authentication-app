import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_email_pass_auth/constants/global_constants.dart';
import 'package:flutter_firebase_email_pass_auth/pages/flutter_home.dart';
import 'package:flutter_firebase_email_pass_auth/pages/forgot_password.dart';
import 'package:flutter_firebase_email_pass_auth/pages/home.dart';
import 'package:flutter_firebase_email_pass_auth/pages/sign_up.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  var email = "";
  var password = "";

  // to retrieve current value
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // firebase login
  login() async{
    try{
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email: email,
          password: password);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context)=> FlutterHomeMain(),
        ),
      );
    } on FirebaseAuthException catch (e){
      if(e.code == 'user-not-found'){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text("Account not Exists.",
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.w400,),
            ),
          ),
        );
      } else if(e.code == 'wrong-password'){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text("Wrong Password. Enter Correct Password",
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
  void dispose(){
    // dispose method to clean up and not cause memory leakage
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xFF353756),
      appBar: AppBar(
        title: const Center(child: Text("Firebase Login", style: MyAppBarStyle.mainAppBarStyle,)),
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
                child: Image.asset("assests/images/login.png"),
              ),
              Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 30,),
                  child: const Text("Login to Continue", style: MyTextStyle.mainTextStyle),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  // style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
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
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  // style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                  autofocus: false,
                  obscureText: true,
                  decoration: InputDecoration(
                      enabledBorder: MyBorderStyle.mainBorderStyle,
                      fillColor: Colors.indigo,
                      labelText: "Password",
                      labelStyle: MyLabelStyle.mainLabelStyle,
                      errorStyle: MyErrorStyle.mainErrorStyle,
                      border: MyBorderStyle.mainBorderStyle,
                  ),
                  controller: passwordController,
                  // email validation
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'Please Enter your Password';
                    }
                    return null;
                  },
                ),
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
                        password = passwordController.text;
                      });
                      login();
                    }
                  },
                  child: const Text(
                    "Login",
                    style: MyButtonTextStyle.mainButtonTextStyle,),


                ),
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(left: 23, right: 23, ),
                  child: Center(
                      child: TextButton(
                        onPressed: () => {
                          Navigator.pushAndRemoveUntil(
                              context,
                              PageRouteBuilder(
                                  pageBuilder: (context, a, b) => const ForgotPassword(),
                                  transitionDuration: const Duration(seconds: 0)),
                                  (route) => false)
                        },
                          child: const Text(
                              "Forgot Password?",
                              style: MySmallTextStyle.mainSmallTextStyle),
                          ),
                  ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(left: 23, right: 23),
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
            ],

          ),
        ),
      ),
    );
  }
}
