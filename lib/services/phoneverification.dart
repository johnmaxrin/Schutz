import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shutz_ui/Models/user.dart';
import 'package:shutz_ui/services/auth.dart';
 

class phoneverify extends StatefulWidget {

  FirebaseUser user;
  phoneverify({Key key,this.user}) : super(key: key);

  _phoneverifyState createState() => _phoneverifyState();
}


class _phoneverifyState extends State<phoneverify> {

  final _phncntrl = TextEditingController();
  
  final _smscode = TextEditingController();

  

  Future<bool> _loginUser(String phn,BuildContext context) async
  {
    FirebaseAuth _auth=FirebaseAuth.instance;


    _auth.verifyPhoneNumber(
      
      phoneNumber: phn,
      timeout: Duration(seconds: 60),

      verificationCompleted: (AuthCredential credentials) async 
      {
        //Navigator.of(context).pop();

        AuthResult result = await _auth.signInWithCredential(credentials);
        FirebaseUser _user = result.user;

           // KATTTA EXPERIMENT!! 
               AuthServ().signInWithGoogle().whenComplete(()=>print('Experiment Done!'));
           // KATTA EPERIMENT DONE


        if(_user!=null)
        {
          //Success!!!!!!!

          await Firestore.instance.collection('users').document(widget.user.uid).setData({
              'phone':_user.phoneNumber
          },merge: true);

          Navigator.pop(context);
          Navigator.pop(context);
        }

        else{
          print('Error');
        }
      },

      verificationFailed: (AuthException exception)
      {
        print(exception.message);
      },

      codeSent: (String verificationId,[int forceResendToken])
      {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context)
          {
            return CupertinoAlertDialog(
                                          title: Text('Enter the OTP',style: TextStyle(fontWeight: FontWeight.w300,fontSize: 23),),
                                          content: Card(
                                            color: Colors.transparent,
                                            elevation: 1.0,
                                            child: Column(
                                              children: <Widget>[
                                                TextField(
                                                  controller: _smscode,
                                                  keyboardType: TextInputType.number,
                                                  style: TextStyle(fontSize: 23),
                                                  decoration: InputDecoration(
                                                   border: InputBorder.none,
                                                    suffixIcon: IconButton(icon: Icon(Icons.send,color: Colors.blueAccent,),onPressed: () async{
                                                                          final code = _smscode.text.trim(); 

                    AuthCredential credential = PhoneAuthProvider.getCredential(verificationId: verificationId,smsCode: code);
                    AuthResult result = await _auth.signInWithCredential(credential);
                     FirebaseUser _user = result.user;

                     

                     // KATTTA EXPERIMENT!! 
                     AuthServ().signInWithGoogle().whenComplete(()=>print('Experiment Done!'));
                     // KATTA EPERIMENT DONE

                    if(_user!=null) 
                    { 
                       await Firestore.instance.collection('users').document(widget.user.uid).setData({
              'phone':_user.phoneNumber
          },merge: true);

          print('OUR BIG CHECHING ${widget.user.displayName}');
          Navigator.pop(context);
          Navigator.pop(context);
                    }
                    else
                    {
                      print('Error');
                    }

                                                    }

            )))])));
          }
        );
      },
 
      codeAutoRetrievalTimeout: null
    );
  }

  @override
  Widget build(BuildContext context) {

      String ccode;
    
    return WillPopScope(
        onWillPop: ()async=>true,
          child: SafeArea(
            child: Scaffold(
          body: SingleChildScrollView(

            padding: EdgeInsets.symmetric(vertical: 100,horizontal: 30.0),
            child: Form(

                child: Column(
                  
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[

                    SizedBox(height: 25,),
                    Container(
                      height: 130.0,
                      child: Center(
                        child: Text(
                            "Wait.",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.blueAccent,fontSize:120.0,fontWeight: FontWeight.w700),
                          ),
                      ),
                    ),

                    Text(
                      "Please enter your phone number, So that people can reach you easily",
                      style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w300),
                    ),

                    SizedBox(height: 16,),
                    

                    Row(
                      children: <Widget>[

                        Container(
                          width: 100.0,
                          child: CountryCodePicker(
                            initialSelection: 'in',
                            showCountryOnly: true,
                            showFlag: true,
                            onInit:(CountryCode countrycode)=>ccode=countrycode.toString() ,
                            onChanged: (CountryCode countrycode)=>ccode=countrycode.toString() ,

                            
                          ),
                        ),
                        Expanded(
                                                child: TextFormField(
                                                  cursorWidth: 1.0,
                            keyboardType: TextInputType.number,
                            inputFormatters: [new LengthLimitingTextInputFormatter(10)],
                            decoration: InputDecoration(
                              
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(8)),
                                borderSide: BorderSide(color: Colors.grey[200])
                              ),

                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(8)),
                                borderSide: BorderSide(color: Colors.blueAccent)
                              ),

                              filled: true,
                              fillColor: Colors.grey[100],
                              hintText:"Mobile NUmber"
                            ),

                            controller: _phncntrl,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 16,),
                    
                    Container(
                      height: 50.0,
                      child: FlatButton(
                        color: Colors.blueAccent,
                        child: Text('Verify',
                        style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w300),
                        ),
                        textColor: Colors.white,
                        padding: EdgeInsets.all(10),

                        onPressed: (){
                          
                          final phone='$ccode''${_phncntrl.text.trim()}';
                           print(phone);
                          _loginUser(phone, context);
                        },

                        //color: Colors.blueGrey,
                      ),
                    )
                  ],
                ),
            ),
          ),
        ),
      ),
    );
  }
}


