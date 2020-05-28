import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shutz_ui/Models/user.dart';
import 'package:shutz_ui/services/dbserv.dart';
import 'package:shutz_ui/widgets/notifications.dart';
import 'package:shutz_ui/widgets/v3_gig_digs.dart';


class V3WorkerDash extends StatefulWidget {
  V3WorkerDash({Key key}) : super(key: key);

  _V3WorkerDashState createState() => _V3WorkerDashState();
}




class _V3WorkerDashState extends State<V3WorkerDash> {
 DocumentSnapshot _user;
  UserV3 userV3;
  Razorpay _razorpay;
  String bal;
  int amt = 0;

    void fetecUsers()async {
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      DocumentSnapshot query = await Firestore.instance.collection('users').document(user.uid).get();
       UserV3 userV3t  =  UserV3.fromSnapshot(query);
      
      setState(() {
       userV3 = userV3t;
      _user = query;
      bal = userV3.bal.toString();
      });
  }

  @override
  void initState() {
    
    super.initState();
    fetecUsers();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handlePaymentWallet);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout(topup) async {
    setState(() {
      amt = topup;
    });
    var options = {
      'key': 'rzp_test_SekaYprx3upThF',
      'amount':topup*100,
      'name': 'Schutz Gig Topup',
      'description' : 'Test Description hello muthew how ate you?',
      'prefill' : {'contact' : '','email':'ksamuelrobert@gmail.com'},
      'external' :{'wallets' : ['paytm'] } 
    };

    try{
      _razorpay.open(options);
    }catch(e){
      print(e);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) 
  {
    Notificationpre().showflush(context, 'Payment Success!!');
    updateamt();
   
  }

  void _handlePaymentError(PaymentFailureResponse response){
    print('DHEY SAMBHAVAM EVIDE OND'+response.message);
    Notificationpre().showflush(context, 'Payment Error!!');
  }

  void _handlePaymentWallet(ExternalWalletResponse response){
    Notificationpre().showflush(context, 'Payment External Wallet!!');
  }

  void updateamt() async
  {
    setState(() {
      int res = int.parse(bal)+amt;
      userV3.bal = res.toDouble();
    });

    await Firestore.instance.collection('users').document(_user.data['uid']).updateData({"balance": userV3.bal});
  }

  @override
  Widget build(BuildContext context,) {

     if(_user==null)
     return Container(color: Colors.white, child: Center(child: CircularProgressIndicator(),));
    return RefreshIndicator(
      onRefresh: () async {
            fetecUsers();
          } ,

      child: v3workhere());
  }















///////////////////WIDGET//////////////////////////
  Widget v3workhere()
  {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        leading: IconButton(icon: Icon(Icons.arrow_back,),color: Colors.white,onPressed: ()=>Navigator.pop(context),),
      ),

      
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{

            

            print(_user.data['status']);
            
            if(_user.data['job_title'].length==0)
            Notificationpre().showflush(context, 'Select atleast one skill from the skill section and try again');
            else if(userV3.status=='available')
            {
              await Firestore.instance.collection('users').document(_user.data['uid']).updateData({"status":'not available'}).whenComplete((){
                setState(() {
                  userV3.status='not available';
                });
                Notificationpre().showflush(context, 'Status Updated! You are not working currently');
              });
            }

            else if(userV3.status=='not available'){
              DbServ().updateloc(userV3.uid);
              await Firestore.instance.collection('users').document(_user.data['uid']).updateData({"status":'available'}).whenComplete((){
                setState(() {
                  userV3.status='available';
                });
                Notificationpre().showflush(context, 'Status Updated! You are working ');
              });
            }
            
        },
        backgroundColor: userV3.status == 'available' ? Colors.red : Colors.blueAccent,
        child: userV3.status=='available'? Text('Stop'):Text('Start')
      ),
      backgroundColor: Colors.blueAccent,
      body: Column(
        children: <Widget>[
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 50.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text('\u20b9${userV3.bal.toString()}',style: TextStyle( fontSize: MediaQuery.of(context).size.height*0.08,color: Colors.white,fontWeight: FontWeight.w200),),
                      Text('Your balance',style: TextStyle(height: 0.5, fontSize: MediaQuery.of(context).size.height*0.025,color: Colors.white,fontWeight: FontWeight.w300),),
                    ],
                  ),
                ),


                Container(
                  margin: EdgeInsets.only(right: 50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [BoxShadow(blurRadius: 10,offset: Offset(3, 5),color: Colors.black12)],
                              image: DecorationImage(image:NetworkImage(userV3.pic)),          
                              color: Colors.black
                            ),

                           width: 70.0,
                           height: 70.0,

                    
                          ),

                          Positioned(
                            right: 10,
                            bottom: 1,
                            child: Container(height: 10,width: 10,
                            
                            decoration: BoxDecoration(color:userV3.status=='available'?Colors.greenAccent:Colors.redAccent,shape: BoxShape.circle),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 30,),

                     
                      
                    ],
                  ),
                ),
              ],
            ),
          ),


          Container(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      height: 60.0,
                      width: 60.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [BoxShadow(blurRadius: 10,offset: Offset(5, 5),color: Colors.black12)]
                      ),

                      child: Icon(MdiIcons.barcodeScan,size:30.0,color:Colors.blueAccent),
                    ),

                    Text('Verify',style:TextStyle(height: 1.5,fontWeight: FontWeight.w500,color: Colors.white70))
                  ],
                ),



                                Column(
                  children: <Widget>[
                    GestureDetector(
                          onTap: ()async{
                            
                            Navigator.pushNamed(context, '/loading');
                              QuerySnapshot query = await Firestore.instance.collection('jobs').getDocuments().whenComplete(()=>Navigator.pop(context));
                              Dialogues().skill1(context,query,userV3.jobs);
                          },
                         child: Container(
                        height: 60.0,
                        width: 60.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: [BoxShadow(blurRadius: 10,offset: Offset(5, 5),color: Colors.black12)]
                        ),

                        child: Icon(Icons.work,size:30.0,color:Colors.blueAccent),
                      ),
                    ),

                    Text('Skills',style:TextStyle(height: 1.5,fontWeight: FontWeight.w500,color: Colors.white70))
                  ],
                ),


                                Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                        showDialog(
                          context: context,
                          builder: (BuildContext context){
                            return BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 10,sigmaY: 10),
                                child: Dialog(
                                backgroundColor: Colors.transparent,
                                child: Container(height: MediaQuery.of(context).size.height/4,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.circular(20.0)
                                                  ),

                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: <Widget>[
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: <Widget>[
                                                          Text('Select a topup amount?',style: TextStyle(fontWeight: FontWeight.w700, fontFamily: 'poppins', fontSize: MediaQuery.of(context).size.height*0.024),),
                                                          
                                                        ],
                                                      ),

                                                      Column(
                                                            children: <Widget>[
                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                children: <Widget>[
                                                                  topupButton('50'),
                                                                  topupButton('100'),
                                                                  topupButton('500'),
                                                                  topupButton('1000'),
                                                                  
                                                                ],
                                                              )
                                                            ],
                                                          )
                                                    ],
                                                  ),
                                                  ),
                              ),
                            );
                          }
                        );
                      },
                       child: Container(
                        height: 60.0,
                        width: 60.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: [BoxShadow(blurRadius: 10,offset: Offset(5, 5),color: Colors.black12)]
                        ),

                        child: Icon(MdiIcons.wallet,size:30.0,color:Colors.blueAccent),
                      ),
                    ),

                    Text('Topup',style:TextStyle(height: 1.5,fontWeight: FontWeight.w500,color: Colors.white70))
                  ],
                ),


                                Column(
                  children: <Widget>[
                    Container(
                      height: 60.0,
                      width: 60.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [BoxShadow(blurRadius: 10,offset: Offset(5, 5),color: Colors.black12)]
                      ),

                      child: Icon(MdiIcons.account,size:30.0,color:Colors.blueAccent),
                    ),

                    Text('Requests',style:TextStyle(height: 1.5,fontWeight: FontWeight.w500,color: Colors.white70))
                  ],
                ),
              ],
            ),
          ),


        SizedBox(height: 10.0,),

          Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(left: 30.0,top: 40.0,right: 30.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(50.0),topRight: Radius.circular(50.0))
              ),

              child: Container(
                
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    

                    Stack(
                  children: <Widget>[
                    Container(
                      height: 100.0,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                        //boxShadow: [BoxShadow(blurRadius: 10,offset: Offset(5, 0),color: Colors.black12)]
                      ),

                      //child: Icon(Icons.satellite,size:30.0,color:Colors.blueAccent),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text( 'Your total Earnings',style:TextStyle(height: 1.9, fontWeight: FontWeight.w500,color: Colors.black38,fontSize: 15)),
                    ),

                    Positioned(
                      top: 13,
                      
                        child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('\u20b9${_user.data['earnings']}',style:TextStyle(height: 1.5,fontWeight: FontWeight.w300,color: Colors.black26,fontSize: MediaQuery.of(context).size.width*0.11)
                      ),
                    ),

                    ),


                    Positioned(
                      right: 20,
                      top: 18,
                          child: Column(
                  children: <Widget>[
                      Container(
                        height: 60.0,
                        width: 60.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: [BoxShadow(blurRadius: 10,offset: Offset(3, 0),color: Colors.black12)]
                        ),

                        child: Icon(Icons.edit,size:30.0,color:Colors.blueAccent),
                      ),

                      Text('Hello',style:TextStyle(height: 1.5,fontWeight: FontWeight.w500,color: Colors.white70))
                  ],
                ),
                    ),
                    
                    
                    ],
                ),


                    SizedBox(height: 8,),

                          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      height: 70.0,
                      width: 70.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [BoxShadow(blurRadius: 10,offset: Offset(5, 0),color: Colors.black12)]
                      ),

                      child: Center(child: Text('${_user.data['level']}',style: TextStyle(fontWeight: FontWeight.w500, color: Colors.blueAccent,fontSize: MediaQuery.of(context).size.width*0.08,fontFamily: 'poppins'),))
                    ),

                    Text('Level',style:TextStyle(height: 1.5,fontWeight: FontWeight.w500,color: Colors.black26))
                  ],
                ),

                Column(
                  children: <Widget>[
                    Container(
                      height: 70.0,
                      width: 70.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [BoxShadow(blurRadius: 10,offset: Offset(5, 0),color: Colors.black12)]
                      ),

                      child: Center(child: Text('${_user.data['perhr']}',style: TextStyle(fontWeight: FontWeight.w500, color: Colors.blueAccent,fontSize: MediaQuery.of(context).size.width*0.08,fontFamily: 'poppins'),))
                    ),

                    Text('Per Hr',style:TextStyle(height: 1.5,fontWeight: FontWeight.w500,color: Colors.black26))
                  ],
                ),

                Column(
                  children: <Widget>[
                    Container(
                      height: 70.0,
                      width: 70.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [BoxShadow(blurRadius: 10,offset: Offset(5, 0),color: Colors.black12)]
                      ),

                      child: Center(child: Text('${_user.data['wrkcomp']}',style: TextStyle(fontWeight: FontWeight.w500, color: Colors.red,fontSize: MediaQuery.of(context).size.width*0.08,fontFamily: 'poppins'),))
                    ),

                    Text('Done',style:TextStyle(height: 1.5,fontWeight: FontWeight.w500,color: Colors.black26))
                  ],
                ),

                Column(
                  children: <Widget>[
                    Container(
                      height: 70.0,
                      width: 70.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [BoxShadow(blurRadius: 10,offset: Offset(5, 0),color: Colors.black12)]
                      ),

                      child: Center(child: Text('${_user.data['rating']}',style: TextStyle(fontWeight: FontWeight.w500, color: Colors.green[300],fontSize: MediaQuery.of(context).size.width*0.08,fontFamily: 'poppins'),))
                    ),

                    Text('Rating',style:TextStyle(height: 1.5,fontWeight: FontWeight.w500,color: Colors.black26))
                  ],
                ),


              ],
            ),

                  ],




                ),
              ),
              
            ),
          )
        ],
      )
    );
  }

  Widget topupButton(String amt)
  {
      int a =  int.parse(amt);
    return GestureDetector(
          onTap: (){
              openCheckout(a);
          },
          child: Container(
                margin: EdgeInsets.only(top: 10),
                height: 60,width: 60,
                decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle,boxShadow: [BoxShadow(blurRadius: 10,offset: Offset(2, 2),color: Colors.black12)]),
                child: Center(child: Text('\u20b9$amt',style:TextStyle(fontSize: 18,fontWeight: FontWeight.w300),),),
                ),
    );
  }
}