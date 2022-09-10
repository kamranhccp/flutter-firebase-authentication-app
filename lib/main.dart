import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_email_pass_auth/pages/login.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
        builder: (context, snapshot){
        // check for errors

          if(snapshot.hasError){
            print("Something went Wrong!");
          }
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);
          }
          return const MaterialApp(
            // theme: new ThemeData(scaffoldBackgroundColor: const Color(0xff002f4c)),
            title: 'Flutter Firebase Auth Email Password',
            // theme: ThemeData(
            //   primarySwatch: Colors.deepPurple,
            // ),
            debugShowCheckedModeBanner: false,
            home: Login(),
          );
        }
    );

  }
}
