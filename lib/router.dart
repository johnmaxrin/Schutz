import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shutz_ui/screens/bookingreq.dart';
import 'package:shutz_ui/screens/help.dart';
import 'package:shutz_ui/screens/loading.dart';
import 'package:shutz_ui/screens/login_signup.dart';
import 'package:shutz_ui/screens/privacy.dart';
import 'package:shutz_ui/screens/searchres.dart';
import 'package:shutz_ui/screens/v3_workhere.dart';
import 'package:shutz_ui/services/const.dart';
import 'package:shutz_ui/services/phoneverification.dart';
import 'package:shutz_ui/wrapper.dart';


class Router{
 static Route<dynamic> generateRoute(RouteSettings settings)
  {
    switch(settings.name)
    {
      


      case auth:
      return MaterialPageRoute(builder: (_)=>login_signup());

      case frontwrap:
      return MaterialPageRoute(builder: (_)=>wrapper());

      case loadingr:
      return MaterialPageRoute(builder: (_)=>loading());

      case phoneconst:
      return MaterialPageRoute(builder: (_)=>phoneverify(user: settings.arguments,));


      case workerres:
      return CupertinoPageRoute(builder: (_)=>WorkerRes(title: settings.arguments,));

      case workerdash:
      return CupertinoPageRoute(builder: (_)=>V3WorkerDash());

      case mybookingsroute:
      return CupertinoPageRoute(builder: (_)=>bookingreqscreen());


      case myrequestroute:
      return CupertinoPageRoute(builder: (_)=>myrequestbuilder());

      case help:
      return CupertinoPageRoute(builder: (_)=>helpscreen());


      case privacy:
      return CupertinoPageRoute(builder: (_)=>privacypage());


      default:
      return MaterialPageRoute(builder: (_){
        return  Center(child: Text('Error'),);
      });
    }
  }
}