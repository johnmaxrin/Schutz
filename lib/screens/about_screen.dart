import 'package:flutter/material.dart';

class about extends StatefulWidget {
  about({Key key}) : super(key: key);

  _aboutState createState() => _aboutState();
}

class _aboutState extends State<about> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Scaffold(
         backgroundColor: Colors.white,
         body: Container(
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
               Center(
                 child: Container(
                   height: 200.0,

                   child: Image.asset('assets/73logo.png',fit: BoxFit.contain,)),
               ),
               Padding(
                 padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                 child: Text('Designed and developed by Sijo M Thomas, Gokul Biju and K Robin of Amal Jyothi College of Enginnering at Seventy3. We took some vectors from Freepik. Thankyou for supporting us. This is a beta version and do report the issues. The data collected from you is in safe hands and the client or worker may be able to reach you, But we won\'t be tracking you Your Suggestions are always welcome. Write to us info@seventy3.tech, Stay Safe',
                      style: TextStyle(fontSize: 12,fontFamily: 'poppins',fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                 ),
               ),

               SizedBox(height: MediaQuery.of(context).size.height*0.01),

               GestureDetector(
                 onTap: (){
                   Navigator.pop(context);
                 },
                                child: Container(
                   height: MediaQuery.of(context).size.height*0.05,
                   width: MediaQuery.of(context).size.width*0.2,
                   decoration: BoxDecoration(
                     color: Colors.blueAccent,
                     borderRadius: BorderRadius.circular(20.0),
                   ),
                   child: Center(child: Text('back',style: TextStyle(fontSize: 17.0,color: Colors.white),)),
                 ),
               )
             ],
           ),
         )
       )
    );
  }
}