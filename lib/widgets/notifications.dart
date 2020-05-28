
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:shutz_ui/services/dbserv.dart';



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
