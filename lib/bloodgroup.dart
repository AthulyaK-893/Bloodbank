import 'package:blood_dontaion_app/details.dart';

import 'package:blood_dontaion_app/otpverification.dart';
import 'package:blood_dontaion_app/sheetscolumn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:blood_dontaion_app/create.dart';
import 'package:get/get.dart';

class BloodGroup extends StatefulWidget {
  const BloodGroup({
    super.key,
  });

  @override
  State<BloodGroup> createState() => _BloodGroupState();
}

class _BloodGroupState extends State<BloodGroup> {
  String selectedValue = "";
  List<bool> isSelected = [false, false];
  String bloodType = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GestureDetector(
        onTap: () {
          if (isSelected[0] || isSelected[1]) {
            Get.to(() => const Create(), arguments: selectedValue + bloodType);
          }
        },
        child: Container(
          height: 56,
          width: 327,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color.fromARGB(255, 214, 0, 50)),
          child: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Text(
              "Sign Up",
              style: GoogleFonts.nunito(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: 4,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 15,
                      mainAxisExtent: 153,
                      crossAxisSpacing: 15),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedValue = Model().gruopContainer[index];

                          print(Model().gruopContainer[index]);
                        });
                      },
                      child: Container(
                        height: 125,
                        width: 153,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color:
                                selectedValue == Model().gruopContainer[index]
                                    ? Color.fromARGB(255, 214, 0, 50)
                                    : Color.fromARGB(255, 251, 229, 235)),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 55),
                          child: Text(
                            Model().gruopContainer[index],
                            style: GoogleFonts.nunito(
                                fontWeight: FontWeight.w700,
                                fontSize: 27,
                                color: selectedValue ==
                                        Model().gruopContainer[index]
                                    ? Colors.white
                                    : Color.fromARGB(255, 214, 0, 50)),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: 100,
            ),
            ToggleButtons(
                children: [Icon(Icons.add), Icon(Icons.remove)],
                isSelected: isSelected,
                selectedColor: Colors.white,
                color: Color.fromARGB(255, 214, 0, 50),
                fillColor: Color.fromARGB(255, 214, 0, 50),
                borderRadius: BorderRadius.circular(10),
                onPressed: (int newindex) {
                  if (newindex == 0) {
                    bloodType = "+";
                    print(bloodType);
                    setState(() {
                      isSelected[0] = true;
                      isSelected[1] = false;
                    });
                  } else {
                    setState(() {
                      isSelected[0] = false;
                      isSelected[1] = true;
                    });
                    bloodType = "-";
                    print(bloodType);
                  }
                })
          ],
        ),
      ),
    );
  }
}

class Model {
  List gruopContainer = ["A", "B", "AB", "O"];
}
