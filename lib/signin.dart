import 'package:blood_dontaion_app/create.dart';
import 'package:blood_dontaion_app/details.dart';
import 'package:blood_dontaion_app/loginpage.dart';
import 'package:blood_dontaion_app/model/Usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  bool isLogin = false;
  var email_controller = TextEditingController();
  var password_controller = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  loginUser({email, password}) async {
    try {
      var halo = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final userids = FirebaseAuth.instance.currentUser?.uid.toString();
      await prefs.setString('uid', userids!);
      print(prefs.getString('uid'));
      print(halo);
      setState(() {
        isLogin = true;
      });
      return halo;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        return null;
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        return null;
      }

      return null;
    }
  }

  @override
  void dispose() {
    email_controller.dispose();
    password_controller.dispose();
    super.dispose();
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 251, 229, 235),
      body: Form(
        key: formKey,
        child: Builder(builder: (context) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 100,
                  ),
                  child: Text(
                    "Welcome Back",
                    style: GoogleFonts.nunito(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                        color: Color.fromARGB(253, 214, 0, 50)),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: email_controller,
                        validator: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value!)) {
                            return "Enter correct email address";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          labelText: "Enter your email address",
                          labelStyle: GoogleFonts.nunito(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(253, 214, 0, 50)),
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(253, 214, 0, 50))),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: password_controller,
                        validator: (passCurrentValue) {
                          RegExp regex = RegExp(
                              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                          var passNonNullValue = passCurrentValue ?? "";
                          if (passNonNullValue.isEmpty) {
                            return ("Password is required");
                          } else if (passNonNullValue.length < 6) {
                            return ("Password Must be more than 5 characters");
                          } else if (!regex.hasMatch(passNonNullValue)) {
                            return ("Password should contain"
                                "\n"
                                "upper,lower,digit and Special character ");
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: "Enter your password",
                          labelStyle: GoogleFonts.nunito(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(253, 214, 0, 50)),
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(253, 214, 0, 50))),
                        ),
                        keyboardType: TextInputType.visiblePassword,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      await loginUser(
                          email: email_controller.text,
                          password: password_controller.text);

                      if (isLogin)
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) {
                          return Details();
                        }));
                    } else {
                      print("can't login");
                    }
                  },
                  child: Container(
                      margin: EdgeInsets.only(
                        top: 70,
                      ),
                      height: 65,
                      width: 330,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromARGB(255, 214, 0, 50)),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 17),
                        child: Text(
                          "Next",
                          style: GoogleFonts.nunito(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      )),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
