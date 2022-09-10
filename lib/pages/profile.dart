import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_email_pass_auth/constants/global_constants.dart';
import 'package:flutter_firebase_email_pass_auth/pages/login.dart';
import 'package:flutter_firebase_email_pass_auth/profile/editName.dart';

class FirestoreProfile extends StatefulWidget {
  const FirestoreProfile({Key? key}) : super(key: key);

  @override
  State<FirestoreProfile> createState() => _FirestoreProfileState();
}

class _FirestoreProfileState extends State<FirestoreProfile> {
  final _formKey = GlobalKey<FormState>();

  // final Future<FirebaseApp> _initialization  = Firebase.initializeApp();

  List<String> docsID = [];
  Future getDocIds() async {
    await FirebaseFirestore.instance.collection("users").get().then(
            (snapshot) => snapshot.docs.forEach(
                    (document) {
                      print(document.reference);
                      docsID.add(document.reference.id);
    }));
  }
  @override
  Widget build(BuildContext context) {
    // return FutureBuilder(
    //     future: _initialization,
    //     builder: (context, snapshot){
    //       if(snapshot.hasError){
    //         return const Text("Something went Wrong.");
    //       }
    //       if(snapshot.connectionState == ConnectionState.done){
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
             // theme: ThemeData(scaffoldBackgroundColor: const Color(0xff002f4c)),
             // theme: ThemeData(
             //   primarySwatch: Colors.deepPurple,
             // ),
             // debugShowCheckedModeBanner: false,
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
                                 color: const Color(0xFF99d7ff),
                                 borderRadius: BorderRadius.circular(15),
                                 border: Border.all(color: Colors.purple, width: 1.5)
                             ),
                             child: const Text("Kamran")
                           ),
                           Container(
                             height: 220,
                             width: MediaQuery.of(context).size.width,
                             margin: const EdgeInsets.only(top: 30),
                             child: FutureBuilder(
                               future: getDocIds(),
                               builder: (context, snapshot){
                                 return ListView.builder(
                                   itemCount: docsID.length,
                                   itemBuilder: (context, index){
                                     return ListTile(
                                       title: UserFirstName(documentID: docsID[index],),
                                     );
                                   },
                                 );
                               },
                             ),
                           )
                         ],
                       )
                     ]
                 ),
               ),
             ),
           );
          }
    //       return const CircularProgressIndicator(
    //         backgroundColor: Colors.deepPurple,
    //         valueColor: AlwaysStoppedAnimation(Colors.purpleAccent),
    //         strokeWidth: 7,
    //
    //       );
    //     }
    // );
  }
