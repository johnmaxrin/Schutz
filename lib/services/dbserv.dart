import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:location/location.dart'; 
import 'package:shutz_ui/Models/user.dart';
import 'package:shutz_ui/widgets/notifications.dart';


class DbServ
{
  String uid; 
  DbServ({this.uid});
  final CollectionReference userref = Firestore.instance.collection('users');
  final CollectionReference jobref = Firestore.instance.collection('job_list');
  final CollectionReference bookingref=Firestore.instance.collection('bookings');

  final CollectionReference gigworks = Firestore.instance.collection('jobs');

  //ADD USER

  Future<void> adduser(User user)
  {   print('Registered! Here!');
      return userref.document(user.uid).setData({
        'uid':user.uid,
        'name':user.name,
        'pic':user.pic,
        'phone':user.phone,
        'email':user.email,
        'loc':null,
        'status':'Enrolled',
        'works_completed':0,
        'balance':50.0,
        'earnings':0.0,
        'level':1,
        'rating':0,
        'nrating':0,
        'perhr':120,
        'job_title':[],
        'token':'',
        'rcnt':false
      });
  }
  // CHECK IF USER IS IN DB //
  Future<bool> checkuser({String uid}) async 
  {
   await userref.document(uid).get().then((snap){
      if(!snap.exists || snap==null)
      {
        return Future<bool>.value(null);
      }
      
    }).catchError((e)=>print('Error at DbServ'));

    return Future<bool>.value(true);
  }

  //CHECK IF USER's PHONE NUMBER IS THERE //
   Future<bool> checkphone() async{
        
        DocumentSnapshot snap=  await userref.document(uid).get();

       if(snap.data==null)
       {
         return false;
       }
        

      if(snap.data['phone']==null)
      {
        print(snap.data);
        print('PHONE ILLA KETTO');
        return Future<bool>.value(null);
      }

      else { 
        print('PHONE OND KETTO');
        print(snap.data['phone']);
        return Future<bool>.value(true);}

  }


 Future addtouser(uid,value,key) async
 {
   await userref.document(uid).setData({
     key:value
   },merge: true);
 }


 
 Future<DocumentSnapshot> getuser(uid)async
 {
   DocumentSnapshot user = await userref.document(uid).get();
    return user;
 }

 Future updatestatus(status,uid) async
 {
   await bookingref.document(uid).updateData({
     'status':status
   });
 }

 Future updateloc(uid) async
 {
    Location loc = new Location();
    Geoflutterfire geo = Geoflutterfire();
    PermissionStatus granted;
    granted = await loc.requestPermission();

    while(granted != PermissionStatus.granted)
    granted = await loc.requestPermission();


    var pos = await loc.getLocation();
    GeoFirePoint point = geo.point(latitude: pos.latitude,longitude: pos.longitude);

   await userref.document(uid).updateData({
     'loc':point.data
   }).whenComplete(()=>print('Location Updated!'));
 }

 
 



}
