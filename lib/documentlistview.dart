/*import 'package:blood_dontaion_app/details.dart';
import 'package:blood_dontaion_app/loginpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DocumentListView extends StatefulWidget {
  const DocumentListView({
    super.key,
  });

  @override
  State<DocumentListView> createState() => _DocumentListViewState();
}

class _DocumentListViewState extends State<DocumentListView> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
User?usriid=FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop(MaterialPageRoute(builder: (context) {
                return Details();
              }));
            },
            child: Icon(Icons.arrow_back)),
        title: Text(
          "Account",
          style: GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          _logOut(context);
        },
        child: Container(
            margin: EdgeInsets.only(bottom: 15),
            height: 40,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.logout_rounded,
                  color: Color.fromARGB(255, 214, 0, 50),
                  size: 22,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Logout",
                  style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 214, 0, 50)),
                )
              ],
            )),
      ),
      body: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection("New students").where("usriid",isEqualTo:usriid?.uid).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text("connection error");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading...");
            }
            var docs = snapshot.data!.docs;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Color.fromARGB(255, 214, 0, 50)),
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 90,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 248),
                  child: Text(
                    "First Name",
                    style: GoogleFonts.nunito(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: Color.fromARGB(255, 179, 172, 172)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 45,
                  width: 328,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          style: BorderStyle.solid,
                          color: Color.fromARGB(255, 53, 142, 244))),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, top: 8),
                    child: Text(
                      snapshot.data!.docs[0].get("Name"),
                      style: GoogleFonts.nunito(
                          fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 250),
                  child: Text(
                    "Last Name",
                    style: GoogleFonts.nunito(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: Color.fromARGB(255, 179, 172, 172)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 45,
                  width: 328,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          style: BorderStyle.solid,
                          color: Color.fromARGB(255, 53, 142, 244))),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, top: 8),
                    child: Text(
                      snapshot.data!.docs[0].get("LastName"),
                      style: GoogleFonts.nunito(
                          fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 277),
                  child: Text(
                    "Phone",
                    style: GoogleFonts.nunito(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: Color.fromARGB(255, 179, 172, 172)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 45,
                  width: 328,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          style: BorderStyle.solid,
                          color: Color.fromARGB(255, 53, 142, 244))),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, top: 8),
                    child: Text(
                      snapshot.data!.docs[0].get("Phone"),
                      style: GoogleFonts.nunito(
                          fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 242),
                  child: Text(
                    "Department",
                    style: GoogleFonts.nunito(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: Color.fromARGB(255, 179, 172, 172)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 45,
                  width: 328,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          style: BorderStyle.solid,
                          color: Color.fromARGB(255, 53, 142, 244))),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, top: 8),
                    child: Text(
                      snapshot.data!.docs[0].get("Department"),
                      style: GoogleFonts.nunito(
                          fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 100),
                          child: Text(
                            "Gender",
                            style: GoogleFonts.nunito(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: Color.fromARGB(255, 179, 172, 172)),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 45,
                          width: 158,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  style: BorderStyle.solid,
                                  color: Color.fromARGB(255, 53, 142, 244))),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15, top: 8),
                            child: Text(
                              snapshot.data!.docs[0].get("Gender"),
                              style: GoogleFonts.nunito(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 62),
                          child: Text(
                            "Date of Birth",
                            style: GoogleFonts.nunito(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: Color.fromARGB(255, 179, 172, 172)),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 45,
                          width: 158,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  style: BorderStyle.solid,
                                  color: Color.fromARGB(255, 53, 142, 244))),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15, top: 8),
                            child: Text(
                              snapshot.data!.docs[0].get("Date of birth"),
                              style: GoogleFonts.nunito(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            );
          }),
    );
  }

  Future<void> _logOut(BuildContext context) async {
    await _firebaseAuth.signOut().then((value) =>
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return LoginPage();
        })));
  }
}*/
