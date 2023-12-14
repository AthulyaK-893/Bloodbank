import 'package:blood_dontaion_app/account.dart';
import 'package:blood_dontaion_app/adminaccount.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:blood_dontaion_app/documentlistview.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:blood_dontaion_app/create.dart';
import 'package:blood_dontaion_app/documentlistview.dart';

class DocumentListView extends StatefulWidget {
  const DocumentListView({super.key});

  @override
  State<DocumentListView> createState() => _DocumentListViewState();
}

class _DocumentListViewState extends State<DocumentListView> {
  TextEditingController _searchController = TextEditingController();
  var searchName = "";
  bool isFilterActive = false;
  String filterBloodGroup = '';

  String selectedBloodGroup = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 175,
        leadingWidth: 390,
        backgroundColor: Color.fromARGB(255, 214, 0, 50),
        leading: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 22),
              child: Row(
                children: [
                  Container(
                    height: 32,
                    width: 32,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        color: Color.fromARGB(255, 47, 45, 45)),
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 98,
                  ),
                  Text(
                    "Home",
                    style: GoogleFonts.nunito(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 45),
              child: SizedBox(
                height: 45,
                width: 328,
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {
                      searchName = value;
                    });
                  },
                  style: TextStyle(color: Color.fromARGB(255, 198, 198, 198)),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(26)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(26)),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Search Users",
                    hintStyle:
                        TextStyle(color: Color.fromARGB(255, 156, 164, 171)),
                    helperStyle: GoogleFonts.nunito(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                    prefixIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.search,
                        color: Color.fromARGB(255, 198, 198, 198),
                        size: 25,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(21),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 9),
              height: 65,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: GroupContainer().Groups.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedBloodGroup = GroupContainer().Groups[index];
                            isFilterActive = true;
                            filterBloodGroup = GroupContainer().Groups[index];
                            print(selectedBloodGroup);
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 10, top: 15),
                          height: 45,
                          width: 55,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: selectedBloodGroup ==
                                      GroupContainer().Groups[index]
                                  ? Color.fromARGB(255, 214, 0, 50)
                                  : Color.fromARGB(255, 251, 229, 235)),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              GroupContainer().Groups[index],
                              textAlign: TextAlign.center,
                              style: GoogleFonts.nunito(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 17,
                                  color: selectedBloodGroup ==
                                          GroupContainer().Groups[index]
                                      ? Colors.white
                                      : Color.fromARGB(255, 214, 0, 50)),
                            ),
                          ),
                        ));
                  }),
            ),
            SizedBox(
              height: 10,
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Doners")
                    .orderBy("Name")
                    .startAt([searchName]).endAt(
                        [searchName + "\uf8ff"]).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text("Connection error");
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text("Loading...");
                  }

                  var docs = snapshot.data!.docs;

                  return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: docs.length,
                      itemBuilder: (context, index) {
                        if (isFilterActive &&
                            docs[index]['Blood group'] != filterBloodGroup) {
                          return Container();
                        }

                        var data = snapshot.data!.docs[index];
                        return Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Container(
                            margin: EdgeInsets.only(top: 15),
                            height: 100,
                            width: 328,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color.fromARGB(255, 253, 242, 245)),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 20,
                                right: 20,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data["Name"],
                                        style: GoogleFonts.nunito(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Color.fromARGB(
                                                255, 156, 164, 171)),
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Text(data["Phone"],
                                          style: GoogleFonts.nunito(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Color.fromARGB(
                                                  255, 156, 164, 171))),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Text(data["Department"],
                                          style: GoogleFonts.nunito(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Color.fromARGB(
                                                  255, 156, 164, 171)))
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 58),
                                        child: Text(
                                          data["Blood group"],
                                          style: GoogleFonts.nunito(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color:
                                                Color.fromARGB(255, 214, 0, 50),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: Color.fromARGB(
                                                255, 250, 222, 229),
                                            child: IconButton(
                                                onPressed: () async {
                                                  final Uri url = Uri(
                                                      scheme: "sms",
                                                      path: docs[index]
                                                          ["Phone"]);
                                                  if (await canLaunchUrl(url)) {
                                                    await launchUrl(url);
                                                  } else {
                                                    print(
                                                        "cannot launch this url");
                                                  }
                                                },
                                                icon: Icon(
                                                  Icons.message,
                                                  color: Color.fromARGB(
                                                      255, 214, 0, 50),
                                                )),
                                          ),
                                          SizedBox(
                                            width: 6,
                                          ),
                                          CircleAvatar(
                                            backgroundColor: Color.fromARGB(
                                                255, 250, 222, 229),
                                            child: IconButton(
                                                onPressed: () async {
                                                  final Uri url = Uri(
                                                      scheme: "tel",
                                                      path: docs[index]
                                                          ["Phone"]);
                                                  if (await canLaunchUrl(url)) {
                                                    await launchUrl(url);
                                                  } else {
                                                    print(
                                                        "cannot launch this url");
                                                  }
                                                },
                                                icon: Icon(
                                                  Icons.call,
                                                  color: Color.fromARGB(
                                                      255, 214, 0, 50),
                                                )),
                                          )
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                })
          ],
        ),
      ),
    );
  }
}

class GroupContainer {
  List Groups = ["A+", "B+", "A-", "B-", "AB+", "O+", "O-", "AB-", "HH"];
}
