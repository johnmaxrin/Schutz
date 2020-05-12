import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shutz_ui/Models/user.dart';
import 'package:shutz_ui/services/auth.dart';
import 'package:shutz_ui/services/dbserv.dart';


class login_signup extends StatefulWidget {
  login_signup({Key key}) : super(key: key);

  _login_signupState createState() => _login_signupState();
}

class _login_signupState extends State<login_signup> {
  FirebaseUser user;

  @override
  Widget build(BuildContext context) {
    
    return Container(
       child: Scaffold(
         body: Center(child: 
         Column(
           mainAxisAlignment: MainAxisAlignment.center,
           mainAxisSize: MainAxisSize.min,
           children: <Widget>[
            
              Container(
                 height: 220.0,
                 child: Image.asset('assets/happy2.png',fit: BoxFit.contain,)),

                
              Container(
               padding: EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    Text('Welcome,',style:TextStyle(fontSize:MediaQuery.of(context).size.height*0.06,fontFamily: 'poppins')),
                    Container(
                     
                      
                      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Text(
                      'Join Schutz and do amazing stuffs! At the end, hardwork pays it off. Good Luck',
                      textAlign: TextAlign.center,
                      
                      style:TextStyle(color: Colors.black54, fontSize:MediaQuery.of(context).size.height * 0.02,fontFamily: 'poppins',fontWeight: FontWeight.w600,letterSpacing: 0)),
                    )
                  ],
                )
              ),

                GestureDetector(
                      onTap: () async
                      {

                          User data = await AuthServ().signInWithGoogle();
                          
                    if(data.uid==null){
                     
                      Navigator.popAndPushNamed(context, '/wrapper');
                    } 
                    
                    else{
                      
                        print('EVAN ANN ALLL: '+data.uid);
                        final CollectionReference userref = Firestore.instance.collection('users');
                        DocumentSnapshot snap =await userref.document(data.uid).get().whenComplete(()=>print('AVAN ONDO ILLEYO NN IPPAM ARIYAM'));
                        print(snap.data);
                        if(snap.data['name']==null){
                          DbServ().adduser(data).whenComplete(()=>print('EVANE NAMMAL KETTI'));
                          
                        }
                         
                      }
                       

                      },

                      child: Container(
                      height: MediaQuery.of(context).size.height*0.08,
                      width:  MediaQuery.of(context).size.height*0.4,
                      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      
                      child: Center(child: Text('Get Started',style: TextStyle(color: Colors.white,fontSize: 20.0,fontFamily: 'poppins'),)),
                      decoration: BoxDecoration(color: Colors.blueAccent,borderRadius: BorderRadius.circular(20.0)),
                    ),
                )            

            
           ],
         )),
       ),
    );
  }
}



