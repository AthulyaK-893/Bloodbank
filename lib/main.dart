import 'package:blood_dontaion_app/account.dart';
import 'package:blood_dontaion_app/adminaccount.dart';
import 'package:blood_dontaion_app/bloodgroup.dart';
import 'package:blood_dontaion_app/create.dart';
import 'package:blood_dontaion_app/details.dart';
import 'package:blood_dontaion_app/documentlistview.dart';

import 'package:blood_dontaion_app/otpverification.dart';
import 'package:blood_dontaion_app/view/googlesheet/googlesheets.dart';
import 'package:blood_dontaion_app/view/welcome.screen.dart.dart';
//import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  /*  await FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey: 'recaptcha-v3-site-key',
     androidProvider: AndroidProvider.debug,);*/
  await SheetsBloodDonation.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var auth = FirebaseAuth.instance;
  var isLogin = false;

  checkIfLogin() async {
    auth.authStateChanges().listen((User? user) {
      if (user != null && mounted) {
        setState(() {
          isLogin = true;
        });
      }
    });
  }

  @override
  void initState() {
    checkIfLogin();
    // TODO: implement initState
    super.initState();
  }

  late String selectedValue = "";
  String phone = "";

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: isLogin ? "details" : "Login",
      routes: {
        "Login": (context) => LoginPage(),
        "create": (context) => Create(),
        "verification": (context) => OTPverification(),
        "bloodGroup": (context) => BloodGroup(),
        "details": (context) => Details(),
        "account": (context) => Account(),
        "Adminpage": (context) => DocumentListView(),
        // "AdminAccount":(context) => AdminAccount()
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
