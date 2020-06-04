import 'dart:math';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:shutz_ui/Models/bookings.dart';
import 'package:shutz_ui/Models/user.dart';
import 'package:shutz_ui/screens/success.dart';
class WorkerRes extends StatefulWidget {
  String title;
  WorkerRes({Key key,this.title}) : super(key: key);

  _WorkerResState createState() => _WorkerResState();
}

class _WorkerResState extends State<WorkerRes> {

  List<DocumentSnapshot> _user=[];
  int val;
  GeoFirePoint currentloc;
  QuerySnapshot query;

  void fetecUsers()async {

    ////Current Locatiion///////////////////
    Location loc = new Location();
    Geoflutterfire geo = Geoflutterfire();
    PermissionStatus granted;
    granted = await loc.requestPermission();
    while(granted != PermissionStatus.granted)
    granted = await loc.requestPermission();
    var pos = await loc.getLocation();
    GeoFirePoint point = geo.point(latitude: pos.latitude,longitude: pos.longitude);
    print(pos.latitude);
    ////// Current Location Got///////////

    var collectionref =  Firestore.instance.collection('users').where('job_title',arrayContains:'${widget.title}').where('status',isEqualTo: 'available');
    double radius = 10;
    String field = 'loc';
    Stream<List<DocumentSnapshot>> stream = geo.collection(collectionRef: collectionref)
                                        .within(center: point, radius: radius, field: field,strictMode: true);

      stream.listen((List<DocumentSnapshot> documentList){
        print('document size'+'${documentList.length}');
        setState(() {
          _user = documentList;
          currentloc = point;
          
      if(documentList.length==0)
      val=0;
        });
      });



  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetecUsers();
  }

  Future<void> _getData(){
 
      fetecUsers();
  
  }

  @override
  Widget build(BuildContext context) {

    if(val==0)
    {
      print('No Worker');
   return Scaffold(
     appBar: AppBar(elevation: 0,),
        body: Container(
          color: Colors.white,
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             
             children: <Widget>[
                Container(
                   height: 300.0,
                   child: Image.asset('assets/sadkoch.png',fit: BoxFit.contain,)),
               Center(child: Text('No Worker Found',style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w300),),),
             ],
           )),
   );
      
    }
    if(_user.length==0)
     return Container(color: Colors.white, child: Center(child: CircularProgressIndicator(),));
     else
      {
        print(_user.length);
        return RefreshIndicator
        (
          displacement: 60,
          onRefresh:() async {
            fetecUsers();
          } ,
          child: workerist(context, _user,widget.title,currentloc));}
  }
}









