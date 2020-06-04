import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shutz_ui/services/auth.dart';
import 'package:shutz_ui/services/dbserv.dart';
import 'package:shutz_ui/widgets/homev3_sub1.dart';
import 'package:shutz_ui/widgets/homwv3_wid_bottom.dart';
import 'package:shutz_ui/widgets/notifications.dart';
import 'package:shutz_ui/widgets/v3_gig_digs.dart';

import 'bookingreq.dart';

class home_screenv3 extends StatefulWidget {
  home_screenv3({Key key}) : super(key: key);

  _home_screenv3State createState() => _home_screenv3State();
}

class _home_screenv3State extends State<home_screenv3> {    
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
    String token;
    int checkvar = 0;
    int checkvar1 = 0;
    int checkvar2 = 0;
    FirebaseUser currentuser;
    DocumentSnapshot snapshot;

    _savetoken() async{
    currentuser = await FirebaseAuth.instance.currentUser(); 
    token = await _firebaseMessaging.getToken();
    snapshot = await Firestore.instance.collection('users').document(currentuser.uid).get(); 
    
      print(token);
      DbServ().addtouser(currentuser.uid, token, 'token');
}

@override
  void initState()  {
    // TODO: implement initState
    super.initState();
    
    _firebaseMessaging.configure(


         onMessage: (Map<String,dynamic> message)async{
              
               {print(message);

                showDialog(
                  context: context,
                  builder: (context){
                    return AlertDialog(
                          
                          actionsOverflowDirection: VerticalDirection.up,
                          title:  Text( message['notification']['title'],style: TextStyle(fontFamily: 'poppins',fontSize: 23),textAlign: TextAlign.center,),
                          content: Text(message['notification']['body'],style: TextStyle(fontWeight: FontWeight.w300,fontSize: 19),),
                          actions: <Widget>[
                            
                            RaisedButton(
                              
                              color: Colors.blueAccent,
                              onPressed: ()=>Navigator.pop(context),
                              child: Text('OK'),
                            )
                          ],
            
          
                    );
                    
                  }
                );
               
               }
              
            
            
            },


      onLaunch: (Map<String, dynamic> message) async {
           print(message);
         
       { print("onLaunch: ${message['data']['route']}");
       Navigator.pushNamed(context, message['data']['route']);
     }
        

        
      },
      onResume: (Map<String, dynamic> message) async {
           print(message);
      
       print("onResume: ${message['data']['route']}");
       Navigator.pushNamed(context, message['data']['route']);
         }

        
      
    );

    _savetoken();
  }

void updateloc() async
{
FirebaseUser z1 = await FirebaseAuth.instance.currentUser();
    setState(() {
    currentuser = z1;
    DbServ().updateloc(currentuser.uid);  
    });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          elevation: 0.5,
          backgroundColor: Colors.blueAccent,
          
          title: Container(height: 30, decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/work.png'))),),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.email,color: Colors.white,),
            onPressed: (){},)
          ],
          
