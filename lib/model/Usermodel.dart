/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserDetailsModel {
  final String name;
  final String lastName;
  final String dateOfbirth;
  final String gender;
  final String phone;
  final String department;

  UserDetailsModel(
      {required this.name,
      required this.lastName,
      required this.dateOfbirth,
      required this.gender,
      required this.phone,
      required this.department});
  factory UserDetailsModel.fromJson(Map<String, dynamic> json) =>
      UserDetailsModel(
          name: json["name"],
          lastName: json["lastName"],
          dateOfbirth: json["dateOfbirth"],
          gender: json["gender"],
           phone: json["phone"],
          department: json["department"]);

  Map<String, dynamic> getJson() => {
        'name': name,
        'lastName': lastName,
        'dateOfbirth': dateOfbirth,
        'gender': gender,
        "phone": phone,
        "department": department
      };
  factory UserDetailsModel.getModelFromJson(
      {required Map<String, dynamic> json}) {
    return UserDetailsModel(
        name: json["name"],
        lastName: json["lastName"],
        dateOfbirth: json["dateOfbirth"],
        gender: json["gender"],
        phone: json["phone"],
        department: json["department"]);
  }
}
class FirebaseAuth extends StatefulWidget {
  const FirebaseAuth({super.key});

  @override
  State<FirebaseAuth> createState() => _FirebaseAuthState();
}

class _FirebaseAuthState extends State<FirebaseAuth> {
    final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

     void addUser() {
    usersCollection.add({
      'name': 'John Doe',
      'lastName': 'Joseph',
      'dateOfbirth': "07 July 2023",
      "gender":"male",
      "phone":"7563091983",
      "department":"Economics"
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}*/