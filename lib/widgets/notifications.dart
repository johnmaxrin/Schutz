
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:shutz_ui/services/dbserv.dart';
import 'package:shutz_ui/widgets/searchresdialogue.dart';



class Booking{


  Future<bool> bookingnotif(context,message) async
  {
    
    DocumentSnapshot client = await DbServ().getuser(message['data']['clientid']);
    DocumentSnapshot worker = await DbServ().getuser(message['data']['workerid']);
  

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
                  children: <Widget>[
                    Center(
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 20.0),
              height: 100.0,
              width: 100.0,
              decoration: new BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              image: DecorationImage(image: NetworkImage(client.data['pic'].toString()),fit: BoxFit.fill),
              boxShadow: [new BoxShadow(blurRadius: 6.0,color: Colors.black54,offset: Offset(0, 3))]
              ),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.close,color: Colors.red,size: 30.0,),
                          onPressed: (){Navigator.pop(context);},
                        )
                      ],
                    )
                  ],
                ),

                Container(
                  padding: EdgeInsets.all(8.0),
                  child: Text(client.data['name'].toString().toUpperCase(),style: TextStyle(fontSize: 25.0,),
                )),



                Container(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      
                          GestureDetector(
                            onTap: (){
                            locationmap(context,client.data['loc']['geopoint']);
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
                        child: Icon(Icons.phone,color: Colors.green[300],)),

                        Container(
                        height: 50.0,
                        width: 50.0,
                        decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.white,boxShadow: [BoxShadow(blurRadius: 2.0,offset: Offset(1, 1),color: Colors.black38)]),
                        child: Icon(Icons.close,color: Colors.redAccent,)),
                      
                    ],
                  ),
                ),
                       
               Container(
                 height: 80.0,
                 child: RichText(
                   textAlign: TextAlign.center,
                   text: TextSpan(
                     
                     style: TextStyle(color: Colors.black),
                     text: 'Needs a \n',
                     children: <TextSpan>[
                       TextSpan(text: message['data']['job_title'].toString().toUpperCase(),style: TextStyle(fontWeight: FontWeight.w400,fontSize: 40.0,color: Colors.black87)),
                       
                     ]
                   ),
                 ),

               ),


                Expanded(
                                  child: Container(
                    
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.0),bottomRight: Radius.circular(20.0))
                    ),
                    child: GestureDetector(
                        onTap: (){
                         DbServ().updatestatus('accepted', message['data']['uid']).whenComplete(()=>Navigator.pop(context));
                        },
                        child: Container(
                          child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
  
                                  Text('ACCEPT',style: TextStyle(color: Colors.white,fontSize: 25.0,fontWeight: FontWeight.w300),)
                          ],
                      ),
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

/////////////////////////////////////////////AccEPTED///////////////////////////////////////////////////////

  
  Future<bool> bookingaccept(context,message) async
  {
    
    DocumentSnapshot client = await DbServ().getuser(message['data']['clientid']);
    DocumentSnapshot worker = await DbServ().getuser(message['data']['workerid']);
  

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
               Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[IconButton(icon:Icon(Icons.close,color:Colors.red),onPressed: (){Navigator.pop(context);},),],),
               Container(
                 height: 210.0,
                 child: Image.asset('assets/hurraykoch.png',fit: BoxFit.contain,)),

                // Container(
                //   padding: EdgeInsets.all(8.0),
                //   child: Text(worker.data['name'].toString().toUpperCase(),style: TextStyle(fontSize: 25.0,),
                // )),



               
                       
               Container(
                 height: 80.0,
                 child: RichText(
                   textAlign: TextAlign.center,
                   text: TextSpan(
                     
                     style: TextStyle(color: Colors.black),
                     text: 'Your Booking is \n',
                     children: <TextSpan>[
                       TextSpan(text: 'ACCEPTED',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 40.0,color: Colors.black87)),
                       
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
                         Navigator.popAndPushNamed(context, '/mybookings',arguments:client.data['uid']);
                        },
                        child: Container(
                          child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
  
                                  Text('MANAGE HERE',style: TextStyle(color: Colors.white,fontSize: 25.0,fontWeight: FontWeight.w400),)
                          ],
                      ),
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


 

}

class Notificationpre
{
  Widget showflush(context,msg)
  {
    return  Flushbar(
                  margin: EdgeInsets.all(5.0),
                  borderRadius: 5.0,
                  message: msg,
                  duration: Duration(seconds: 4),
                  icon: Icon(Icons.info_outline,color:Colors.blueAccent),
                  
                  )..show(context);
  }

}
