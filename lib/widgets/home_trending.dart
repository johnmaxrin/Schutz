import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shutz_ui/Models/user.dart';
import 'package:shutz_ui/services/dbserv.dart';
import 'package:shutz_ui/services/test.dart'; 

class home_trending extends StatefulWidget {
  User user;
  home_trending({Key key, this.user}) : super(key: key);

  _home_trendingState createState() => _home_trendingState();
}

class _home_trendingState extends State<home_trending> {
  int selectedindex;
 

  @override
  Widget build(BuildContext context) {
    
    return StreamBuilder(
          stream: Firestore.instance.collection('Trending').snapshots(),
          builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot)
          {
                      if(!snapshot.hasData) return CircularProgressIndicator();
                      return trendingwid(data: snapshot.data.documents,user: widget.user,);
          }
           
    );
  }
}


class trendingwid extends StatefulWidget {
  final User user;
  final List<DocumentSnapshot> data;
  trendingwid({Key key,this.data,this.user}) : super(key: key);


  _trendingwidState createState() => _trendingwidState();
}

class _trendingwidState extends State<trendingwid> {
   int selectedindex=-1;
  @override
  Widget build(BuildContext context) {
    return Container(
         child: 
                     Container(
                      //color: Colors.red,
                      height: 180.0,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.data.length,
                        itemBuilder: (BuildContext context,int index){
                          return GestureDetector(
                              onTap: (){
                                setState(() {
                                  selectedindex=index;
                                });
                              },

                              child: Padding( 
                                padding: const EdgeInsets.all(8.0),
                                child: 
                                    
                                    
                                    GestureDetector(
                                        onTap: () async{




                                          setState(() {
                                            selectedindex=index;
                                          });
                                          Navigator.pushNamed(context, '/loading');
                                          bool a= await DbServ(uid:widget.user.uid).checkphone().whenComplete(()=>Navigator.pop(context));
                                            if(a!=null)
                                                showdig(context,widget.data[index].data['title'],widget.user);
                                              else{
                                                Navigator.pushNamed(context, '/phoneconst',arguments: widget.user);
                                              }

                                        },
                                        child: CachedNetworkImage(
                                        fadeInDuration: Duration(seconds: 3),
                                        imageUrl: widget.data[index].data['image'].toString(),
                                        imageBuilder:(context,img)=>Container(
                                        width: 130.0,
                                        padding: EdgeInsets.all(10.0),
                                        child: Center(child: Text(widget.data[index].data['title'].toString(),style: TextStyle(color: Colors.white,fontSize: 25.0,fontFamily: 'Brusher',letterSpacing: 1),)),
                                        decoration: new BoxDecoration(
                                      
                                          image: DecorationImage(
                                            image:img,
                                            fit: BoxFit.cover
                                          ),
                                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                          boxShadow: [
                             new BoxShadow(
                               color: Colors.black54,
                               blurRadius: 6.0
                             )
                           ]
                                        ),
                                        ),
                                        //placeholder: (context,url)=>Center(child: CircularProgressIndicator(),),
                                        errorWidget: (context,url,err)=>Center(child: Icon(Icons.error,color:Colors.red)),
                                      ),
                                    ),
                                                               
                              )
                          );
                        },
                      ),
                     ),
      );
  }
}