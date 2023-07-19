import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: Container(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 65),
                width: MediaQuery.sizeOf(context).height,
                height: 150,
                color: Color(0xffd60033),
                child: Text("Create account",style: GoogleFonts.nunito(
                  fontSize:20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white ),
                  textAlign: TextAlign.center,),
                
              )
            ],
          ),
      ),
    );
  }
}