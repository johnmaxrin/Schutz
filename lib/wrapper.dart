import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:shutz_ui/Models/user.dart';
import 'package:shutz_ui/screens/homev3.dart';
import 'package:shutz_ui/screens/login_signup.dart';
import 'package:shutz_ui/screens/nointernet.dart';
import 'package:shutz_ui/services/auth.dart';
import 'package:store_redirect/store_redirect.dart';


 

class wrapper extends StatelessWidget {

  const wrapper({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) { 
      return StreamBuilder(
          stream: Firestore.instance.collection('version').document('currentversion').snapshots(),
          builder: (context,AsyncSnapshot<DocumentSnapshot> snapshot2){

          if(snapshot2.hasData){
            print(snapshot2.data);
          if(snapshot2.data['version']!=3)
            return versionupdate(context,snapshot2);
          }

            
          
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
                      return login_signup() ;
                  else
                      return home_screenv3();
              }

              else
               return nointernet();   

              }
          ); //USER 
    });
           } ); // NETWORK
              }
              
  }
  



























////////////////// VERSION DIALOGUE //////////////////////
///

Widget versionupdate(contex, data)
{
  return Scaffold(
    body: Dialog(
      elevation: 1,
      child: Container(
        padding: EdgeInsets.all(20),
        height: MediaQuery.of(contex).size.height/2,
        child: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(contex).size.height/2.8,
            child: Image.asset('assets/sadkoch.png'),
          ),
          SizedBox(height: 10,),
          

           Container(
                  padding: EdgeInsets.only(left: 0),
                  
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: '${data.data['msg']}',
                      style: TextStyle(fontSize: 10,color: Colors.red[200]),
                    ),
                  )
                ),



  SizedBox(height: 5,),
          Expanded(
            child: Center(child: RaisedButton(
              color: Colors.blueAccent,
              onPressed: (){StoreRedirect.redirect(androidAppId: '${data.data['msg']}');},child: Text('${data.data['btxt']}',style:TextStyle(fontSize: 20,color: Colors.white,fontFamily: 'poppins'))),),
          )
        ],
      )),
    ),
  );
}