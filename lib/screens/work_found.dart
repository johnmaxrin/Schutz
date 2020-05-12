import 'package:flutter/material.dart';
import 'package:shutz_ui/services/const.dart';

class work_found extends StatefulWidget {
  work_found({Key key}) : super(key: key);

  _work_foundState createState() => _work_foundState();
}

class _work_foundState extends State<work_found> {
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
            SizedBox(height: 30.0,),
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

              child: Center(child: Text('For Driver',style: TextStyle(fontSize: 12.0,color: Colors.white,letterSpacing: 0.5,fontWeight: FontWeight.w400),)),
            ),

           SizedBox(height: 10.0,),

           Container(
            height:60.0,
            child: Text('\" I need a Driver to get to Market! It\'s urgent\"',style: TextStyle(color: Colors.white),)),


           Container(
             height: 20.0,
             width: 80.0,
             decoration: new BoxDecoration(
               
               borderRadius: new BorderRadius.all(Radius.circular(5.0)),
               border: Border.all(color: Colors.white)  
               
             ),
           child: Center(
             child: Text('Expires in',style: TextStyle(
               color: Colors.white,fontSize: 10.0,letterSpacing: 0.3,fontWeight: FontWeight.w600
             ),),
           ),
           ),
           SizedBox(height: 3.0,),
           Text('05:16',style: new TextStyle(
             color:Colors.white,
             fontSize: 40.0,
             shadows: [Shadow(blurRadius: 10.0,offset: Offset(0, 3),color: Colors.black54)]
           ),),

           SizedBox(height: 30.0,),
           Container(
             //padding: EdgeInsets.all(5.0),
             
             height: 80.0,
             width: 250.0,
             
              
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

                 child: Icon(Icons.close,size:40.0,color: Colors.red,),
               ),

               GestureDetector(

                 onTap: ()=>Navigator.popAndPushNamed(context, otproute),
                                child: Container(
                   height: 65.0,
                   width: 65.0,
                   decoration: new BoxDecoration(
                     shape: BoxShape.circle,
                     color: Colors.white,
                     boxShadow: [new BoxShadow(blurRadius: 6.0,offset: Offset(0, 3),color: Colors.black54)]
                   ),

                   child: Icon(Icons.done,size:40.0,color: Colors.green,),
                 ),
               ),

             
             ],),
           )

          ],
        ),
      ),
    );
  }
}