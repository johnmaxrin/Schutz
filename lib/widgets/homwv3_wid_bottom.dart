import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class bottom_stream extends StatefulWidget {
  bottom_stream({Key key}) : super(key: key);

  _bottom_streamState createState() => _bottom_streamState();
}

class _bottom_streamState extends State<bottom_stream> {
  @override
  Widget build(BuildContext context) {
    return  StreamBuilder(
      stream: Firestore.instance.collection('Trending').snapshots(),
      builder: (BuildContext ctx,AsyncSnapshot<QuerySnapshot> snap){
          if(!snap.hasData)
          {
            
            return Container(child: Center(child: CircularProgressIndicator(),),);
          }

          else{
           
            return homev3_bottomlist(data2: snap.data.documents,);
          }
      },
    );
  }
}

class homev3_bottomlist extends StatefulWidget {
  final List<DocumentSnapshot> data2;
 
  homev3_bottomlist({Key key,this.data2}) : super(key: key);

  _homev3_bottomlistState createState() => _homev3_bottomlistState();
}

class _homev3_bottomlistState extends State<homev3_bottomlist> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
          child: ListView.builder(
        scrollDirection: Axis.horizontal,
       itemCount: widget.data2.length,
        itemBuilder: (BuildContext ctx,int inde){
          return CachedNetworkImage(
            fadeInDuration: Duration(seconds: 3),
            imageUrl: widget.data2[inde].data['image'],
            imageBuilder: (ctx,img)=>
          Padding(
                     padding: const EdgeInsets.only(left: 5.0,right:5.0,bottom: 8.0),
                     child: Container(
                      
                       width: 150.0,
                       decoration: new BoxDecoration(
                          image: DecorationImage(image: img,fit: BoxFit.cover),
                         color: Colors.red,
                         borderRadius: BorderRadius.circular(20)
                       ),
                     child: Stack(

                       children: <Widget>[
                         Positioned(
                           bottom: 33,
                           right: 20,
                           child: Text('CYCLE',style: TextStyle(fontSize: 28.0,color: Colors.white70),),
                         ),

                         Positioned(
                           bottom: 20,
                           right: 20,
                           child: Text('\u20b910/Hr',style: TextStyle(fontSize: 15.0,color: Colors.white70),),
                         ),


                         Positioned(
                           top: 20,
                           right: 20,
                           child: Icon(MdiIcons.starCircle,color: Colors.greenAccent,)
                         ),
                       ],
                     ),
                     ),
          )
                   );  
        },
      ),
    );
  }
}



