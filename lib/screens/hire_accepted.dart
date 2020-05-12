import 'package:flutter/material.dart';

class hire_accepted extends StatefulWidget {
  hire_accepted({Key key}) : super(key: key);

  _hire_acceptedState createState() => _hire_acceptedState();
}

class _hire_acceptedState extends State<hire_accepted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: new BoxDecoration(
          color: Colors.red,
           gradient: LinearGradient(
                                 begin: Alignment.topRight,
                                 end: Alignment.bottomLeft,
                                 stops: [0.2,1],
                                  
                                 colors: [Color(0xffd000ff),Color(0xffe50074)]
                               ),
        ),

        child: Column(
          children: <Widget>[
            SizedBox(height: 50.0,),
            Container(
              height: 50.0,
              padding: EdgeInsets.all(10.0),
              child: Row(children: <Widget>[Icon(Icons.arrow_back_ios,color: Colors.white,size: 30.0,)],),
            ),

            Container(
              height: 230.0,
              width: 230.0,
              decoration: new BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              image: DecorationImage(image: AssetImage('assets/hire_avatar.jpg'),fit: BoxFit.fill),
              boxShadow: [new BoxShadow(blurRadius: 6.0,color: Colors.black54,offset: Offset(0, 3))]
              ),
            ),

           SizedBox(height: 10.0,),

            Text('Mark Zuckerberg',style: TextStyle(
              color: Colors.white,
              fontSize: 28.0
            ),),

           SizedBox(height: 8.0,),

            Container(
              padding: EdgeInsets.all(2.0),
              height: 20.0,
              width: 90.0,
              decoration: new BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                boxShadow: [new BoxShadow(blurRadius: 5.0,offset: Offset(1, 2),color: Colors.black54)],
              ),

              child: Center(child: Text('Accepted',style: TextStyle(fontSize: 12.0,color: Colors.white,letterSpacing: 0.5,fontWeight: FontWeight.w400),)),
            ),

           SizedBox(height: 30.0,),


           Container(
             height: 20.0,
             width: 80.0,
             decoration: new BoxDecoration(
               
               borderRadius: new BorderRadius.all(Radius.circular(5.0)),
               border: Border.all(color: Colors.white)  
               
             ),
           child: Center(
             child: Text('Distance Left',style: TextStyle(
               color: Colors.white,fontSize: 10.0,letterSpacing: 0.3,fontWeight: FontWeight.w600
             ),),
           ),
           ),
           SizedBox(height: 3.0,),
           Text('250m',style: new TextStyle(
             color:Colors.white,
             fontSize: 40.0,
             shadows: [Shadow(blurRadius: 10.0,offset: Offset(0, 3),color: Colors.black54)]
           ),),

           SizedBox(height: 30.0,),
           Container(
             padding: EdgeInsets.all(5.0),
             
             height: 80.0,
             width: 300.0,
             
              
             child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: <Widget>[
               
               Container(
                 height: 65.0,
                 width: 65.0,
                 decoration: new BoxDecoration(
                   shape: BoxShape.circle,
                   color: Colors.white,
                   boxShadow: [new BoxShadow(blurRadius: 6.0,offset: Offset(0, 3),color: Colors.black54)]
                 ),

                 child: Icon(Icons.call,size:30.0),
               ),

               Container(
                 height: 65.0,
                 width: 65.0,
                 decoration: new BoxDecoration(
                   shape: BoxShape.circle,
                   color: Colors.white,
                   boxShadow: [new BoxShadow(blurRadius: 6.0,offset: Offset(0, 3),color: Colors.black54)]
                 ),

                 child: Icon(Icons.scanner,size:30.0),
               ),

               Container(
                 height: 65.0,
                 width: 65.0,
                 decoration: new BoxDecoration(
                   shape: BoxShape.circle,
                   color: Colors.white,
                   boxShadow: [new BoxShadow(blurRadius: 6.0,offset: Offset(0, 3),color: Colors.black54)]
                 ),

                 child: Icon(Icons.location_on,size:30.0),
               ),
             ],),
           )

          ],
        ),
      ),
    );
  }
}