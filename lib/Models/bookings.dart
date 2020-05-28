import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:shutz_ui/Models/user.dart';

class Bookings
{
  
  String randgen(){
    int code = new Random().nextInt(9999999);
    return code.toString();
  } 


  String jobname;
  String username;
  String pic;
  String userphone;
  GeoPoint userlocation;
  String code1;
  String code2;
  String perhr;
  String workername;
  String workerphone;
  String workerpic;
  String usertoken;
  String workertoken;
  String workeruid;
  String useruid;
  GeoPoint workerlocation;
  bool startverified;
  bool endverified;
  String status;
  String timetaken;
  String amtpayable;
  String createdat;
  bool completed;

  Bookings({
  this.createdat,
  this.jobname,
  this.username,
  this.pic,
  this.userphone,
  this.userlocation,
  this.code1,
  this.code2,
  this.perhr,
  this.workername,
  this.workerphone,
  this.workerpic,
  this.usertoken,
  this.workertoken,
  this.workeruid,
  this.useruid,
  this.workerlocation,
  this.startverified,
  this.endverified,
  this.timetaken,
  this.amtpayable,
  this.status,
  this.completed,
  });



  Bookings.makebooking(UserV3 user,UserV3 worker,String jobname,String code1,String code2,String date)
  :

  


  userlocation = user.loc,
  username = user.name,
  userphone = user.phone,
  usertoken = user.token,
  useruid = user.uid,
  pic = user.pic,
  workerlocation = worker.loc,
  workername = worker.name,
  workerphone = worker.phone,
  workerpic = worker.pic,
  workertoken = worker.token,
  workeruid = worker.uid,
  startverified = false,
  endverified = false,
  status = 'waiting',
  jobname = jobname,
  code1 = code1,
  code2 = code2,
  perhr = worker.perhr,
  amtpayable = '0',
  timetaken = '0',
  completed = false,
  createdat = date;

  

  Map<String,dynamic> tojson()
    => {

      "Username": username,
      'userphone':userphone,
      'jobname':jobname,
      'pic':pic,
      'userlocation':userlocation,
      'code1':code1,
      'code2':code2,
      'perhr':perhr,
      'workername':workername,
      'workerphone':workerphone,
      'workerpic':workerpic,
      'usertoken':usertoken,
      'workertoken':workertoken,
      'workeruid':workeruid,
      'useruid':useruid,
      'workerloc':workerlocation,
      'startverified':startverified,
      'endverified':endverified,
      'status':status,
      'timetaken':timetaken,
      'amtpayable':amtpayable,
      'createdat':createdat,
      'completed':completed

    };
  }
  

