import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:shutz_ui/Models/user.dart';
import 'package:shutz_ui/screens/success.dart';
import 'package:shutz_ui/services/dbserv.dart';
import 'package:url_launcher/url_launcher.dart';


 
Future<bool> workersearchdig(context,QuerySnapshot snapshot,User user)
{
  print(snapshot.documents[0].data);
  final int wridx = Random().nextInt(snapshot.documents.length);
 
    return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context)
    {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Container(
            height: 400.0,
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
              image: DecorationImage(image: NetworkImage(snapshot.documents[wridx].data['pic'].toString()),fit: BoxFit.fill),
              boxShadow: [new BoxShadow(blurRadius: 6.0,color: Colors.black54,offset: Offset(0, 3))]
              ),
                ),

                Container(
                  padding: EdgeInsets.all(8.0),
                  child: Text(snapshot.documents[wridx].data['name'].toString().toUpperCase(),style: TextStyle(fontSize: 25.0,),
                )),



                Container(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      
                          GestureDetector(
                            onTap: (){
                              locationmap(context,snapshot.documents[wridx].data['loc']['geopoint']);
                            },
                            child: Container(
                            height: 50.0,
                            width: 50.0,
                            decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.white,boxShadow: [BoxShadow(blurRadius: 2.0,offset: Offset(1, 1),color: Colors.black38)]),
                            child: Icon(Icons.location_on,color: Colors.redAccent,)),
                          ),
                    

                        Container(
                        height: 50.0,
                        width: 50.0,
                        decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.white,boxShadow: [BoxShadow(blurRadius: 2.0,offset: Offset(1, 1),color: Colors.black38)]),
                        child: IconButton(icon:Icon(Icons.phone,color: Colors.green[300],),onPressed: (){
                          // LAUNCH PHONE HERE //



                        },)),

                        Container(
                        height: 50.0,
                        width: 50.0,
                        decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.white,boxShadow: [BoxShadow(blurRadius: 2.0,offset: Offset(1, 1),color: Colors.black38)]),
                        child: Icon(Icons.close,color: Colors.redAccent,)),
                      
                    ],
                  ),
                ),
                       
               Container(
                 child: RichText(
                   textAlign: TextAlign.center,
                   text: TextSpan(
                     
                     style: TextStyle(color: Colors.black),
                     text: 'Works Done \n',
                     children: <TextSpan>[
                       TextSpan(text: snapshot.documents[wridx].data['works_completed'],style: TextStyle(fontWeight: FontWeight.w400,fontSize: 60.0,)),
                       
                     ]
                   ),
                 ),

               ),


                Expanded(
                                  child: Container(
                    
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.0),bottomRight: Radius.circular(20.0))
                    ),
                    child: GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, '/loading');
                          DbServ().addbookin(user.uid, snapshot.documents[wridx].data['uid'], snapshot.documents[0].data['job_title'])
                          .whenComplete((){
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Success().successdig(context, 'Booking Done',1);
                            });
                            
                        },
                        child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
  
                                Text('BOOK',style: TextStyle(color: Colors.white,fontSize: 20.0),)
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


Future<bool> locationmap(context,geopoint) async
{

    // print(snapshot.documents[0].data['loc']['geopoint']);
    GeoPoint pos=geopoint;

   List<Marker> _marker=[];
   Marker marker=Marker(point: LatLng(pos.latitude,pos.longitude),builder: (ctx){return Icon(Icons.location_on,color: Colors.blueAccent,size: 30.0,);});

    _marker.clear();
    _marker.add(marker);
    
    
    return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context)
    {
      return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
              child: Container(
                height: 400.0,
                width: 300.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0)
                ),

                child: Column(
                  children: <Widget>[
                    Stack(
                                          children:<Widget>[
                                             Container(
                                              height: 340,
                                              decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0),topRight: Radius.circular(20.0))
                                              ),
                                              child: FlutterMap(
                                                
                                                options: new MapOptions(
                                                  center: new LatLng(pos.latitude,pos.longitude),
                                                  minZoom: 15.0,),
                                                 

                                              layers: [
                                                new TileLayerOptions(
                                                  urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                                  subdomains: ['a','b','c']
                                                  
                                                ),

                                                MarkerLayerOptions(
                                                  markers:_marker
                                                )
                                                
                                              ],

                                                  
                                                ),

                                              

                                                
                                              ),
                                          

                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: <Widget>[
                                                  IconButton(
                                                    onPressed: ()=>Navigator.pop(context),
                                                    icon:Icon(Icons.close,color: Colors.red,size: 30.0,))
                                                ],
                                              ),
                                            ),
                                           
                                          ]
                    ),

                    Expanded(
                      child: GestureDetector(
                        onTap: () 
                          async{
                        String googlemap = 'https://www.google.com/maps/search/?api=1&query=${pos.latitude},${pos.longitude}';
                        if(await canLaunch(googlemap))
                        {
                          await launch(googlemap);
                        }
                        else
                        {
                          throw 'Error!!';
                        } 
                      
                        },
                                              child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                            color: Colors.blueAccent,
                            
                          ),
                          child: Center(child: Text('OPEN IN MAPS',style: TextStyle(fontSize: 20.0,color: Colors.white),)),
                        ),
                      ),
                      )
                  ],
                ),
              )
      );
    });
}