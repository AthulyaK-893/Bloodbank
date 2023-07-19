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
              ),
              Container(
                width: MediaQuery.sizeOf(context).width,
                // height: MediaQuery.sizeOf(context).height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Name",style: GoogleFonts.nunito(
                      fontSize: 14,
                      color: Color.fromARGB(255, 120, 130, 138)
                    ),),
                    TextField(
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(style: 
                        BorderStyle.solid,
                        width: 0.8,
                        color: Color.fromARGB(255, 156, 164, 171)),
                        ),hintText:"Enter your first name",hintStyle:GoogleFonts.nunito(fontSize: 16,
                        color: Color.fromARGB(255, 156, 164, 171)
                        )  ),),

                   Text("Last Name",style: GoogleFonts.nunito(
                      fontSize: 14,
                      color: Color.fromARGB(255, 120, 130, 138)
                    ),),
                    TextField(
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(style: 
                        BorderStyle.solid,
                        width: 0.8,
                        color: Color.fromARGB(255, 156, 164, 171)),
                        ),hintText:"Enter your last name",hintStyle:GoogleFonts.nunito(fontSize: 16,
                        color: Color.fromARGB(255, 156, 164, 171)
                        )  ),),
                    Text("Date of birth",style: GoogleFonts.nunito(
                      fontSize: 14,
                      color: Color.fromARGB(255, 120, 130, 138)
                    ),),
                    TextField(
                      keyboardType: TextInputType.name,
                      
                      decoration: InputDecoration(
                        suffixIcon: IconButton(onPressed: (){}, 
                        icon: Icon(Icons.calendar_month_outlined,
                        color: Color(0xffd60033) ,)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(style: 
                        BorderStyle.solid,
                        width: 0.8,
                        color: Color.fromARGB(255, 156, 164, 171)),
                        ),hintText:"DD/MM/YY",hintStyle:GoogleFonts.nunito(fontSize: 16,
                        color: Color.fromARGB(255, 156, 164, 171)
                        )  ),),    
                  ],

                )

              )
            ],
          ),
      ),
    );
  }
}