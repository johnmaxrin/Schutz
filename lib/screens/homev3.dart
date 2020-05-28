import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shutz_ui/widgets/homev3_sub1.dart';
import 'package:shutz_ui/widgets/homwv3_wid_bottom.dart';
import 'package:shutz_ui/widgets/v3_gig_digs.dart';

class home_screenv3 extends StatefulWidget {
  home_screenv3({Key key}) : super(key: key);

  _home_screenv3State createState() => _home_screenv3State();
}

class _home_screenv3State extends State<home_screenv3> {    



  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          elevation: 0.4,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.account_circle),
            onPressed: (){},)
          ],
          title: Text('Schutz',style:TextStyle(fontWeight: FontWeight.w300,fontSize: 25.0)),
        ),
        
        drawer: Drawer(
          
        child: ListView(
          children: <Widget>[
            //////////////////////////////////////////PUT NAME HERE////////////////////////////////////////////////
            SizedBox(height: 20.0),
           
            ListTile(
               onTap: (){},
              leading: new Icon(MdiIcons.nut),
              title: Text('Settings',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w300),),
            ),

            ListTile(
               onTap: () async{
                 
                 Navigator.popAndPushNamed(context, '/mybookings');
               },
              leading: new Icon(MdiIcons.book),
              title: Text('Bookings',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w300),),
            ),

            ListTile(
               onTap: (){
                 Navigator.popAndPushNamed(context, '/myrequests');
               },
              leading: new Icon(MdiIcons.book),
              title: Text('Requests',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w300),),
            ),

            ListTile(
                onTap: (){},
              leading: new Icon(MdiIcons.lockAlert),
              title: Text('Privacy',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w300),),
            ),

            ListTile(
                onTap: (){},
              leading: new Icon(MdiIcons.help),
              title: Text('Help',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w300),),
            ),

            ListTile(
                onTap: (){},
              leading: new Icon(MdiIcons.powerOff),
              title: Text('Logout',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w300),),
            ),

          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: (){
           Dialogues().fabearn(context);

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
                      Icon(MdiIcons.home,size: 30.0,color: Colors.white70,),
                      IconButton(icon:Icon(MdiIcons.axe,size: 30.0,color: Colors.white70),
                      
                      onPressed: () async{
                        Navigator.pushNamed(context, '/loading');
                        QuerySnapshot query = await Firestore.instance.collection('jobs').getDocuments();
                        Navigator.pop(context);
                        Dialogues().gigzero(context,query);
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
                      Icon(MdiIcons.leaf,size: 30.0,color: Colors.white70,),
                      Icon(MdiIcons.nut,size: 30.0,color: Colors.white70,),
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


