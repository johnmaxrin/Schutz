import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:location/location.dart';
import 'package:shutz_ui/screens/success.dart';
import 'package:shutz_ui/widgets/worker_bottmonwid.dart';


 
Future<bool> workersearchdig(context,user) async
{
  final CollectionReference userref = Firestore.instance.collection('users');
  int selectedinx=-1;
  QuerySnapshot joblist = await Firestore.instance.collection('home_job').getDocuments();
  DocumentSnapshot snapshot=await userref.document(user.uid).get().whenComplete(()=>Navigator.pop(context));

  if(snapshot.data['status']!='Available')
  {

      return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context)
    {
      return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
              child: Container(
                height: 430.0,
                width: 300.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0)
                ),

                child: Column(
                  children: <Widget>[
                    
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20.0),
                  height: 100.0,
                  width: 100.0,
                  decoration: new BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  image: DecorationImage(image: NetworkImage(user.pic),fit: BoxFit.fill),
                  boxShadow: [new BoxShadow(blurRadius: 6.0,color: Colors.black54,offset: Offset(0, 3))]
                  ),
                    ),

                    Container(
                     
                      child: Text(user.name.toUpperCase(),style: TextStyle(fontSize: 25.0,),
                    )),




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
                        blurRadius: 2.0,
                        color: Colors.black54
                      )]
                    ),
                    child: Center(child: Text('   Level 1',style: TextStyle(color: Colors.white,letterSpacing: 0.5),)),
                    
              ),

               Positioned(
                 top: 11.0,
                 left: 0.0,
                 child: Icon(Icons.check_circle,color: Colors.white,)),
                                  ] 
                  ),
                ),



                   worker_bottonwid(joblist: joblist,selectedinx:(a){selectedinx=a;},),
                           
                   Container(
                     padding: EdgeInsets.all(12.0),
                     child: RichText(
                       textAlign: TextAlign.center,
                       text: TextSpan(
                         
                         style: TextStyle(color: Colors.black,fontSize: 60.0,fontWeight: FontWeight.w400,height: 0.7),
                         text: snapshot.data['works_completed']==null?'0':snapshot.data['works_completed'],
                         children: <TextSpan>[
                           TextSpan(text: '\nWorks Done',style: TextStyle(fontSize: 13,)),
                           
                         ]
                       ),
                     ),

                   ),


                    Expanded(
                                      child: GestureDetector(
                                        onTap: () async {
                                          if(selectedinx==-1){
                                         
                                         Flushbar(
                                           margin: EdgeInsets.all(10.0),
                                           borderRadius: 10.0,
                                           duration: Duration(seconds: 5),
                                           backgroundColor: Colors.black87,
                                           message: 'Please select a skill from above to continue',
                                           icon: Icon(Icons.info_outline,color:Colors.blueAccent,size:30.0),
                                           forwardAnimationCurve: Curves.fastOutSlowIn,
                                           reverseAnimationCurve: Curves.fastOutSlowIn,
                                         )..show(context);
                                          }
                                          else{
                                             print('Taped!!');
                                              Navigator.pushNamed(context, '/loading');
                                              Location loc = new Location();
                                              Geoflutterfire geo = Geoflutterfire();
                                              var pos = await loc.getLocation();
                                              GeoFirePoint point = geo.point(latitude: pos.latitude,longitude: pos.longitude);
                                             
                                             userref.document(snapshot.data['uid']).updateData(
                                               {
                                                 'job_title':joblist.documents[selectedinx].data['title'],
                                                 'status':'Available',
                                                 'loc': point.data
                                               }
                                             ).whenComplete((){
                                               Navigator.pop(context);
                                               Navigator.pop(context);
                                               Success().successdig(context, 'All Set',1);});
                                             
                                             
                                          }

                                        },
                                    child: Container(
                                          
                        
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.0),bottomRight: Radius.circular(20.0))
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
  
                                  Text('WORK',style: TextStyle(color: Colors.white,fontSize: 20.0),)
                          ],
                        ),
                      ),
                                      ),
                    ),
                    
                    ],
                ),
              )
          
        
      );
    }
  );
}

else{
  return  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context)
    {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
              child: Container(
                height: 430.0,
                width: 300.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0)
                ),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: 230,
                  
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20.0)),
                    color: Colors.black,//const Color(0xffebf5fb),//Colors.blueAccent,
                    image: DecorationImage(
                      image: AssetImage('assets/patti.png'),
                      fit: BoxFit.fitHeight
                    )
                  ),

                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      IconButton(
                        onPressed: (){Navigator.pop(context);},
                        icon:Icon(Icons.close,size: 30.0,color: Colors.red),)
                    ],
                  ),
                )
              ],
            ),
            
            Container(
              padding: EdgeInsets.all(15.0),
              color: Colors.black,//const Color(0xffebf5fb),
              child: Text('You\'re Online! Wait untill someone finds you. We are woking on Payment options. Will be available in Future ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'poppins',
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.0
              ),),
            ),

            Expanded(
              child: GestureDetector(
                onTap: () async{
                  Navigator.pushNamed(context, '/loading');
                   userref.document(snapshot.data['uid']).updateData(
                                               {
                                                 
                                                 'status':'Not Available',
                                                 
                                               }
                                             ).whenComplete((){
                                               Navigator.pop(context);
                                               Navigator.pop(context);
                                               });
                },
                              child: Container(
                  decoration: new BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight:Radius.circular(20.0) )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text('I\'m not available now',style: TextStyle(fontSize: 20.0,color: Colors.white,fontFamily: 'poppins',fontWeight: FontWeight.w600),),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),

      ));
          
  });
 
}

}