import 'package:blood_dontaion_app/bloodgroup.dart';
import 'package:blood_dontaion_app/create.dart';
import 'package:blood_dontaion_app/signin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 214, 0, 50),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            children: [
              Positioned(
                  child: Image.asset(
                "assets/images/Untitled-123 1.png",
              )),
              
              GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return SigninPage();
                  }));
                },
                child: Container(
                    margin: EdgeInsets.only(top: 450, left: 18),
                    height: 56,
                    width: 327,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromARGB(255, 255, 255, 255)),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Text(
                        "Sign in",
                        style: GoogleFonts.nunito(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 214, 0, 50)),
                        textAlign: TextAlign.center,
                      ),
                    )),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return BloodGroup();
                  }));
                },
                child: Container(
                  margin: EdgeInsets.only(top: 520, left: 18),
                  height: 56,
                  width: 327,
                  decoration: BoxDecoration(
                      border: Border.all(
                          style: BorderStyle.solid,
                          color: Color.fromARGB(255, 255, 255, 255)),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text(
                      "Create account",
                      style: GoogleFonts.nunito(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 255, 255, 255)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Positioned(
                  top: 600,
                  left: 60,
                  child:SvgPicture.asset("assets/svg/Frame 1000006998.svg")),
              Positioned(
                  top: 630,
                  left: 63,
                  child: Text(
                      "STUDENTS FEDERATION OF INDIA PALAYAD CAMPUS UNIT COMMITTEE",
                      style: GoogleFonts.nunito(
                          color: Colors.white, fontSize: 6))),
                        
            ],
          ),
        ));
  }
}
