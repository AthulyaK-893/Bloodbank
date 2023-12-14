import 'dart:developer';
import 'package:blood_dontaion_app/bloodgroup.dart';
import 'package:blood_dontaion_app/details.dart';
import 'package:blood_dontaion_app/otpverification.dart';
import 'package:blood_dontaion_app/view/googlesheet/googlesheets.dart';
import 'package:blood_dontaion_app/view/welcome.screen.dart.dart';
import 'package:blood_dontaion_app/documentlistview.dart';
import 'package:blood_dontaion_app/sheetscolumn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'bloodgroup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gsheets/gsheets.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Create extends StatefulWidget {
  const Create({
    super.key,
  });

  static String verify = "";

  @override
  State<Create> createState() => _CreateState();
}

class _CreateState extends State<Create> {
  String _selectedGender = '';
  String gender = "";
  String selectGenderValue = "";
  TextEditingController dateInputController = TextEditingController();
  final TextEditingController departmentController = TextEditingController();
  TextEditingController countrycode = TextEditingController();
  departmentList? selecteddepartment;
  var email_controller = TextEditingController();
  var passwor_controller = TextEditingController();
  final _controller1 = TextEditingController();
  final _controller2 = TextEditingController();
  final _controller3 = TextEditingController();
  final _controller4 = TextEditingController();
  var argumentData = Get.arguments;

  FirebaseAuth auth = FirebaseAuth.instance;