          leading: Builder(
                      builder:(ctx)=> IconButton(
                          icon: Icon(Icons.menu,color: Colors.white,),
                          onPressed: () => Scaffold.of(ctx).openDrawer(),
                                ),
          ),
        ),
        
        drawer: Drawer(
          
        child: ListView(
          children: <Widget>[
            //////////////////////////////////////////PUT NAME HERE////////////////////////////////////////////////
            SizedBox(height: 30.0),

            ListTile(
               onTap: () async{
                 
                 Navigator.popAndPushNamed(context, '/mybookings');
               },
              leading: new Icon(MdiIcons.book),
              title: Text('Bookings',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w300),),
            ),


            ListTile(
                onTap: (){Navigator.popAndPushNamed(context, '/privacypage');},
              leading: new Icon(MdiIcons.lockAlert),
              title: Text('Privacy',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w300),),
            ),

            ListTile(
                onTap: (){Navigator.popAndPushNamed(context, '/helpscreen');},
              leading: new Icon(MdiIcons.help),
              title: Text('Help',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w300),),
            ),

            ListTile(
                onTap: (){AuthServ().signOutGoogle();},
              leading: new Icon(MdiIcons.powerOff),
              title: Text('Logout',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w300),),
            ),

          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: ()async{
          updateloc();
          FirebaseUser user =await FirebaseAuth.instance.currentUser();
          print(user.displayName);
          bool a = await DbServ(uid: user.uid).checkphone();
          if(a==true)
           Dialogues().fabearn(context);
          else
           Navigator.pushNamed(context, '/phoneconst',arguments: user);
          


        },
        tooltip: 'Work',
        child: Icon(MdiIcons.currencyInr,size: 25.0,),
        elevation: 3.0,
      ),

      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: Colors.blueAccent,
        notchMargin: 6.0,
        clipBehavior: Clip.antiAlias,
        child:
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                
                Container(
                  height: 60.0,
                  width: MediaQuery.of(context).size.width * 0.43,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Icon(MdiIcons.home,size: 30.0,color: Colors.white,),
                      IconButton(icon:Icon(Icons.search,size: 30.0,color: Colors.white70),
                      
                      onPressed: () async{
                        FirebaseUser user =await FirebaseAuth.instance.currentUser();
                        print(user.displayName);
                        bool a = await DbServ(uid: user.uid).checkphone();
                        if(a==true){
                        Navigator.pushNamed(context, '/loading');
                        QuerySnapshot query = await Firestore.instance.collection('jobs').getDocuments();
                        Navigator.pop(context);
                        Dialogues().gigzero(context,query);
                        }
                        else
                          Navigator.pushNamed(context, '/phoneconst',arguments: user);
                        

                       

                        
                      },),
                    ],
                  )
                ),

                Container(
                  height: 60.0,
                  width: MediaQuery.of(context).size.width * 0.43,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      IconButton(icon:Icon(MdiIcons.leaf,size: 30.0,color: Colors.white70,),
                      onPressed: (){Notificationpre().showflush(context, 'Currently not available in your city.');},
                      ),
                      Builder(
                      builder:(ctx)=> IconButton(
                          icon: Icon(MdiIcons.nut,color: Colors.white70,size: 30,),
                          onPressed: () => Scaffold.of(ctx).openDrawer(),
                                ),
          ),
                    ],
                  )
                ),
                
                ])),



                ///////////////////BODY/////////////////////
                ///                                      ///
                ///                                      ///
                ///----------------BODY------------------///
                
                body: 
                SafeArea(
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: <Widget>[

                   Container(
                     padding: EdgeInsets.only(left: 10,top: 10.0),
                     child: Text('Hire from nearby',style: TextStyle(color: Colors.black45,fontWeight: FontWeight.w500),),
                   ),

                   Container(
                     padding: EdgeInsets.only(left: 10),
                     child: Text('Dawn of the planet of gig',style: TextStyle(color: Colors.black54,fontWeight: FontWeight.w300,fontSize: MediaQuery.of(context).size.width*0.06),),
                   ),

                   /////// CARDS ////////
                   ///
                   homev3_sub_wid(),

                   Container(
                     padding: EdgeInsets.only(left: 10,top: 30.0),
                     child: Text('Sharing is caring',style: TextStyle(color: Colors.black45,fontWeight: FontWeight.w500),),
                   ),

                   Container(
                     padding: EdgeInsets.only(left: 10,bottom: 10.0),
                     child: Text('What are you looking for?',style: TextStyle(color: Colors.black54,fontWeight: FontWeight.w300,fontSize: MediaQuery.of(context).size.width*0.06),),
                   ),
////////////////////////////// BOTTOM WID////////////////////
                   
                   bottom_stream(),
                   
                 ],
               ),
                )
            );


    }
}


