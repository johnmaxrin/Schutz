import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shutz_ui/widgets/notifications.dart';
import 'package:url_launcher/url_launcher.dart';

class bookingreqscreen extends StatefulWidget {

 
 
  bookingreqscreen({Key key,}) : super(key: key);

  _bookingreqscreenState createState() => _bookingreqscreenState();
}

class _bookingreqscreenState extends State<bookingreqscreen> {    
  String uid;
  void fetchcurrentuser() async{
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    setState(() {
      uid = user.uid;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchcurrentuser();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection('bookings').where('useruid',isEqualTo:uid).snapshots(),   //where('useruid',isEqualTo: getuid()
      builder: (BuildContext ctx,AsyncSnapshot<QuerySnapshot> snap){
        if(snap.connectionState==ConnectionState.waiting)
        {
          print('Loading');
          return CircularProgressIndicator();
        }

        if(snap.data.documents.length==0)
        {
          return Text('No Bookings!');
        }
        return bookingsshow(data: snap.data.documents,);
      },
    );
  }
}

class bookingsshow extends StatefulWidget {
  List data;
  bookingsshow({this.data, Key key}) : super(key: key);

  _bookingsshowState createState() => _bookingsshowState();
}

class _bookingsshowState extends State<bookingsshow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blueAccent,elevation: 0,leading: IconButton(icon: Icon(Icons.arrow_back,color:Colors.white),onPressed: ()=>Navigator.pop(context),),),
      backgroundColor: Colors.blueAccent,
      body: Column(
        children: <Widget>[
          Text('My Bookings',style: TextStyle(fontSize: 35.0,fontFamily: 'poppins',color: Colors.white),),
          Expanded(
              child: Container(
                decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.only(topLeft: Radius.circular(50.0),topRight: Radius.circular(50))),
                padding: EdgeInsets.only(top: 40),
                margin: EdgeInsets.only(top: 20.0),
          child: ListView.builder(
            itemCount: widget.data.length,
            itemBuilder: (context,index){
            return Slidable(
              actionPane: SlidableDrawerActionPane(),
              actionExtentRatio: 0.17,
              
                          child: Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [BoxShadow(blurRadius: 5.0,offset: Offset(0, 0),color: Colors.black12)]
                ),
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                margin: EdgeInsets.only(top:20.0,left: 30.0,right: 30.0),
                child: Row(
                  
                  children: <Widget>[
                    Container(height: 70,width: 70,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      
                      borderRadius: BorderRadius.circular(20.0),
                      image: DecorationImage(image: NetworkImage(widget.data[index]['workerpic']))
                    ),
                    ),

                    Container(
                      width: MediaQuery.of(context).size.height*0.3,
                      margin: EdgeInsets.only(top: 20,left: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            
                             child: RichText(overflow: TextOverflow.ellipsis, text:TextSpan(
                              
                             text: widget.data[index]['workername'],style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.031,color: Colors.black54,fontWeight: FontWeight.w300),
                             ) )
                             
                             ),
                          Text( widget.data[index]['jobname'],style: TextStyle(fontFamily: 'poppins', fontSize: MediaQuery.of(context).size.height*0.021,color: Colors.black54,fontWeight: FontWeight.w700),),
                          Text( widget.data[index]['createdat'],style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.021,color: Colors.indigo,fontWeight: FontWeight.w400,),),
                        ],
                      ),
                    ),

                    widget.data[index]['status']=='accepted'?Icon(Icons.done,color:Colors.blueAccent):
                    widget.data[index]['status']=='waiting'?Icon(MdiIcons.watch,color:Colors.red): 
                    widget.data[index]['status']=='rejected'?Icon(MdiIcons.close,color:Colors.red):Icon(Icons.done_all,color:Colors.blue)
                  ],
                ),
              ),


              ////////ACTION BAR//////////////
              ///
              
              actions: <Widget>[
                      SlideAction(
                        color: Colors.white,
                        child: Container(
                           padding: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(color: Colors.white),
                          child: Container(
                    
                          decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10.0)),
                          child: IconButton(icon: Icon(Icons.delete,size: 30,color: Colors.white,),onPressed: ()async{
                            if(widget.data[index]['status']=='waiting'||widget.data[index]['status']=='rejected')
                            {
                              showDialog(context: context,builder: (context){
                              return AlertDialog(
                                titlePadding: EdgeInsets.only(left: 20,right: 20,top: 20),
                                contentPadding: EdgeInsets.only(left: 20,right: 20,top: 3),
                                content: Text('Once deleted it\'s gone for ever. Do it before the worker accepts your request.',style: TextStyle(fontWeight: FontWeight.w300,fontSize: 15),),
                                title: Text('Are you sure to Delete?',style: TextStyle(fontWeight: FontWeight.w300,fontSize: 20),),
                                actions: <Widget>[
                                  RaisedButton(
                                    color: Colors.blueAccent,
                                    onPressed: ()async{

                                      Navigator.pushNamed(context, '/loading');
                                       await Firestore.instance.collection('bookings').document(widget.data[index].documentID).delete().whenComplete((){Navigator.pop(context);Navigator.pop(context); 
                                       Notificationpre().showflush(context, 'Deleted Successfully!');});
                           
                                    },
                                    child: Text('Yes'),
                                  ),


                                   RaisedButton(
                                     color: Colors.red,
                                    onPressed: ()async{
                                        Navigator.pop(context);
                                    },
                                    child: Text('No'),
                                  ),


                                ],
                              );
                            });
                              
                            }
                            
                            else{Notificationpre().showflush(context, 'You cannot delete this booking as the worker accepted your request!');}


                          },),),
                        ),
                        
                      ),

                      
                    ],

                secondaryActions: <Widget>[
                     SlideAction(
                       
                        color: Colors.white,
                        child: GestureDetector(
                              child: Container(
                             padding: EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(color: Colors.white),
                            child: Container(
                            
                            decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10.0)),
                            child: IconButton(icon: Icon(Icons.location_on,size: 30,color: Colors.white,),onPressed: () async{

                                 GeoPoint pos = widget.data[index]['workerloc'];
                          String googlemap = 'https://www.google.com/maps/search/?api=1&query=${pos.latitude},${pos.longitude}';
                        if(await canLaunch(googlemap))
                        {
                          await launch(googlemap);
                        }
                        else
                        {
                          throw 'Error!!';
                        } 

                            },),),
                          ),
                        ), 
                      ),

                      SlideAction(
                        color: Colors.white,
                        child: Container(
                           padding: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(color: Colors.white),
                          child: Container(
                       
                          decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10.0)),
                          child: IconButton(icon: Icon(Icons.call,size: 30,color: Colors.white,),onPressed: () async{

                               if(await canLaunch('tel:${widget.data[index]['workerphone']}'))
                          {
                              launch('tel:${widget.data[index]['workerphone']}');
                          }

                          else{
                            print('Something Went Wring');
                          }

                          },),),
                        ), 
                      ),

                      SlideAction(
                        color: Colors.white,
                        child: Container(
                           padding: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(color: Colors.white),
                          child: Container(
                       
                          decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(10.0)),
                          child: IconButton(

                            onPressed: (){
                              if(widget.data[index]['status']=='waiting')
                            Notificationpre().showflush(context, 'Worker has not accepted your request yet');

                              else if( widget.data[index]['status']=='accepted' && widget.data[index]['startverified']==false)
                              {
                                showDialog<bool>(
                                      context: context,
                                      builder: (context) {
                                        return CupertinoAlertDialog(
                                          title: Text('Arrival OTP is ${widget.data[index]['code1']}',style: TextStyle(fontWeight: FontWeight.w300,fontSize: 23),),
                                          content: Card(
                                            color: Colors.transparent,
                                            elevation: 1.0,
                                          ),
                                        );
                                      },
                                    );
                              }


                              else if(widget.data[index]['status']=='accepted' && widget.data[index]['startverified']==true)
                              {       
                                      final startTime = widget.data[index]['startedat'].toDate();
                                      
                                      final currentTime = DateTime.now();
                                      final diff_mn = currentTime.difference(startTime).inMinutes;
                                      showDialog<bool>(
                                      context: context,
                                      builder: (context) {
                                        return CupertinoAlertDialog(
                                          title: Text('Jobend OPT is ${widget.data[index]['code2']}',style: TextStyle(fontWeight: FontWeight.w300,fontSize: 23),),
                                          content:  Text('$diff_mn Minutes',style: TextStyle(color: Colors.green,fontSize: 25,fontWeight: FontWeight.w300),)
                                        );
                                      },
                                    );
                              }
                            },
                            icon: widget.data[index]['status']=='accepted' && widget.data[index]['startverified']==false?Text('1',style:TextStyle(fontSize:30,color:Colors.white)):
                                  widget.data[index]['status']=='accepted' && widget.data[index]['startverified']==true?Text('2',style:TextStyle(fontSize:30,color:Colors.white)):
                                  widget.data[index]['status']=='completed'?Icon(Icons.done_all,size: 30,color: Colors.white,):
                                  Icon(Icons.verified_user,size: 30,color: Colors.black45,)
                            
                          )
                          ),
                        ), 
                      ),
                ],



            );
            },
          ),
        ),
          ),
        ],
      ),
    );
  }
}


