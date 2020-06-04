import 'package:flutter/material.dart';

class privacypage extends StatefulWidget {
  privacypage({Key key}) : super(key: key);

  _privacypageState createState() => _privacypageState();
}

class _privacypageState extends State<privacypage> {
  @override
  Widget build(BuildContext context) {
    return  privacyscreen(context);
  }
}




Widget privacyscreen(context)
{
  return Scaffold(
    appBar: AppBar(backgroundColor: Colors.blueAccent,
    elevation: 0,
    leading: IconButton(icon: Icon(Icons.arrow_back,color:Colors.white),onPressed: (){Navigator.pop(context);},),
    ),
    backgroundColor: Colors.blueAccent,
    body: Column(
      children: <Widget>[

        Container(
          height: 100,
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50),bottomRight: Radius.circular(50),)
          ),
          child: Center(child: Text('Privacy',style:TextStyle(fontSize: 40.0,fontFamily: 'poppins',color: Colors.white),)),
        ),

        Expanded(
            child: Container(
            width: MediaQuery.of(context).size.width, 
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(50),topRight: Radius.circular(50))
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                Container(
                  padding: EdgeInsets.only(top: 40,left: 20,right: 20),
                  
                  child: RichText(
                    text: TextSpan(
                      text: 'The data we Collect,\n',
                      style: TextStyle(fontSize: 23,color: Colors.black45),
                      children: <TextSpan>[
                        TextSpan(text: 'are never compromised or sold. Your private details are in safe hands. We won\'t be tracking you continously, only when you book someone nearby or select to work here. And these details won\'t be available to the customer after the work is done.',
                        
                        style: TextStyle(fontSize: 13,color: Colors.black54)),

                      ]
                    ),
                  )
                ),

                                        Container(
                  padding: EdgeInsets.only(top: 30,left: 20,right: 30),
                  
                  child: RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      
                      text: 'Developed by Seventy3 \n',
                      style: TextStyle(fontSize: 19,color: Colors.black38),
                      children: <TextSpan>[
                        TextSpan( text: 'seventy3.tech \n',style: TextStyle(fontSize: 14)),
                        TextSpan( text: 'info@seventy3.tech \n',style: TextStyle(fontSize: 14)),
                        TextSpan( text: 'seventy3inc | Facebook & Linkedin\n',style: TextStyle(fontSize: 14)),
                        TextSpan( text: '7ty.3 | Instagram \n',style: TextStyle(fontSize: 14)),
                        TextSpan( text: '\nYour suggestions and critics are most welcome, All your  suggestions will be live in next update. Sorry for the gliches, we\'re making it awesome',style: TextStyle(fontSize: 13,color: Colors.black45)),
                      ]
                    ),
                  )
                ),


              ],
            )
          ),
        ),
      ],
    )
  );
}