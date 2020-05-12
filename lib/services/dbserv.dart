import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:location/location.dart';
import 'package:shutz_ui/Models/job_list.dart';
import 'package:shutz_ui/Models/user.dart';


class DbServ
{
  String uid;
  DbServ({this.uid});
  final CollectionReference userref = Firestore.instance.collection('users');
  final CollectionReference jobref = Firestore.instance.collection('job_list');
  final CollectionReference bookingref=Firestore.instance.collection('bookings');

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
        'works_completed':'0'
       
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

  Future<Job_list> postjob(User user,String msg,String title,BuildContext context) async
  {   

     DocumentSnapshot snap=  await userref.document(user.uid).get();
     if(snap.data['phone']==null)
     {
       return Navigator.popAndPushNamed(context, '/phoneconst',arguments: user);
     }
  else{
          Location loc = new Location();
      Geoflutterfire geo = Geoflutterfire();

      var pos = await loc.getLocation();
      GeoFirePoint point = geo.point(latitude: pos.latitude,longitude: pos.longitude);

      Job_list job_list=Job_list().buildjob(user, msg, title);
      
       jobref.document(job_list.job_id).setData({
        'job_id':job_list.job_id,
        'job_title':job_list.job_title,
        'loc':point.data,
        'provider_id':job_list.provider_id,
        'provider_phone':snap.data['phone'],
        'provider_msg':job_list.provider_msg,
        'provider_name':job_list.provider_name,
        'provider_pic':job_list.provider_pic,
        'time':job_list.time
      }); 
      return job_list;
  }

  }


 Future addtouser(uid,value,key) async
 {
   await userref.document(uid).setData({
     key:value
   },merge: true);
 }

 Future addbookin(clientid,workerid,title) async{
   DocumentSnapshot worker = await userref.document(workerid).get();
   DocumentSnapshot client = await userref.document(clientid).get();
   String workertoken = worker.data['token'];
   String clienttoken = client.data['token'];
   String uid = new DateTime.now().millisecondsSinceEpoch.toString();
   await bookingref.document(uid).setData({
     'clientid':clientid,
     'workerid':workerid,
     'job_title':title,
     'workertoken':workertoken,
     'clienttoken':clienttoken,
     'status':'pending',
     'uid':uid,
     'client':client.data['name'],
     'worker':worker.data['name'],
     'clientloc':client.data['loc'],
     'workerloc':worker.data['loc'],
     'clientpic':client.data['pic'],
     'workerpic':worker.data['pic'],
     'clientphone':client.data['phone'],
     'workerphone':worker.data['phone']
   });
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
    var pos = await loc.getLocation();
    GeoFirePoint point = geo.point(latitude: pos.latitude,longitude: pos.longitude);

   await userref.document(uid).updateData({
     'loc':point.data
   });
 }


}
