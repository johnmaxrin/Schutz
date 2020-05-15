import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:shutz_ui/Models/user.dart';
import 'package:shutz_ui/screens/home_screen.dart';
import 'package:shutz_ui/screens/homev3.dart';
import 'package:shutz_ui/screens/login_signup.dart';
import 'package:shutz_ui/screens/nointernet.dart';
import 'package:shutz_ui/services/auth.dart';


 

class wrapper extends StatelessWidget {

  const wrapper({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
      return StreamBuilder(

              stream: AuthServ().network,
              builder: (context,AsyncSnapshot<ConnectivityResult> snapshot1)
              {
                return StreamBuilder<User>(
          stream: AuthServ().user,
          builder:(BuildContext context, AsyncSnapshot<User> snapshot) {
            
            if(snapshot1.data!=ConnectivityResult.none)
            
            {
                if(!snapshot.hasData)
            { 
              print('Wrapper: ${snapshot1.connectionState}');
              print('Wrapper '+'${snapshot.data}');
              return login_signup() ;
            }

            else
            { print('BIG CHECK 2 ${snapshot.data}');
               //Navigator.pop(context);
               return home_screenv3();
            }
            }

            else{

              //return home_screenv3();
              return nointernet();  //CHANGE HIM LATER
             }
          
            
            }
        );
              });
              }
              
              
  }
