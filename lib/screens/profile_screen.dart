import 'package:flutter/material.dart';
import 'package:shutz_ui/Models/user.dart';
import 'package:shutz_ui/widgets/profile_widget.dart';

class profile_screen extends StatefulWidget {
  User cuser;
  profile_screen({Key key,this.cuser}) : super(key: key);

  _profile_screenState createState() => _profile_screenState();
}

class _profile_screenState extends State<profile_screen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       
      body: Container(
        decoration: new BoxDecoration(
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
            
             child: Padding(
               padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8.0),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: <Widget>[
                 Icon(Icons.arrow_back_ios,color:Colors.white,size:30.0),
                 Icon(Icons.settings,color: Colors.white,size: 30.0,)],),
             ),
       ),

       Container(
         height: 200.0,
         width: 200.0,
         decoration: new BoxDecoration(
           shape: BoxShape.circle,
          
           image: DecorationImage(image: NetworkImage(widget.cuser.pic),fit: BoxFit.cover),
           boxShadow: [BoxShadow(
             offset: Offset(2, 3),
             blurRadius: 5.0,
             color: Colors.black54
             
           )]
           
         ),
       ),

       

       Container(
         padding: EdgeInsets.only(top: 8.0),
         child: Text(widget.cuser.name,style: TextStyle(color: Colors.white,fontSize: 30.0,
         shadows: <Shadow>[
           Shadow(
                 blurRadius: 10.0,
                 color: Colors.black54,
                 offset: Offset(1, 1)
         )
       ]
     ),
       )
     ),

    
         
         
         Container(
           child: Stack(
                           children:<Widget>[
                            
                             Container(
             margin: EdgeInsets.only(top: 10.0),
             padding: EdgeInsets.all(2.0),
             height: 25.0,
             width: 100.0,
             
             decoration: new BoxDecoration(
               color: Color(0xff007FFF),
               borderRadius: new BorderRadius.circular(20.0),
               boxShadow: [new BoxShadow(
                 offset: Offset(1, 2),
                 blurRadius: 6.0,
                 color: Colors.black54
               )]
             ),
             child: Center(child: Text('   Beginner',style: TextStyle(color: Colors.white,letterSpacing: 0.5),)),
             
       ),

        Positioned(
          top: 11.0,
          left: 0.0,
          child: Icon(Icons.check_circle,color: Colors.white,)),
                           ] 
           ),
         ),

         
         Text('2',style: TextStyle(color: Colors.white,fontSize: 70.0),),
         Text('Hiring Done',style: TextStyle(color: Colors.white,fontSize: 15.0),),
         profile_wid()

              ]
     
       
        )
      ),
    );
  }
}