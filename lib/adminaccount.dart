/*import 'package:blood_dontaion_app/details.dart';
import 'package:blood_dontaion_app/documentlistview.dart';
import 'package:blood_dontaion_app/loginpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:blood_dontaion_app/create.dart';

class AdminAccount extends StatefulWidget {
  const AdminAccount({
    super.key,
  });

  @override
  State<AdminAccount> createState() => _AdminAccountState();
}

class _AdminAccountState extends State<AdminAccount> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String? userid = "";
  void onload() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userid = prefs.getString('uid');
    });
    print(userid);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onload();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Color.fromARGB(255, 251, 229, 235) ,
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
      body: FutureBuilder(
          future:
              FirebaseFirestore.instance.collection("Doners").doc(userid).get(),
          builder: (context, snapshot) {
            if (snapshot.hasData && !snapshot.data!.exists) {
              return const Text("Conection Error");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading..");
            }
            // if (snapshot.connectionState == ConnectionState.done) {}
            return Padding(
              padding: const EdgeInsets.only(left: 90),
              child: Column(
                children: [
                  Icon(Icons.account_circle_sharp,size:80,color:Color.fromARGB(255, 216, 0, 50)),
                  SizedBox(
                    height: 20,
                  ),
                  Text(snapshot.data!["Name"],style:GoogleFonts.nunito(fontSize: 17,fontWeight: FontWeight.w600,color: Color.fromARGB(255, 14, 110, 201)) ,),
                  SizedBox(height: 10,),
                  Text(snapshot.data!["Email"],style:GoogleFonts.nunito(fontSize: 17,fontWeight: FontWeight.w600,color: Color.fromARGB(255, 14, 110, 201)) ,),
                   SizedBox(height: 10,),
                  Text(snapshot.data!["Phone"],style:GoogleFonts.nunito(fontSize: 17,fontWeight: FontWeight.w600,color:  Color.fromARGB(255, 14, 110, 201)) ,),
                   SizedBox(height: 10,),
                  Text("Blood group : ${snapshot.data!["Blood group"]}",style:GoogleFonts.nunito(fontSize: 17,fontWeight: FontWeight.w600,color: Color.fromARGB(255, 14, 110, 201)) ,)
                  /* Padding(
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
                        snapshot.data!["Name"],
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
                        snapshot.data!["LastName"],
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
                        snapshot.data!["Phone"],
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
                        snapshot.data!["Department"],
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
                                snapshot.data!["Gender"],
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
                                snapshot.data!["Date of birth"],
                                style: GoogleFonts.nunito(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),*/
                ],
              ),
            );
          }),
    );
  }

  Future<void> _logOut(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    await _firebaseAuth.signOut().then((value) =>
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return LoginPage();
        })));
  }
}
*/