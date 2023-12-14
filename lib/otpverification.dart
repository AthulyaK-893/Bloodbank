import 'dart:developer';

import 'package:blood_dontaion_app/bloodgroup.dart';
import 'package:blood_dontaion_app/create.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pinput/pinput.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class OTPverification extends StatefulWidget {
  const OTPverification({super.key});

  @override
  State<OTPverification> createState() => _OTPverificationState();
}

class _OTPverificationState extends State<OTPverification> {
  bool isVerifying = false;
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(142, 171, 196, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    var code = "";
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Verification",
          style: GoogleFonts.nunito(fontSize: 25, fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: SvgPicture.asset(
                "assets/images/transaction-password-otp-verification-code-security-svgrepo-com.svg",
                height: 130,
                width: 130,
                color: Colors.blue,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Enter the verification code we"
              "\n"
              "       just sent you on your"
              "\n"
              "            phone number",
              style: GoogleFonts.nunito(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: const Color.fromARGB(255, 78, 111, 168)),
            ),
            SizedBox(
              height: 35,
            ),
            Pinput(
              length: 6,
              showCursor: true,
              onChanged: (value) {
                code = value;
              },
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 55,
              width: 250,
              child:

/*ElevatedButton(
  onPressed: isVerifying
      ? null 
      : () async {
          setState(() {
            isVerifying = true; 
          });

          try {
            PhoneAuthCredential credential =
                PhoneAuthProvider.credential(
                    verificationId: Create.verify, smsCode: code);

            await auth.signInWithCredential(credential).then((value) {
              Navigator.pushNamedAndRemoveUntil(
                  context, "details", (route) => false);
            });

            log(credential.toString());
          } catch (e) {
            print("Wrong OTP");
          } finally {
            setState(() {
              isVerifying = false; 
            });
          }
        },
  child: isVerifying
      ? CircularProgressIndicator( // Display a circular loading indicator
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        )
      : Text(
          "Verify phone number",
          style: GoogleFonts.nunito(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: 17),
        ),
  style: ElevatedButton.styleFrom(
    primary: isVerifying ? Colors.grey : Colors.green.shade600,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  ),
)*/

                  ElevatedButton(
                onPressed: () async {
                  try {
                    PhoneAuthCredential credential =
                        PhoneAuthProvider.credential(
                            verificationId: Create.verify, smsCode: code);

                    await auth.signInWithCredential(credential).then((value) {
                      Navigator.pushNamedAndRemoveUntil(
                          context, "details", (route) => false);
                    });

                    log(credential.toString());
                  } catch (e) {
                    print("Wrong OTP");
                  }
                },
                child: Text(
                  "Verify phone number",
                  style: GoogleFonts.nunito(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: 17),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Colors.green.shade600,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            )
          ],
        ),
      ),
    );
  }
}
