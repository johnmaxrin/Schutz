import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shutz_ui/screens/success.dart';
import 'package:shutz_ui/services/dbserv.dart';
import 'package:shutz_ui/widgets/notifications.dart';
import 'package:shutz_ui/widgets/searchresdialogue.dart';
import 'package:url_launcher/url_launcher.dart';

class mybookings extends StatefulWidget {
  String uid;
  mybookings({Key key,this.uid}) : super(key: key);

  _mybookingsState createState() => _mybookingsState();
}

class _mybookingsState extends State<mybookings> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(

        stream: Firestore.instance.collection('bookings').where('clientid',isEqualTo:widget.uid).snapshots(),
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot)
        {
          if(!snapshot.hasData) return Scaffold(body: Center(child: CircularProgressIndicator(),),);
          else if(snapshot.data.documents.length==0)
          return nobookings(context,1);
          return buildlist(context,snapshot,1);
        },
          
    );
    
   
  }
}

Widget buildlist(context,AsyncSnapshot<QuerySnapshot> snapshot,int i){
return Scaffold(
            backgroundColor: Colors.white,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(60.0),
                          child: AppBar(
                            backgroundColor: Colors.blueAccent,
                title: Text(i==1?'Bookings':'Requests',style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.w300,color: Colors.white,),),
                elevation: 5,
                leading: IconButton(icon: Icon(Icons.arrow_back_ios,size: 30,color: Colors.white,),onPressed: ()=>Navigator.pop(context),),
                
              ),
            ),
            body: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount:snapshot.data.documents.length,
                      itemBuilder: (BuildContext context,int index){
                        return Column(
              children: <Widget>[
                SizedBox(height: 10.0,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: 
                  Slidable(
                    
                    actionExtentRatio: 0.15,
                    actionPane: SlidableDrawerActionPane(),
                    
                      child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                        elevation: 2,
  
                        child: ListTile(
                          
                          leading: CircleAvatar(
                            backgroundImage: i==1?NetworkImage(snapshot.data.documents[index].data['workerpic']):NetworkImage(snapshot.data.documents[index].data['clientpic']),
                            radius: 25.0,
                            backgroundColor: Colors.black,
                          ),
                          title: Text(i==1?snapshot.data.documents[index].data['job_title']:snapshot.data.documents[index].data['client']),
                          subtitle: Text(i==1?snapshot.data.documents[index].data['worker']:snapshot.data.documents[index].data['job_title']),
                          trailing:snapshot.data.documents[index].data['status']=='accepted'?Icon(Icons.done,size: 30.0,color: Colors.blue,):Icon(Icons.timelapse,size: 30.0,color: Colors.red,),
                          
                        ),
                      ),
  
                    actions: <Widget>[
                      SlideAction(
                        child: Container(
                       
                        decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10.0)),
                        child: IconButton(icon: Icon(Icons.delete,size: 30,color: Colors.white,),onPressed: (){},),),
                        
                      ),
                    ],
  
                    secondaryActions: <Widget>[

                      SlideAction(
                        child: Container(
                       
                        decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10.0)),
                        child: IconButton(icon: Icon(Icons.location_on,size: 30,color: Colors.white,),
                        onPressed: (){

                          if(i==1)
                          {
                            locationmap(context, snapshot.data.documents[index].data['workerloc']['geopoint']);
                          }

                          else
                          {
                            locationmap(context, snapshot.data.documents[index].data['clientloc']['geopoint']);
                          }
                        },),),
                        
                      ),

                      SlideAction(
                        child: Container(
                       
                        decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(10.0)),
                        child: IconButton(icon: Icon(Icons.call,size: 30,color: Colors.white,),onPressed: () async{
                          
                          var wphone  = snapshot.data.documents[index].data['workerphone'];
                          var cphone  = snapshot.data.documents[index].data['clientphone'];
                          if(await canLaunch('tel:$cphone'))
                          {
                              launch(i==1?'tel:$wphone':'tel:$cphone');
                          }

                          else{
                            print('Something Went Wring');
                          }
                          
                        },),),
                        
                      ),


                        SlideAction(
                        child: Container(
                       
                        decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10.0)),
                        child: IconButton(
                          icon: i==1?Icon(Icons.verified_user,
                          size: 30,
                          color: Colors.white,):
                          Icon(Icons.directions_run,
                          size: 30,
                          color: Colors.white,),

                          onPressed: (){
                            if(i==1){}
                            //DO VERIFICATION
                            else{
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context)
                                      {
                                        return Dialog(
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                                        child: Container(
                                                height: MediaQuery.of(context).size.height * 0.27,
                                                width: 300.0,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(20.0),
                                                  
                                                                        ),
                                                  child: Column(
                                                    children: <Widget>[
                                                      Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[IconButton(icon:Icon(Icons.close,color:Colors.red),onPressed: (){Navigator.pop(context);},),],),

                                                      Text('Accept?',
                                                      style:TextStyle(fontSize:50,fontWeight:FontWeight.w300)
                                                      ),

                                                      Expanded(
                                                                                                              child: Row(
                                                          mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                                                          children: <Widget>[
                                                            Container(
                                                              child: RaisedButton(
                                                                child: Text('No',style: TextStyle(color: Colors.white,fontSize: 19.0,fontWeight: FontWeight.w300),),
                                                                color: Colors.red,
                                                                onPressed: (){},
                                                              ),
                                                            ),

                                                            Container(
                                                              child: RaisedButton(
                                                                child: Text('Yes',style: TextStyle(color: Colors.white,fontSize: 19.0,fontWeight: FontWeight.w300),),
                                                                color: Colors.blueAccent,
                                                                onPressed: (){

                                                                  if(snapshot.data.documents[index].data['status']!='accepted')
                                                                  { 
                                                                    Navigator.pushNamed(context, '/loading');
                                                                     DbServ().updatestatus('accepted', snapshot.data.documents[index].data['uid']).whenComplete((){
                                                                       Navigator.pop(context);
                                                                       Navigator.pop(context);
                                                                       Success().successdig(context, 'Accepted', 1);
                                                                       });
                                                                  }

                                                                  else
                                                                  {
                                                                    Notificationpre().showflush(context, 'Already Accepted. You May Reach client ASAP');
                                                                  }

                                                                },
                                                              ),
                                                            ),

                                                            
                                                          ],
                                                        ),
                                                      ),SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                                                    ],
                                                  ),
                                                  ));
                            });
                          }}),),
                        
                      ),


                    
                     
                    ],
                  ))]);
      }),
                );
            
          
      }


