import 'dart:wasm';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

class User
{
  String uid;
  String name;
  String pic;
  String phone;
  String email;
  String location;
  String status;
  List<String> jobs;
  String wrkcmp;
  String perhr;
  String bal;
  String rating;
  String level;
  bool req;
  String loc;


  User({this.uid,this.name,this.pic,this.email,this.location,this.phone,this.status});
}



class UserV3
{
  String uid;
  String name;
  String pic;
  String phone;
  String email;
  String status;
  List<String> jobs;
  String wrkcmp;
  double perhr;
  double bal;
  double rating;
  String token;
  int level;
  bool req;
  GeoPoint loc;
  bool rcnt;
  
  UserV3.fromSnapshot(DocumentSnapshot data) 
  : uid = data['uid'],
    name = data['name'],
    pic = data['pic'],
    phone = data['phone'],
    email = data['email'],
    status = data['status'],
    jobs = List.from(data['job_title']),
    wrkcmp = data['wrkcmp'],
    perhr = data['perhr'].toDouble(),
    bal = data['balance'].toDouble(),
    rating = data['rating'].toDouble(),
    level = data['level'],
    req = data['req'],
    token=data['token'],
    loc = data['loc']['geopoint'],
    rcnt=data['rcnt'];
  

}