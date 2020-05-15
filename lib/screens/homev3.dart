import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shutz_ui/widgets/homev3_sub1.dart';
import 'package:shutz_ui/widgets/homwv3_wid_bottom.dart';

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
            DrawerHeader(child: Center(child: Text('ROBERT K SAMUEL',style: TextStyle(fontFamily: 'poppins',fontSize: 30.0,color: Colors.white),)),decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.indigo,Colors.blueAccent],stops: [0.2,1]),)),
           
            ListTile(
               onTap: (){},
              leading: new Icon(MdiIcons.nut),
              title: Text('Settings',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w300),),
            ),

            ListTile(
               onTap: (){},
              leading: new Icon(MdiIcons.book),
              title: Text('Bookings',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w300),),
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
        onPressed: (){print('Pressed');},
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
                      Icon(MdiIcons.axe,size: 30.0,color: Colors.white70,),
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