Widget nobookings(context,i)
{
 return Scaffold(
   
   appBar:  PreferredSize(
     preferredSize: Size.fromHeight(60.0),
                 child: AppBar(
                   backgroundColor: Colors.blueAccent,
       title: Text(i==1?'Bookings':'Requests',style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.w300,color: Colors.white,),),
       elevation: 5,
       leading: IconButton(icon: Icon(Icons.arrow_back_ios,size: 30,color: Colors.white,),onPressed: ()=>Navigator.pop(context),),
       
     ),
   ),
        body: Center(
 child: Column(
   mainAxisSize: MainAxisSize.min,
   children: <Widget>[
      Container(
        height: 200.0,
        child: Image.asset('assets/kuthirikal.png',fit: BoxFit.cover,)),

     
     SizedBox(height: 10.0,),
     Text(i==1?'No Bookings Yet':'No Requests Yet',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w300),),
      SizedBox(height: MediaQuery.of(context).size.height*0.1),
   ],
 )));
          
        
      
    
}




////////REQUEST////////////////


class myrequests extends StatefulWidget {
  String uid;
  myrequests({Key key,this.uid}) : super(key: key);

  _myrequestsState createState() => _myrequestsState();
}

class _myrequestsState extends State<myrequests> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(

        stream: Firestore.instance.collection('bookings').where('workerid',isEqualTo:widget.uid).snapshots(),
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot)
        {
          if(!snapshot.hasData) return Scaffold(body: Center(child: CircularProgressIndicator(),),);
          else if(snapshot.data.documents.length==0)
          return nobookings(context,2);
          return SafeArea(child: buildlist(context,snapshot,2));
        });
  }
}