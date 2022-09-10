import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_email_pass_auth/constants/global_constants.dart';
import 'package:flutter_firebase_email_pass_auth/pages/forgot_password.dart';
// import 'package:flutter_firebase_email_pass_auth/pages/home.dart';
import 'package:flutter_firebase_email_pass_auth/pages/login.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();

  var email = "";
  var password = "";
  var confirmPassword = "";

  // to retrieve current value
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose(){
    // dispose method to clean up and not cause memory leakage
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  registration() async {
    if(password == confirmPassword){
      try{
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: email,
              password: password);
        print(userCredential);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.greenAccent,
            content: Text("Account Created Successfully. Please Login",
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context)=> const Login(),
          ),
        );
      } on FirebaseAuthException catch (e){
        if(e.code == 'weak-password'){
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.redAccent,
              content: Text("Password is too Weak",
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.w400,),
              ),
            ),
          );
        } else if(e.code == 'email-already-in-use'){
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.redAccent,
              content: Text("Account Already Exists",
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.w400),
              ),
            ),
          );
        }
      }
    } else{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Text("Password do not match",
            style: TextStyle(
              fontSize: 17.0,
              fontWeight: FontWeight.w400,),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Firebase Signup", style: MyAppBarStyle.mainAppBarStyle,)),
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
                child: Image.asset("assests/images/signup.png"),
              ),
              Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 30,),
                  child: const Text("Create An Account", style: MyTextStyle.mainTextStyle),
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
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
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
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  autofocus: false,
                  obscureText: true,
                  decoration: InputDecoration(
                    enabledBorder: MyBorderStyle.mainBorderStyle,
                    fillColor: Colors.indigo,
                    labelText: "Confirm Password",
                    labelStyle: MyLabelStyle.mainLabelStyle,
                    errorStyle: MyErrorStyle.mainErrorStyle,
                    border: MyBorderStyle.mainBorderStyle,
                  ),
                  controller: confirmPasswordController,
                  // email validation
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'Please Confirm Your Password';
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
                        confirmPassword = confirmPasswordController.text;
                      });
                      registration();

                    }
                  },
                  child: const Text(
                    "Create",
                    style: MyButtonTextStyle.mainButtonTextStyle,),


                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(left: 23, right: 23, ),
                child: Center(
                  child: TextButton(
                    onPressed: () => {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const ForgotPassword()))
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
