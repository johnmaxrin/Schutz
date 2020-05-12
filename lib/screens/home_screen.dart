import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:shutz_ui/Models/user.dart';
import 'package:shutz_ui/screens/worker_profile.dart';
import 'package:shutz_ui/services/auth.dart';
import 'package:shutz_ui/services/dbserv.dart';
import 'package:shutz_ui/widgets/home_jobselect.dart';
import 'package:shutz_ui/widgets/home_searchbox.dart';
import 'package:shutz_ui/widgets/home_sub.dart';
import 'package:shutz_ui/widgets/home_trending.dart';
import 'package:shutz_ui/widgets/notifications.dart';

class Home extends StatefulWidget {

  User cuser;
  Home({Key key,this.cuser}) : super(key: key);
 
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  
  final FirebaseMessaging _fcm = FirebaseMessaging();
  String token;
  int checkvar = 0;
  @override
  void initState() {
       
        _fcm.configure(
            
          
         onMessage: (Map<String,dynamic> message)async{
              if(checkvar%2==0)
               {print(message);
               if(message['notification']['title']=='Your Request Accepted')
               {print('Accepted!!');Booking().bookingaccept(context,message);}
               else
               Booking().bookingnotif(context,message);}
              ++checkvar;
            
            
            },

          onResume: (Map<String,dynamic> message)async{

            print('Kitti Monne Notification ini ivide anno??');
            Navigator.pushNamed(context, '/myrequests',arguments: widget.cuser.uid);
          },

          onLaunch: (Map<String,dynamic> message)async{
            print('Kitti Monne Notification ooo ivide??');
          },

          
        );

     _savetoken();
    super.initState();

  }

@override
  void setState(fn) async{
    
    
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {

    
    
    return Scaffold(
      resizeToAvoidBottomInset:false,
      floatingActionButton: Container(
        width: 150.0,
        padding: EdgeInsets.only(bottom: 20.0),
        child: FloatingActionButton.extended(
          onPressed: () async{
            Navigator.pushNamed(context, '/loading');
             bool a= await DbServ(uid:widget.cuser.uid).checkphone();
             if(a!=null){
               
               workersearchdig(context, widget.cuser); 
             }
             else{
               Navigator.popAndPushNamed(context, '/phoneconst',arguments: widget.cuser);
             }
              
          },
          backgroundColor: Color(0xff5979EC),
          
          label: Text('Work Here'),
          elevation: 5.0,
          
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      backgroundColor: Colors.white,
          body: CustomScrollView(

            slivers: <Widget>[
              SliverAppBar(
                floating: true,
                pinned: false,
                expandedHeight: 250.0,
                
                leading: IconButton(icon:Icon(Icons.camera_alt,size: 30.0,),onPressed: (){Notificationpre().showflush(context, 'This is a beta version! This feature will be available soon. Keep Supporting us');},),
                actions: <Widget>[IconButton(icon:Container(height:30.0,width:30.0,child: CircleAvatar(backgroundImage: NetworkImage(widget.cuser.pic),)),onPressed: ()=>_showsettings(context)),],//Navigator.pushNamed(context, profileroute,arguments: widget.cuser),),],
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    children: <Widget>[
                      Image.asset('assets/app_home.jpg',fit: BoxFit.cover,),
                      home_search(),
                      home_jobselect(user: widget.cuser,)
                 ],
                )
              ),
            ),

        

           SliverFillRemaining(
             child: new Container(
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.start,
                 children: <Widget>[
                   
                   SizedBox(height: 30.0,),

                   Row(children:<Widget>[
                                           Container(
                       margin: EdgeInsets.fromLTRB(15.0, 0, 0, 0),
                       padding: EdgeInsets.all(8.0),
                       child: Text('Trending',style: TextStyle(fontSize: 12.0),),
                       decoration: new BoxDecoration(
                         border: Border.all(color: Colors.blue),
                         borderRadius: BorderRadius.all(Radius.circular(10.0)),
                         
                       ),
                     ),
                                        ]
                   ),
                   SizedBox(height: 5.0,),
                   home_trending(user: widget.cuser,),

                   SizedBox(height: 30.0,),
                   Row(children:<Widget>[
                                           Container(
                       margin: EdgeInsets.fromLTRB(15.0, 0, 0, 0),
                       padding: EdgeInsets.all(8.0),
                       child: Text('Use Schutz',style: TextStyle(fontSize: 12.0,letterSpacing: 1),),
                       decoration: new BoxDecoration(
                         border: Border.all(color: Colors.blue),
                         borderRadius: BorderRadius.all(Radius.circular(10.0)),
                         
                       ),
                     ),
                                        ]
                   ),

                
                   home_sub(user: widget.cuser),
                   


                 ],
               ),
             ),
           )
              
            ],


            
          ),
          
    );
  }
  _savetoken() async{
   token = await _fcm.getToken();
      print(token);
      DbServ().addtouser(widget.cuser.uid, token, 'token');
}


void _showsettings(context)
  {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc)
      {
        
      return  (
        Container(
          padding: EdgeInsets.all(10.0),
        //color: Colors.red,
        height: MediaQuery.of(context).size.height*0.50,
        child: new Wrap(
          children: <Widget>[
            new ListTile(
              leading: new Icon(Icons.settings),
              title: Text('Settings'),
              onTap: (){},
            ),

            new ListTile(
              leading: new Icon(Icons.monetization_on),
              title: Text('Payment'),
              onTap: (){
               Notificationpre().showflush(context, 'This feature is not yet available! Stay Tuned');
              },
            ),

            new ListTile(
              leading: new Icon(Icons.book),
              title: Text('Bookings'),
              onTap: (){Navigator.popAndPushNamed(context, '/mybookings',arguments: widget.cuser.uid);},
            ),

            new ListTile(
              leading: new Icon(Icons.format_list_numbered_rtl),
              title: Text('Requests'),
              onTap: (){Navigator.popAndPushNamed(context, '/myrequests',arguments: widget.cuser.uid);},
            ),

            new ListTile(
              leading: new Icon(Icons.info),
              title: Text('About'),
              onTap: (){Navigator.popAndPushNamed(context, '/about');},
              
            ),

            new ListTile(
              leading: new Icon(Icons.power_settings_new),
              title: Text('Logout'),
              onTap: (){
                Navigator.pop(context);
                AuthServ().signOutGoogle();},
            ),
          ],
        ),
        ));

      }

      
    );
  } 
}

