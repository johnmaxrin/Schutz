import 'package:flutter/material.dart';

class helpscreen extends StatefulWidget {
  helpscreen({Key key}) : super(key: key);

  _helpscreenState createState() => _helpscreenState();
}

class _helpscreenState extends State<helpscreen> {
  @override
  Widget build(BuildContext context) {
    return  help_wid(context);
  }
}





Widget help_wid(context)
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
          child: Center(child: Text('Help',style:TextStyle(fontSize: 40.0,fontFamily: 'poppins',color: Colors.white),)),
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
                  padding: EdgeInsets.only(top: 40,left: 20),
                  
                  child: RichText(
                    text: TextSpan(
                      text: 'How to hire people nearby?',
                      style: TextStyle(fontSize: 20,color: Colors.black45),
                      children: <TextSpan>[
                        TextSpan(text: '\n 1.Select what kind work is to be done,  Eg Cleaning',style: TextStyle(fontSize: 13,color: Colors.black54)),
                        TextSpan(text: '\n 2.Choose a person from the list.',style: TextStyle(fontSize: 13,color: Colors.black54)),
                        TextSpan(text: '\n 3.Book him, If he accepts you can proceed.',style: TextStyle(fontSize: 13,color: Colors.black54)),
                        TextSpan(text: '\n 4.You can manage your booking under booking section.',style: TextStyle(fontSize: 13,color: Colors.black54)),
                      ]
                    ),
                  )
                ),

                                Container(
                  padding: EdgeInsets.only(top: 30,left: 20),
                  
                  child: RichText(
                    text: TextSpan(
                      text: 'How to work for people nearby?',
                      style: TextStyle(fontSize: 20,color: Colors.black45),
                      children: <TextSpan>[
                        TextSpan(text: '\n 1.Tap on the \u20b9 button and press work here.',style: TextStyle(fontSize: 13,color: Colors.black54)),
                        TextSpan(text: '\n 2.Make sure you got enough balance else topup.',style: TextStyle(fontSize: 13,color: Colors.black54)),
                        TextSpan(text: '\n 3.Select the skills which you\'re ready to do.',style: TextStyle(fontSize: 13,color: Colors.black54)),
                        TextSpan(text: '\n 4.Then press start.',style: TextStyle(fontSize: 13,color: Colors.black54)),
                        TextSpan(text: '\n 5.When you\'re not available press stop.',style: TextStyle(fontSize: 13,color: Colors.black54)),
                        TextSpan(text: '\n 6.The dot above you profile pic indicated your current state.',style: TextStyle(fontSize: 13,color: Colors.black54)),
                        TextSpan(text: '\n 7.If red, you\'re not available to work',style: TextStyle(fontSize: 13,color: Colors.black54)),
                        TextSpan(text: '\n 8.If green, you\'re available to work',style: TextStyle(fontSize: 13,color: Colors.black54)),
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