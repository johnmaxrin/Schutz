import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shutz_ui/services/dbserv.dart';
import 'package:shutz_ui/widgets/v3_gig_digs.dart';

class homev3_sub_wid extends StatefulWidget {
  homev3_sub_wid({Key key}) : super(key: key);

  _homev3_sub_widState createState() => _homev3_sub_widState();
}







class _homev3_sub_widState extends State<homev3_sub_wid> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection('jobs').snapshots(),
      builder: (BuildContext ctx,AsyncSnapshot<QuerySnapshot> snap){
          if(!snap.hasData)
          {
            return Container(child: Center(child: CircularProgressIndicator(),),);
          }

          else{
            return homev3_list(data: snap.data.documents,);
          }
      },
    );
  }
}

class homev3_list extends StatefulWidget {
  final List<DocumentSnapshot> data;
  homev3_list({Key key,this.data}) : super(key: key);

  _homev3_listState createState() => _homev3_listState();
}

class _homev3_listState extends State<homev3_list> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
       child: ListView.builder(
         scrollDirection: Axis.horizontal,
         itemCount: widget.data.length,

         itemBuilder: (BuildContext ctx,int index)
         {
           return CachedNetworkImage(
             fadeInDuration: Duration(seconds: 3),
             imageUrl: widget.data[index].data['image'],
             imageBuilder: (ctx,img)=>GestureDetector(

                            onTap: () async{

                              FirebaseUser user =await FirebaseAuth.instance.currentUser();
                              print(user.displayName);
                              DbServ().updateloc(user.uid);
                              bool a = await DbServ(uid: user.uid).checkphone();
                              if(a==true){
                              Navigator.pushNamed(context, '/loading');
                              QuerySnapshot query = await Firestore.instance.collection('jobs').document(widget.data[index].data['uid']).collection('sub').getDocuments(); 
                              Navigator.pop(context);
                              Dialogues().gigone(context,widget.data[index].data['name'],query);
                              }
                              else
                                Navigator.pushNamed(context, '/phoneconst',arguments: user);


                            },

                            child: Container(
                       margin: EdgeInsets.only(top: 10.0,left: 5.0,right: 5.0),
                       decoration: BoxDecoration(
                         image: DecorationImage(image: img,fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.red
                       ),
                       height: 200,
                       width: 350,
                       child: Stack(
                         children: <Widget>[
                            Positioned(
                             bottom: 40,
                             right: 35,
                             child: Text(widget.data[index].data['name'].toString().toUpperCase(),style: TextStyle(fontSize: 30.0,color: Colors.white,fontWeight: FontWeight.w300),)),

                            Positioned(top: 20,right: 35,child: Icon(MdiIcons.checkCircle,size: 20,color: Colors.white,),),

                            Positioned(
                             bottom: 25,
                             right: 35,
                             child: Text('\u20b950 per hour',style: TextStyle(fontSize: 18.0,color: Colors.white70),)),


                         ],
                       ),
                     ),
             ),

                   placeholder: (ctx,url)=>Container(height: 200,width: 350, child: Center(child: CircularProgressIndicator())),
           );
           
           
         },
       ),
    );
  }
}