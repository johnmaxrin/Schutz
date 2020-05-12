 
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shutz_ui/router.dart';
import 'package:shutz_ui/wrapper.dart';
 


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.blueAccent));
    return MaterialApp(
    onGenerateRoute: Router.generateRoute,
    title: 'Schutz',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: Colors.white
    ),
         
         home: wrapper(),
         
        );
  }
}

