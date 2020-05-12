import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shutz_ui/screens/about_screen.dart';
import 'package:shutz_ui/screens/bookingsandrequest.dart';
import 'package:shutz_ui/screens/hire_accepted.dart';
import 'package:shutz_ui/screens/home_screen.dart';
import 'package:shutz_ui/screens/loading.dart';
import 'package:shutz_ui/screens/login_signup.dart';
import 'package:shutz_ui/screens/profile_screen.dart';
import 'package:shutz_ui/screens/work_found.dart';
import 'package:shutz_ui/services/const.dart';
import 'package:shutz_ui/services/phoneverification.dart';
import 'package:shutz_ui/wrapper.dart';


class Router{
 static Route<dynamic> generateRoute(RouteSettings settings)
  {
    switch(settings.name)
    {
      case homeroute:
      return MaterialPageRoute(builder: (_)=>Home(cuser: settings.arguments,));


      case workerfoundroute:
      return MaterialPageRoute(builder: (_)=>work_found());

 

      case aboutsc:
      return CupertinoPageRoute(builder: (_)=>about());

      case profileroute:
      return MaterialPageRoute(builder: (_)=>profile_screen(cuser: settings.arguments,));

      case hireacceptedroute:
      return MaterialPageRoute(builder: (_)=>hire_accepted());

      case auth:
      return MaterialPageRoute(builder: (_)=>login_signup());

      case frontwrap:
      return MaterialPageRoute(builder: (_)=>wrapper());

      case loadingr:
      return MaterialPageRoute(builder: (_)=>loading());

      case phoneconst:
      return MaterialPageRoute(builder: (_)=>phoneverify(user: settings.arguments,));

      case mybookingsroute:
      return CupertinoPageRoute(builder: (_)=>mybookings(uid:settings.arguments));

      case myrequest:
      return CupertinoPageRoute(builder: (_)=>myrequests(uid:settings.arguments));

      default:
      return MaterialPageRoute(builder: (_){
        return  Center(child: Text('Error'),);
      });
    }
  }
}