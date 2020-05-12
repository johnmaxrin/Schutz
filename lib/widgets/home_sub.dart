import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shutz_ui/Models/user.dart';
import 'package:shutz_ui/services/dbserv.dart';
import 'package:shutz_ui/services/test.dart';

class home_sub extends StatefulWidget {
  User user;
  home_sub({Key key,this.user}) : super(key: key);

  _home_subState createState() => _home_subState();
}

class _home_subState extends State<home_sub> {

    int selectedindex;


  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
          stream: Firestore.instance.collection('home_feed').snapshots(),
          builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot)
          {
            if(!snapshot.hasData) return CircularProgressIndicator();
            return home_subwid(data:snapshot.data.documents,user: widget.user,);
          }
         
    );
  }
}

class home_subwid extends StatefulWidget {
  User user;
  final List<DocumentSnapshot> data;
  home_subwid({Key key,this.data,this.user}) : super(key: key);

  _home_subwidState createState() => _home_subwidState();
}

class _home_subwidState extends State<home_subwid> {
  @override
  Widget build(BuildContext context) {
    return Container(
         child:  Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        padding: EdgeInsets.only(top:0),
                        itemCount: widget.data.length,
                        itemBuilder: (ctx,int index)
                        { 
                          return Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Card(
                             shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(15.0)
                             ),
                            elevation: 2.0,
                            child: Container(
                              
                              padding: EdgeInsets.fromLTRB(0, 0, 10, 10),
                              child: ListTile(
                                 onTap: ()async
                              {
                                          Navigator.pushNamed(context, '/loading');
                                          bool a= await DbServ(uid:widget.user.uid).checkphone().whenComplete(()=>Navigator.pop(context));
                                            if(a!=null)
                                                showdig(context,widget.data[index].data['job_title'],widget.user);
                                              else{
                                                Navigator.pushNamed(context, '/phoneconst',arguments: widget.user);
                                              }},
                                leading: 
                                
                                // CachedNetworkImage(
                                    
                                //     imageUrl: widget.data[index].data['image'].toString(),
                                //     imageBuilder: (context,img)=>
                                Container(

                                    width: 50.0,
                                    height: 50.0,
                                    decoration: new BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                      boxShadow: [BoxShadow(
                                        blurRadius: 2.0,
                                        
                                      )],
                                    image: DecorationImage(
                                      image: NetworkImage(widget.data[index].data['image'].toString())
                                    )
                                    ),
                                   ),
                                  
                                title: Text(widget.data[index].data['title'].toString()),
                                subtitle: Text(widget.data[index].data['sub'].toString()),
                              ),
                            ),
                          ),
                            );
                        },
                      ),
                      
                      ),
      );
  }
}