///////////////////////////////////////////REQUEST////////////////////////////////////////////////////////////////////////////////////////////////////
///
///
///
///

class myrequestbuilder extends StatefulWidget {
  myrequestbuilder({Key key}) : super(key: key);

  _myrequestbuilderState createState() => _myrequestbuilderState();
}

class _myrequestbuilderState extends State<myrequestbuilder> {
    String uid;
  void fetchcurrentuser() async{
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    setState(() {
      uid = user.uid;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchcurrentuser();
  }
  @override
  Widget build(BuildContext context) {    
    return StreamBuilder(
      stream: Firestore.instance.collection('bookings').where('workeruid',isEqualTo:uid).snapshots(),   //where('useruid',isEqualTo: getuid()
      builder: (BuildContext ctx,AsyncSnapshot<QuerySnapshot> snap2){
        if(snap2.connectionState==ConnectionState.waiting)
        {
          print('Loading');
          return CircularProgressIndicator();
        }

        if(snap2.data.documents.length==0)
        {
          return Text('No Requests!');
        }

         
        return myrequestlist(data2: snap2.data.documents,);
      },
    );
  }
}

class myrequestlist extends StatefulWidget {

  List data2;
  myrequestlist({this.data2, Key key}) : super(key: key);

  _myrequestlistState createState() => _myrequestlistState();
}

class _myrequestlistState extends State<myrequestlist> {

  final arrivalotpcontroller = TextEditingController();
  final endotpcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
  return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blueAccent,elevation: 0,leading: IconButton(icon: Icon(Icons.arrow_back,color:Colors.white),onPressed: ()=>Navigator.pop(context),),),
      backgroundColor: Colors.blueAccent,
      body: Column(
        children: <Widget>[
          Text('My Requests',style: TextStyle(fontSize: 35.0,fontFamily: 'poppins',color: Colors.white),),
          Expanded(
              child: Container(
                decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.only(topLeft: Radius.circular(50.0),topRight: Radius.circular(50))),
                padding: EdgeInsets.only(top: 40),
                margin: EdgeInsets.only(top: 20.0),
          child: ListView.builder(
            itemCount: widget.data2.length,
            itemBuilder: (context,index){
            return Slidable(
              actionPane: SlidableDrawerActionPane(),
              actionExtentRatio: 0.17,
              
                          child: Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [BoxShadow(blurRadius: 5.0,offset: Offset(0, 0),color: Colors.black12)]
                ),
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                margin: EdgeInsets.only(top:20.0,left: 30.0,right: 30.0),
                child: Row(
                  
                  children: <Widget>[
                    Container(height: 70,width: 70,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      
                      borderRadius: BorderRadius.circular(20.0),
                      image: DecorationImage(image: NetworkImage(widget.data2[index]['workerpic']))
                    ),
                    ),

                    Container(
                      width: MediaQuery.of(context).size.height*0.3,
                      margin: EdgeInsets.only(top: 20,left: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            
                             child: RichText(overflow: TextOverflow.ellipsis, text:TextSpan(
                              
                             text: widget.data2[index]['workername'],style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.031,color: Colors.black54,fontWeight: FontWeight.w300),
                             ) )
                             
                             ),
                          Text( widget.data2[index]['jobname'],style: TextStyle(fontFamily: 'poppins', fontSize: MediaQuery.of(context).size.height*0.021,color: Colors.black54,fontWeight: FontWeight.w700),),
                          Text( widget.data2[index]['createdat'],style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.021,color: Colors.indigo,fontWeight: FontWeight.w400,),),
                        ],
                      ),
                    ),

                    widget.data2[index]['status']=='accepted'?Icon(Icons.done,color:Colors.blueAccent):
                    widget.data2[index]['status']=='waiting'?Icon(MdiIcons.watch,color:Colors.red): 
                    widget.data2[index]['status']=='rejected'?Icon(MdiIcons.close,color:Colors.red):Icon(Icons.done_all,color:Colors.blue)
                  ],
                ),
              ),


