import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shutz_ui/Models/user.dart';
import 'package:shutz_ui/services/dbserv.dart';
import 'package:shutz_ui/widgets/notifications.dart';



class V3WorkerDash extends StatefulWidget {
  V3WorkerDash({Key key}) : super(key: key);

  _V3WorkerDashState createState() => _V3WorkerDashState();
}




class _V3WorkerDashState extends State<V3WorkerDash> {
 DocumentSnapshot _user;
  UserV3 userV3;
  Razorpay _razorpay;
  double bal;
  int amt = 0;

    void fetecUsers()async {
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      DocumentSnapshot query = await Firestore.instance.collection('users').document(user.uid).get();
       UserV3 userV3t  =  UserV3.fromSnapshot(query);
      
      setState(() {
       userV3 = userV3t;
      _user = query;
      bal = userV3.bal;
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
      'key': 'rzp_live_AAE4PDy8iVpHpe',
      'amount':topup*100,
      'name': 'Work topup',
      'description' : 'Topup to continue using work platform',
      'prefill' : {'contact' : userV3.phone,'email':userV3.email},
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
    Navigator.of(context).pop();
    Notificationpre().showflush(context, 'Payment Success!!');
    updateamt();
   
  }

  void _handlePaymentError(PaymentFailureResponse response){
    print('DHEY SAMBHAVAM EVIDE OND'+response.message);
    Navigator.of(context).pop();
    Notificationpre().showflush(context, 'Something went wrong try again later!');
  }

  void _handlePaymentWallet(ExternalWalletResponse response){
    Notificationpre().showflush(context, 'Payment External Wallet!');
  }

  void updateamt() async
  {
    setState(() {
      double res = bal+amt;
      userV3.bal = res.toDouble();
      bal = res.toDouble();
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






///////////////////////////////// DIALOGUE ////////////////////////////////////////////////

Future<bool>  skill1(context, QuerySnapshot query,List list2)
  {
    
    List list = query.documents.toList();

      return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext ctx)
      {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Container(

            padding: EdgeInsets.only(left: 10,right: 10),
            height: MediaQuery.of(context).size.height * 0.67,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.white
            ),

            child: Column(
              children: <Widget>[
                SizedBox(height: 30.0,),
              Text('Works you are ready to do',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w300),),
                Container(
                  margin: EdgeInsets.only(top: 30.0),
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    itemCount: list.length,
                    separatorBuilder: (ctx,index){return Divider();},
                    itemBuilder: (BuildContext context,int index){
                      return 
                          
                            ListTile(leading: 
                            
                            Container(height: 40,width: 40,
                              decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/$index.png'))),
                            ), 
                            subtitle: Text(list[index]['name'].toString(),style: TextStyle(fontSize: 12.0,),),
                            trailing: Icon(Icons.navigate_next,size: 30.0,),title: Text(list[index]['name'].toString(),style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w300),),
                            onTap: () async{
                              Navigator.pushNamed(context, '/loading');
                              QuerySnapshot query = await Firestore.instance.collection('jobs').document(list[index]['uid']).collection('sub').getDocuments(); 
                              Navigator.pop(context);
                              Navigator.pop(context);
                              skill2(context,list[index]['name'],query,list2);
                            },
                            );
                            
                    })
                    
                  ),
                
              ],
            ),


          ),
        );
      }
    );
  }



  Future<bool>  skill2(context,title, QuerySnapshot query,List list2)
  {
   List cjobs = list2;
    print(cjobs);
    List list = query.documents.toList();

      return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext ctx)
      {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: StatefulBuilder(
            builder: (context,setState){

                      return Container(

              padding: EdgeInsets.only(left: 10,right: 10),
              height: MediaQuery.of(context).size.height * 0.72,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white
              ),

              child: Column(
                children: <Widget>[
                  SizedBox(height: 30.0,),
                  Text(title,style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.w300),),
                  Container(
                    margin: EdgeInsets.only(top: 10.0),
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: ListView.separated(
                      scrollDirection: Axis.vertical,
                      
                      itemCount: list.length,
                      separatorBuilder: (ctx,index){return SizedBox(height: 10,);},
                      itemBuilder: (BuildContext context,int index){
                        return 
                            
                              ListTile(
                                leading: 
                              Container(height: 40,width: 40,

                                decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/$index.png'))),
                              ), 
                              subtitle: Text(list[index]['jobdesc'].toString(),style: TextStyle(fontSize: 12.0,),),
                              trailing: Icon(cjobs.contains(list[index]['jobname'])?Icons.radio_button_checked:Icons.radio_button_unchecked,size: 30.0,color: list2.contains(list[index]['jobname'])?Colors.blueAccent:Colors.black38,),title: Text(list[index]['jobname'],style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w300),),
                              onTap: () {
                                
                               setState((){

                                 if(!cjobs.contains(list[index]['jobname']))
                                 cjobs.add((list[index]['jobname']));

                                 else
                                 cjobs.remove(list[index]['jobname']);
                               print(cjobs);
                               });
                               
 
                              },
                              );
                              
                      })
                      
                    ),

                    Expanded(child: 
                      GestureDetector(
                        onTap: ()async{
                           Navigator.pushNamed(context, '/loading');
                           FirebaseUser user = await FirebaseAuth.instance.currentUser();
                           await Firestore.instance.collection('users').document(user.uid).updateData({"job_title":FieldValue.delete()}).whenComplete((

                           ){

                             Firestore.instance.collection('users').document(user.uid).updateData({"job_title":FieldValue.arrayUnion(cjobs)});
                             fetecUsers();
                             Navigator.pop(context);Navigator.pop(context);
                             
                           },);

                        },
                            child: Container(
                          margin: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            boxShadow: [BoxShadow(blurRadius: 10.0,offset: Offset(5, 5),color: Colors.black12)],
                            borderRadius: BorderRadius.circular(10.0)
                          ),
                          child: Center(child: Text('Update',style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.height*0.025),),),
                          ),
                      ),)

                    
                ],
              ),


            );}
          ),
        );
      }
    );
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
            else if(userV3.status=='available' )
            {
              await Firestore.instance.collection('users').document(_user.data['uid']).updateData({"status":'not available'}).whenComplete((){
                setState(() {
                  userV3.status='not available';
                });
                Notificationpre().showflush(context, 'Status Updated! You are not working currently');
              });
            }

             else if(userV3.status=='working'){
                Notificationpre().showflush(context, 'You are currently working');
              }

            else if(userV3.status=='not available'|| userV3.status=='Enrolled'){

              if(bal<=0){
                Notificationpre().showflush(context, 'Kindly topup to Work More');
              }

              else{
              DbServ().updateloc(userV3.uid);
              await Firestore.instance.collection('users').document(_user.data['uid']).updateData({"status":'available'}).whenComplete((){
                setState(() {
                  userV3.status='available';
                });
                Notificationpre().showflush(context, 'Status Updated! You are working ');
              });
              }

            }
            
        },
        backgroundColor: userV3.status == 'available' ? Colors.red : userV3.status == 'working' ? Colors.purpleAccent : Colors.blueAccent,
        child: userV3.status=='available'? Text('Stop'): userV3.status == 'working' ? Text('Working',style: TextStyle(fontSize: 10),): Text('Start')
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
                              skill1(context,query,userV3.jobs);
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
                    GestureDetector(
                      onTap: (){
                         Navigator.pushNamed(context, '/myrequests');
                      },
                          child: Container(
                        height: 60.0,
                        width: 60.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: [BoxShadow(blurRadius: 10,offset: Offset(5, 5),color: Colors.black12)]
                        ),

                        child: Stack(
                          children: <Widget>[
                            Center(child: Icon(MdiIcons.account,size:30.0,color:Colors.blueAccent)),
                            Positioned(
                              right: 15,top: 12,
                              child: Icon(Icons.brightness_1,color:userV3.rcnt==true?Colors.red :Colors.white,size: 9,),
                            )
                          ],
                        ),
                      ),
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

                      child: Center(child: Text('${_user.data['level'].toString()}',style: TextStyle(fontWeight: FontWeight.w500, color: Colors.blueAccent,fontSize: MediaQuery.of(context).size.width*0.08,fontFamily: 'poppins'),))
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

                      child: Center(child: Text('${_user.data['perhr'].toString()}',style: TextStyle(fontWeight: FontWeight.w500, color: Colors.blueAccent,fontSize: MediaQuery.of(context).size.width*0.08,fontFamily: 'poppins'),))
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

                      child: Center(child: Text('${_user.data['works_completed'].toString()}',style: TextStyle(fontWeight: FontWeight.w500, color: Colors.red,fontSize: MediaQuery.of(context).size.width*0.08,fontFamily: 'poppins'),))
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

                      child: Center(child: Text('${_user.data['rating'].toString()}'=='0'?'${_user.data['rating'].toString()}'
                      :(_user.data['rating']/_user.data['nrating']).toStringAsFixed(1)
                      ,style: TextStyle(fontWeight: FontWeight.w500, color: Colors.green[300],fontSize: MediaQuery.of(context).size.width*0.08,fontFamily: 'poppins'),))
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