  loginUser({email, password}) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    }
  }

  createUser({email, password}) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    }
  }

  void savetask() async {
    final studentName = _controller1.text;
    final lastName = _controller2.text;
    final phone = _controller3.text;
    final dateOfbirth = dateInputController.text;
    final departmentname = departmentController.text;
    final password = _controller4.text;
    final confirmPassword = passwor_controller.text;
    final genderSelected = gender.toString();
    final argumentDatas = argumentData.toString();
    final email = email_controller.text;
    final userids = FirebaseAuth.instance.currentUser?.uid.toString();

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('uid', userids!);
    print(prefs.getString('uid'));

    FirebaseAuth firebaseAuth = FirebaseAuth.instance;

   auth.setSettings(appVerificationDisabledForTesting: true);

    String? userIds = firebaseAuth.currentUser?.uid;
    FirebaseFirestore.instance.collection("Doners").doc(userIds).set({
      "Name": studentName,
      "LastName": lastName,
      "Date of birth": dateOfbirth,
      "Phone": phone,
      "Department": departmentname,
      "Password": password,
      "Confirm Password": confirmPassword,
      "Gender": genderSelected,
      "Blood group": argumentDatas,
      "Email": email,
      "usriid": userids,
    });
  }

  var phone = "";
  @override
  void initState() {
    // TODO: implement initState
    _controller3.text = "+91";
    super.initState();
  }

  bool passwordVisible = false;

  @override
  void InitState1() {
    super.initState();
    passwordVisible = true;
  }

  bool confirmPasswordVisible = false;

  @override
  void InitState2() {
    super.initState();
    confirmPasswordVisible = true;
  }

  final formKey = GlobalKey<FormState>();
  void _handleRadioValueChange(value) {
    setState(() {
      _selectedGender = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuEntry<departmentList>> departmentEntries =
        <DropdownMenuEntry<departmentList>>[];
    for (final departmentList department in departmentList.values) {
      departmentEntries.add(
        DropdownMenuEntry<departmentList>(
          value: department,
          label: department.label,
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 143,
        backgroundColor: const Color.fromARGB(253, 214, 0, 50),
        title: Text(
          "Create account",
          style: GoogleFonts.nunito(
              fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () async {
          if (formKey.currentState!.validate()) {
            try {
              final feedback = {
                SheetsColumn.name: _controller1.text.trim(),
                SheetsColumn.lastname: _controller2.text.trim(),
                SheetsColumn.dateofbirth: dateInputController.text.trim(),
                SheetsColumn.phone: _controller3.text.trim(),
                SheetsColumn.department: departmentController.text.trim(),
                SheetsColumn.gender: gender.toString().trim(),
              };

              await SheetsBloodDonation.insert([feedback]);
              await FirebaseAuth.instance.verifyPhoneNumber(
                phoneNumber: phone,
                verificationCompleted: (PhoneAuthCredential credential) {},
                verificationFailed: (FirebaseAuthException e) {},
                codeSent: (String verificationId, int? resendToken) {
                  Create.verify = verificationId;
                },
                codeAutoRetrievalTimeout: (String verificationId) {},
              );
              await createUser(
                  email: email_controller.text,
                  password: passwor_controller.text);
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return const OTPverification();
              }));
            } catch (e) {
              log(e.toString());
              throw Exception();
            }
          }
          savetask();
        },
        child: Container(
          height: 56,
          width: 327,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromARGB(253, 214, 0, 50)),
          child: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Text(
              "Next",
              style: GoogleFonts.nunito(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 288, top: 15),
                  child: Text(
                    "Name",
                    style: GoogleFonts.nunito(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: const Color.fromARGB(255, 120, 130, 138)),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _controller1,
                  decoration: InputDecoration(
                    labelText: "Enter your first name",
                    labelStyle: GoogleFonts.nunito(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromARGB(255, 156, 164, 171)),
                    border: const OutlineInputBorder(),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 129, 128, 127))),
                  ),
                  validator: (value) {
                    if (value!.isEmpty ||
                        !RegExp(r'^[a-z A-z]+$').hasMatch(value!)) {
                      return "Enter correct name";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.name,
                  style: GoogleFonts.nunito(
                      fontSize: 16, fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.only(right: 258),
                  child: Text(
                    "Last Name",
                    style: GoogleFonts.nunito(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: const Color.fromARGB(255, 120, 130, 138)),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _controller2,
                  decoration: InputDecoration(
                    labelText: "Enter your last name",
                    labelStyle: GoogleFonts.nunito(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromARGB(255, 156, 164, 171)),
                    border: const OutlineInputBorder(),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 129, 128, 127))),
                  ),
                  validator: (value) {
                    if (value!.isEmpty ||
                        !RegExp(r'^[a-z A-z]+$').hasMatch(value!)) {
                      return "Enter correct Lastname";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.name,
                  style: GoogleFonts.nunito(
                      fontSize: 16, fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.only(right: 237),
                  child: Text(
                    "Date of Birth",
                    style: GoogleFonts.nunito(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: const Color.fromARGB(255, 120, 130, 138)),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "DD/MM/YYYY",
                    labelStyle: GoogleFonts.nunito(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromARGB(255, 156, 164, 171)),
                    border: const OutlineInputBorder(),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 129, 128, 127))),
                    suffixIcon: const Icon(
                      Icons.calendar_month,
                      color: Color.fromARGB(255, 214, 0, 50),
                    ),
                  ),
                  controller: dateInputController,
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1950),
                      lastDate: DateTime(2100),
                    );

                    if (pickedDate != null) {
                      dateInputController.text =
                          DateFormat('dd MMMM yyyy').format(pickedDate);
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                  style: GoogleFonts.nunito(
                      fontSize: 16, fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.only(right: 275),
                  child: Text(
                    "Gender",
                    style: GoogleFonts.nunito(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: const Color.fromARGB(255, 120, 130, 138)),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 230,
                  width: 327,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                          style: BorderStyle.solid,
                          color: const Color.fromARGB(255, 129, 128, 127))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 20, left: 5),
                        height: 55,
                        width: 160,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                style: BorderStyle.solid,
                                color: const Color.fromARGB(255, 129, 128, 127))),
                        child: RadioListTile(
                          title: const Text('Male'),
                          value: 'Male',
                          groupValue: _selectedGender,
                          onChanged: _handleRadioValueChange,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 5),
                        height: 55,
                        width: 160,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                style: BorderStyle.solid,
                                color: const Color.fromARGB(255, 129, 128, 127))),
                        child: RadioListTile(
                          title: const Text('Female'),
                          value: 'Female',
                          groupValue: _selectedGender,
                          onChanged: _handleRadioValueChange,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 5),
                        height: 55,
                        width: 160,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                style: BorderStyle.solid,
                                color: const Color.fromARGB(255, 129, 128, 127))),
                        child: RadioListTile(
                          title: const Text('Other'),
                          value: 'Other',
                          groupValue: _selectedGender,
                          onChanged: _handleRadioValueChange,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.only(right: 285),
                  child: Text(
                    "Phone",
                    style: GoogleFonts.nunito(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: const Color.fromARGB(255, 120, 130, 138)),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _controller3,
                  onChanged: (value) {
                    phone = value;
                  },
                  decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 129, 128, 127))),
                      labelText: "Enter your phone number",
                      labelStyle: GoogleFonts.nunito(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: const Color.fromARGB(255, 156, 164, 171)),
                      border: const OutlineInputBorder()),
                  validator: (value) {
                    if (value!.isEmpty && value.length < 13) {
                      return "Enter correct phone number";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.phone,
                  style: GoogleFonts.nunito(
                      fontSize: 16, fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.only(right: 230),
                  child: Text(
                    "Email address",
                    style: GoogleFonts.nunito(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: const Color.fromARGB(255, 120, 130, 138)),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: email_controller,
                  decoration: InputDecoration(
                    labelText: "Enter your email address",
                    labelStyle: GoogleFonts.nunito(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromARGB(255, 156, 164, 171)),
                    border: const OutlineInputBorder(),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 129, 128, 127))),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  style: GoogleFonts.nunito(
                      fontSize: 16, fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.only(right: 247),
                  child: Text(
                    "Department",
                    style: GoogleFonts.nunito(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: const Color.fromARGB(255, 120, 130, 138)),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 55,
                  width: 330,
                  child: TextFormField(
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(
                              style: BorderStyle.solid,
                              color: Color.fromARGB(255, 227, 231, 236))),
                      suffixIcon: DropdownMenu<departmentList>(
                        width: 330,
                        controller: departmentController,
                        label: Text(
                          "Select your department",
                          style: GoogleFonts.nunito(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: const Color.fromARGB(255, 156, 164, 171)),
                        ),
                        dropdownMenuEntries: departmentEntries,
                        onSelected: (departmentList? department) {
                          setState(() {
                            selecteddepartment = department;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 258),
                  child: Text(
                    "Password",
                    style: GoogleFonts.nunito(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: const Color.fromARGB(255, 120, 130, 138)),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _controller4,
                  validator: (passCurrentValue) {
                    RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])');
                    var passNonNullValue = passCurrentValue ?? "";
                    if (passNonNullValue.isEmpty) {
                      return ("Password is required");
                    } else if (!regex.hasMatch(passNonNullValue)) {
                      return ("Password should contain"
                          "\n"
                          "upper,lower,digit ");
                    }
                    return null;
                  },
                  obscureText: confirmPasswordVisible,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                        confirmPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: const Color.fromARGB(255, 155, 153, 153),
                        size: 23,
                      ),
                      onPressed: () {
                        setState(
                          () {
                            confirmPasswordVisible = !confirmPasswordVisible;
                          },
                        );
                      },
                    ),
                    labelText: "Enter your password",
                    labelStyle: GoogleFonts.nunito(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromARGB(255, 156, 164, 171)),
                    border: const OutlineInputBorder(),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 129, 128, 127))),
                  ),
                  keyboardType: TextInputType.name,
                  style: GoogleFonts.nunito(
                      fontSize: 16, fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.only(right: 208),
                  child: Text(
                    "Confirm Password",
                    style: GoogleFonts.nunito(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: const Color.fromARGB(255, 120, 130, 138)),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  validator: (val) {
                    if (val!.isEmpty) return 'Empty';
                    if (val != _controller4.text) return 'Not Match';
                    return null;
                  },
                  controller: passwor_controller,
                  obscureText: passwordVisible,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                        passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: const Color.fromARGB(255, 155, 153, 153),
                        size: 23,
                      ),
                      onPressed: () {
                        setState(
                          () {
                            passwordVisible = !passwordVisible;
                          },
                        );
                      },
                    ),
                    labelText: "Enter your password",
                    labelStyle: GoogleFonts.nunito(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromARGB(255, 156, 164, 171)),
                    border: const OutlineInputBorder(),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 129, 128, 127))),
                  ),
                  keyboardType: TextInputType.name,
                  style: GoogleFonts.nunito(
                      fontSize: 16, fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum departmentList {
  BALLB("department", "BA-LLB"),
  MCA(
    "department",
    "MCA",
  ),
  LLM("department", "LLM"),
  MBA(
    "department",
    "MBA",
  ),
  LIFESCIENCE("department", "Life Science"),
  MOLICULAR(
    "department",
    "Molicular Biology",
  ),
  MA(
    "department",
    "Economics",
  ),
  MAE(
    "department",
    "MA English",
  ),
  MAA(
    "department",
    "MA Antropology",
  );

  const departmentList(this.department, this.label);
  final String department;
  final String label;
}

enum ExtraTopping { male, female }

class Gender extends StatefulWidget {
  const Gender({Key? key}) : super(key: key);

  @override
  State<Gender> createState() => GenderState();
}

class GenderState extends State<Gender> {
  var selectedValue = ExtraTopping.male;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      child: ListView(
        shrinkWrap: true,
        children: [
          RadioListTile<ExtraTopping>(
              title: Text(
                'male',
                style: GoogleFonts.nunito(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              value: ExtraTopping.male,
              groupValue: selectedValue,
              onChanged: (value) {
                setState(() {
                  selectedValue = value!;
                });
              }),
          RadioListTile<ExtraTopping>(
              title: Text(
                'female',
                style: GoogleFonts.nunito(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              value: ExtraTopping.female,
              groupValue: selectedValue,
              onChanged: (value) {
                setState(() {
                  selectedValue = value!;
                });
              }),
        ],
      ),
    );
  }
}
