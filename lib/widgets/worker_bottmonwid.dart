import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class worker_bottonwid extends StatefulWidget {
  QuerySnapshot joblist;
  final Function(int) selectedinx;
  worker_bottonwid({Key key,this.joblist,this.selectedinx}) : super(key: key);

  _worker_bottonwidState createState() => _worker_bottonwidState();
}

class _worker_bottonwidState extends State<worker_bottonwid> {
  int selectedindex=-1;
  @override
  Widget build(BuildContext context) {
    return Container(
       child:   Container(
              
              padding: EdgeInsets.only(top: 1.0),
              height: 80.0,
              
              child: ListView.builder(
                itemCount: widget.joblist.documents.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context,int index)
                {
                  return GestureDetector(
                    onTap: (){
                      setState(() {
                        selectedindex=index;
                        widget.selectedinx(index);
                      }); 
                    },

                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: <Widget>[
                          Container(
                                                       height: 40.0,
                                                       width: 40.0,
                                                        decoration: new BoxDecoration(
                                                          
                                                          shape: BoxShape.circle,
                                                          image: selectedindex==index?DecorationImage(image:new AssetImage('assets/profile_wid.png')):DecorationImage(image:new AssetImage('assets/job${(index%9).toString()}.png')),
                                                          
                                                        ),

                                                        
                                                          ),

                                                          Text(widget.joblist.documents[index].data['title']),
                        ],
                      ),
                    ),

                    
                                       
                    );
                  

                
                },
              ),
            ),
    );
  }

  
}