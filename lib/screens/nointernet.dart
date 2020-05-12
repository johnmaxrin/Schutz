import 'package:flutter/material.dart';

class nointernet extends StatefulWidget {
  nointernet({Key key}) : super(key: key);

  _nointernetState createState() => _nointernetState();
}

class _nointernetState extends State<nointernet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Container(
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           
           children: <Widget>[
              Container(
                 height: 200.0,
                 child: Image.asset('assets/sadchekkan.png',fit: BoxFit.contain,)),
             Center(child: Text('No Internet',style: TextStyle(fontSize: 20.0,fontFamily: 'poppins'),),),
           ],
         ),
      ),
    );
  }
}//OTP We will generate and Show!! On Screen when he taps!! 