              ////////ACTION BAR//////////////
              ///
              
              actions: <Widget>[
                      SlideAction(
                        color: Colors.white,
                        child: Container(
                           padding: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(color: Colors.white),
                          child: Container(
                    
                          decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10.0)),
                          child: IconButton(icon: Icon(Icons.close,size: 30,color: Colors.white,),onPressed: ()async{
                            if(widget.data2[index]['status']=='accepted')
                            {
                              showDialog(context: context,builder: (context){
                              return AlertDialog(
                                titlePadding: EdgeInsets.only(left: 20,right: 20,top: 20),
                                contentPadding: EdgeInsets.only(left: 20,right: 20,top: 3),
                                content: Text('You can still accept this request until the user deletes this request.',style: TextStyle(fontWeight: FontWeight.w300,fontSize: 15),),
                                title: Text('Are you sure to reject?',style: TextStyle(fontWeight: FontWeight.w300,fontSize: 20),),
                                actions: <Widget>[
                                  RaisedButton(
                                    color: Colors.blueAccent,
                                    onPressed: ()async{
                                       Navigator.pushNamed(context, '/loading');
                                       await Firestore.instance.collection('bookings').document(widget.data2[index].documentID).setData({'status':'rejected'},merge:true).whenComplete((){Navigator.pop(context); Navigator.pop(context);
                                       Notificationpre().showflush(context, 'Request rejected!');});
                           
                                    },
                                    child: Text('Yes'),
                                  ),


                                   RaisedButton(
                                     color: Colors.red,
                                    onPressed: ()async{
                                        Navigator.pop(context);
                                    },
                                    child: Text('No'),
                                  ),


                                ],
                              );
                            });
                             }
                            else if(widget.data2[index]['status']=='waiting'){
                              showDialog(context: context,builder: (context){
                              return AlertDialog(
                                titlePadding: EdgeInsets.only(left: 20,right: 20,top: 20),
                                contentPadding: EdgeInsets.only(left: 20,right: 20,top: 3),
                                title: Text('Are you sure to reject?',style: TextStyle(fontWeight: FontWeight.w300,fontSize: 20),),
                                content: Text('Once rejected you won\'t be able to accept it. It\'s done, bye!',style: TextStyle(fontWeight: FontWeight.w300,fontSize: 15),),
                                actions: <Widget>[
                                  RaisedButton(
                                    color: Colors.blueAccent,
                                    onPressed: ()async{
                                       Navigator.pushNamed(context, '/loading');
                                       await Firestore.instance.collection('bookings').document(widget.data2[index].documentID).setData({'status':'rejected'},merge:true).whenComplete((){Navigator.pop(context); Navigator.pop(context);
                                       Notificationpre().showflush(context, 'Request rejected!');});
                           
                                    },
                                    child: Text('Yes'),
                                  ),


                                   RaisedButton(
                                     color: Colors.red,
                                    onPressed: ()async{
                                        Navigator.pop(context);
                                    },
                                    child: Text('No'),
                                  ),


                                ],
                              );
                            });
                            }

                            else{
                              Notificationpre().showflush(context, 'Already rejected!');
                            }


                          },),),
                        ),
                        
                      ),

                      SlideAction(
                        color: Colors.white,
                        child: Container(
                           padding: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(color: Colors.white),
                          child: Container(
                    
                          decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(10.0)),
                          child: IconButton(icon: Icon(Icons.done,size: 30,color: Colors.white,),onPressed: ()async{
                            if(widget.data2[index]['status']!='accepted'){
                            
                            showDialog(context: context,builder: (context){
                              return AlertDialog(
                                contentPadding: EdgeInsets.only(left: 20,right: 20,top: 10),
                                titlePadding: EdgeInsets.only(left: 20,right: 20,top: 10),
                                title: Text('Do you want to accept?',style: TextStyle(fontWeight: FontWeight.w300,fontSize: 20),),
                                content: Text('You can manage this request only after accepting, So do it fast.',style:TextStyle(fontWeight: FontWeight.w300)),
                                actions: <Widget>[
                                  RaisedButton(
                                    color: Colors.blueAccent,
                                    onPressed: ()async{
                                       Navigator.pushNamed(context, '/loading');
                                       await Firestore.instance.collection('bookings').document(widget.data2[index].documentID).setData({'status':'accepted'},merge:true) .whenComplete((){Navigator.pop(context); Navigator.pop(context); Notificationpre().showflush(context, 'Request Accepted');});
                           
                                    },
                                    child: Text('Yes'),
                                  ),


                                   RaisedButton(
                                     color: Colors.red,
                                    onPressed: ()async{
                                        Navigator.pop(context);
                                    },
                                    child: Text('No'),
                                  ),


                                ],
                              );
                            });
                            

                            }
                            else if(widget.data2[index]['status']=='accepted'){
                              Notificationpre().showflush(context, 'Already Accepted. Swipe right to manage' );
                            }


                          },),),
                        ),
                        
                      ),

                      
                    ],

                secondaryActions: <Widget>[
                     SlideAction(
                       
                        color: Colors.white,
                        child: GestureDetector(
                              child: Container(
                             padding: EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(color: Colors.white),
                            child: Container(
                            
                            decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10.0)),
                            child: IconButton(icon: Icon(Icons.location_on,size: 30,color: Colors.white,),onPressed: () async{

                                  if(widget.data2[index]['status']=='accepted')
                                  {
                        GeoPoint pos = widget.data2[index]['userlocation'];
                        String googlemap = 'https://www.google.com/maps/search/?api=1&query=${pos.latitude},${pos.longitude}';
                        if(await canLaunch(googlemap))
                        {
                          await launch(googlemap);
                        }
                        else
                        {
                          throw 'Error!!';
                        } 
                                  }

                                  else{
                                    Notificationpre().showflush(context, 'Can\'t access before accepting.');
                                  }



                            },),),
                          ),
                        ), 
                      ),

                      SlideAction(
                        color: Colors.white,
                        child: Container(
                           padding: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(color: Colors.white),
                          child: Container(
                       
                          decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10.0)),
                          child: IconButton(icon: Icon(Icons.call,size: 30,color: Colors.white,),onPressed: () async{

                            if(widget.data2[index]['status']=='accepted'){
                            if(await canLaunch('tel:${widget.data2[index]['userphone']}'))
                          {
                              launch('tel:${widget.data2[index]['userphone']}');
                          }

                          else{
                            print('Something Went Wring');
                          }
                            }
                            else{
                              Notificationpre().showflush(context, 'Can\'t access before accepting.');
                            }



                          },),),
                        ), 
                      ),

                      SlideAction(
                        color: Colors.white,
                        child: Container(
                           padding: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(color: Colors.white),
                          child: Container(
                       
                          decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(10.0)),
                          child: IconButton(

                            onPressed: (){
                              if(widget.data2[index]['status']=='waiting')
                            Notificationpre().showflush(context, 'Accept the request and continue with verification.');

                              else if(widget.data2[index]['status']=='accepted')
                              {

                                ////////////////////////  ARIVAL VERIFICATION //////////////////////////////////
                                 if(widget.data2[index]['startverified']==false)
                                 {
                                    showDialog<bool>(
                                      context: context,
                                      builder: (context) {
                                        return CupertinoAlertDialog(
                                          title: Text('Enter arrival OTP',style: TextStyle(fontWeight: FontWeight.w300,fontSize: 23),),
                                          content: Card(
                                            color: Colors.transparent,
                                            elevation: 1.0,
                                            child: Column(
                                              children: <Widget>[
                                                TextField(
                                                  controller: arrivalotpcontroller,
                                                  keyboardType: TextInputType.number,
                                                  style: TextStyle(fontSize: 23),
                                                  decoration: InputDecoration(
                                                   border: InputBorder.none,
                                                    suffixIcon: IconButton(icon: Icon(Icons.send,color: Colors.blueAccent,),onPressed: () async{

                                                      ////////// ON PRESSED FOR ARIVAL////////
                                                      if(arrivalotpcontroller.text==widget.data2[index]['code1'])
                                                      {
                                                        Navigator.pushNamed(context, '/loading');
                                                        await Firestore.instance.collection('bookings').document(widget.data2[index].documentID).setData({'startverified':true,'startedat':DateTime.now()},merge:true) .whenComplete((){Navigator.pop(context); Navigator.pop(context); Notificationpre().showflush(context, 'Arrival Verification Success.');});
                           
                                                      }
                                                      else{Notificationpre().showflush(context, 'Arrival Verification Failed');}




                                                    }),
                                                    filled: true,
                                                    fillColor: Colors.grey.shade50
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                 }
                                ////////////////////////  TOTAL CALCULATION + TIME + COMPLETED + Balance Deduct //////////////////////////////
                                 else if(widget.data2[index]['endverified']==false && widget.data2[index]['startverified']==true)
                                 {
                                    showDialog<bool>(
                                      context: context,
                                      builder: (context) {
                                        return CupertinoAlertDialog(
                                          title: Text('Enter Jobend OTP',style: TextStyle(fontWeight: FontWeight.w300,fontSize: 23),),
                                          content: Card(
                                            
                                            color: Colors.transparent,
                                            elevation: 1.0,
                                            child: Column(
                                              children: <Widget>[
                                                TextField(
                                                  controller: arrivalotpcontroller,
                                                  keyboardType: TextInputType.number,
                                                  style: TextStyle(fontSize: 23),
                                                  decoration: InputDecoration(
                                                   border: InputBorder.none,
                                                    suffixIcon: IconButton(icon: Icon(Icons.send,color: Colors.blueAccent,),onPressed: () async{

                                                      ////////// ON PRESSED FOR ARIVAL////////
                                                      if(arrivalotpcontroller.text==widget.data2[index]['code2'])
                                                      {

                                                        final startTime = widget.data2[index]['startedat'].toDate();
                                                        final endTime =  DateTime.now();
                                                        final diff_mn = endTime.difference(startTime).inMinutes;
                                                        var totalamt;

                                                        if(diff_mn>60)
                                                        {
                                                        final totalamt = 200+(diff_mn-60)*1.5;
                                                        }
                                                        else{totalamt=200;}


                                                        Navigator.pushNamed(context, '/loading');
                                                        await Firestore.instance.collection('bookings').document(widget.data2[index].documentID).setData({'status':'completed', 'endverified':true,'endat':DateTime.now()},merge:true).
                                                        whenComplete((){
                                                          Firestore.instance.collection('users').document(widget.data2[index]['workeruid']).updateData({'balance':FieldValue.increment(-(totalamt*0.1)),'earnings':FieldValue.increment(totalamt)});
                                                          Navigator.pop(context); 
                                                          Navigator.pop(context); 
                                                          Notificationpre().showflush(context, 'Jobend Verification Success.');});
                           
                                                      }
                                                      else{Notificationpre().showflush(context, 'Jobend Verification Failed');}




                                                    }),
                                                    filled: true,
                                                    fillColor: Colors.grey.shade50
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                 }
                              }
                                 else if(widget.data2[index]['status']=='completed')
                                 {
                                      final startTime = widget.data2[index]['startedat'].toDate();
                                      final endTime =  widget.data2[index]['endat'].toDate();
                                      final diff_mn = endTime.difference(startTime).inMinutes;
                                      var totalamt;

                                      if(diff_mn>60)
                                      {
                                       final totalamt = 200+(diff_mn-60)*1.5;
                                      }
                                      else{totalamt=200;}

                                     showDialog<bool>(
                                      context: context,
                                      builder: (context) {
                                        return CupertinoAlertDialog(
                                          title: Text('Amount Earned \u20b9$totalamt',style: TextStyle(fontWeight: FontWeight.w300,fontSize: 23),),
                                        );
                                      },
                                    );                                  
                                 }
                            },
                            icon: widget.data2[index]['status']=='completed'?Icon(Icons.done_all,size: 30,color: Colors.white,):
                                  widget.data2[index]['status']=='accepted' && widget.data2[index]['startverified']==false?Text('1',style:TextStyle(fontSize:30,color:Colors.white)):
                                  widget.data2[index]['status']=='accepted' && widget.data2[index]['startverified']==true?Text('2',style:TextStyle(fontSize:30,color:Colors.white)):
                                  
                                  Icon(Icons.verified_user,size: 30,color: Colors.black45,)
                            
                          )
                          ),
                        ), 
                      ),
                ],



            );
            },
          ),
        ),
          ),
        ],
      ),
    );
  }
}