//////////////////// WID 1 11111111111111
Widget workerist(context,_user,title,GeoFirePoint currentloc)
{
  final CollectionReference bookingref=Firestore.instance.collection('bookings');
  return SafeArea(
    child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blueAccent,
        leading: IconButton(icon:Icon(Icons.arrow_back,color:Colors.white),onPressed: ()=>Navigator.pop(context),),
      ),

      body: Container(color: Colors.blueAccent, child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment:CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            
            //padding: const EdgeInsets.only(left: 10.0,top: 25.0),
            child:  
             // padding: const EdgeInsets.only(left: 15),
              Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [BoxShadow(blurRadius: 10.0,offset: Offset(0, 5),color: Colors.black12)]
                    ),
                   padding: EdgeInsets.only(left: 20,right: 20,top: 8),
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    height: 60.0, 
                    
                    child: TextField(
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                        ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        
                        hintText: 'Search by name',
                        suffixIcon: IconButton(icon: Icon(Icons.search,color: Colors.black45,),onPressed: (){},)
                      ),
                    ),)
                ],
              )
            ),
          

          Expanded(
                      child: Container(
                        margin: EdgeInsets.only(top: 30),
                        padding: EdgeInsets.only(top: 40.0,bottom: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(50),topRight: Radius.circular(50.0))
                        ),

                        child: ListView.separated(
                          separatorBuilder: (context,index)=>SizedBox(height: 20,),
                          itemCount: _user.length,
                          itemBuilder: (context,index){
                            return GestureDetector(
                                                                    onTap: (){

                            //////////////////////////////////////////////////////////////////DIALOG SECTION////////////////////////
                            ///                                                                                                  ///
                            ///                                                                                                  ///
                            ///            ////////////////////////                                                              ///
                            /// 
                            

                                        showDialog(
                                          context: context,
                                          
                                          builder: (ctx){
                                            return BackdropFilter(
                                                filter: ImageFilter.blur(sigmaX: 5,sigmaY: 5),
                                                child: Dialog(
                                                elevation: 0,
                                                backgroundColor: Colors.transparent.withOpacity(0),
                                                child: Container(
                                                height: MediaQuery.of(context).size.height/1.963,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.circular(25.0)
                                                  ),
                                                  child: Column(
                                                    children: <Widget>[
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: <Widget>[
                                                          IconButton(icon: Icon(Icons.close,color:Colors.red),onPressed: ()=>Navigator.pop(context),)
                                                        ],
                                                      ),

                                                      Container(
                                                        height: 150,
                                                        decoration: BoxDecoration(
                                                          image: DecorationImage(image: AssetImage('assets/patti.png'))
                                                        ),
                                                      ),

                                                      Container(
                                                        //height: 150,
                                                        padding: EdgeInsets.symmetric(horizontal: 20),
                                                        child: Text('Are you sure to book ${_user[index]['name']} ?',style: TextStyle(
                                                          fontSize: 15,
                                                          
                                                          fontFamily: 'poppins',
                                                          fontWeight: FontWeight.w700
                                                        ),
                                                        textAlign: TextAlign.center,
                                                        ),
                                                      ),

                                                      SizedBox(height: 10,),

                                                      Container(
                                                        height: 50.0, 
                                                        //color: Colors.red,
                                                        child: ButtonBar(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: <Widget>[
                                                            RaisedButton(
                                                              onPressed: (){Navigator.pop(context);},
                                                              color: Colors.red,
                                                              child: Text('No, I\'m not Sure'),
                                                            ),
                                                            RaisedButton(
                                                              color: Colors.green,
                                                              onPressed: () async{
                                                                // 2 THINGS!!
                                                                //1. CREATE A BOOKING OBJECT
                                                                //2. UPLOAD THE BOOKING
                                                                Navigator.popAndPushNamed(context, '/loading');
                                                                FirebaseUser currentuser = await FirebaseAuth.instance.currentUser();
                                                                UserV3 userdata = UserV3.fromSnapshot(await Firestore.instance.collection('users').document(currentuser.uid).get());
                                                                UserV3 workerdata = UserV3.fromSnapshot(await Firestore.instance.collection('users').document(_user[index]['uid']).get());
                                                                String code1  = new Random().nextInt(99999).toString();
                                                                String code2  = new Random().nextInt(99999).toString();
                                                                var now = new DateTime.now();
                                                                var formatter = new DateFormat('dd-MM-yyyy');
                                                                String date = formatter.format(now);
                                                              
                                                                Bookings booking = Bookings.makebooking(userdata, workerdata,title , code1, code2,date,);
                                                                //// CREATED OBJECT  //////
                                                                bookingref.add(booking.tojson()).whenComplete((){Navigator.pop(context); 
                                                                Success().successdig(context,'Booking added successfully! Manage it under booking section', 1).whenComplete((){
                                                                    Navigator.pushNamed(context, '/mybookings');
                                                                });
                                                               // Navigator.pop(context);
                                                             
                                                                });
                                                                
                                                                
                                                              },
                                                              child: Text('Yes, Proceed'),
                                                            )
                                                          ],
                                                        ),
                                                        )
                                                    ],
                                                  )
                                                ),
                                              ),
                                            );
                                          }
                                        );
                                      },
                                child: Container(
                                padding: EdgeInsets.symmetric(horizontal:15),
                                margin: EdgeInsets.symmetric(horizontal: 30),
                                height:100,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: [BoxShadow(blurRadius: 5,offset: Offset(0, 1),color: Colors.black12)]
                                ),

                                child: Row(
                                  children: <Widget>[
                                    //////////////// PROFILE //////////////////////////
                                    Container(
                                    height: 70,
                                    width: 70,
                                       decoration: BoxDecoration(
                                     color: Colors.black12,
                                     image: DecorationImage(image: NetworkImage(_user[index]['pic'])),
                                     borderRadius: BorderRadius.circular(10)
                                       ),
                                      ),

                                    /////////////// DETAILS SEC //////////////
                                    Container(
                                      margin: EdgeInsets.only(left: 10,top: 10),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(_user[index]['name'],
                                            style: TextStyle(
                                              fontSize: 19,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: 'poppins'
                                            ),
                                            
                                          ),

                                          ////Rating 
                                           
                                          Text('${_user[index]['rating'].toString()}'=='0'?'${_user[index]['rating'].toString()}'
                      :(_user[index]['rating']/_user[index]['nrating']).toStringAsFixed(1),
                                                style: TextStyle(fontWeight: FontWeight.w500,color: Colors.green),
                                              ),

                                           Text('\u20b9${_user[index]['perhr']} Per Hour',
                                                
                                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400,color: Colors.black45),
                                              ),

                                          Text('${currentloc.distance(lng: _user[index]['loc']['geopoint'].longitude,lat: _user[index]['loc']['geopoint'].latitude)} Km away',
                                                
                                                style: TextStyle( fontWeight: FontWeight.w500,color: Colors.black45),
                                              ),

                                          
                                        ],
                                      ),
                                    ),

                                  

                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        
                      ),
          )
        ],
      ),),
    ),
  );
                            

        
      
    
}