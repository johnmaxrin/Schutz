import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shutz_ui/Models/user.dart';
import 'package:shutz_ui/services/dbserv.dart';
import 'package:shutz_ui/services/phoneverification.dart';
import 'package:shutz_ui/services/test.dart';

class home_jobselect extends StatefulWidget {
  User user;
  home_jobselect({Key key,this.user}) : super(key: key);

  _home_jobselectState createState() => _home_jobselectState();
}

class _home_jobselectState extends State<home_jobselect> {
   
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(

        stream: Firestore.instance.collection('home_job').snapshots(),
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot)
        {
          if(!snapshot.hasData) return CircularProgressIndicator();
          return jobsection(data: snapshot.data.documents,user: widget.user,);
        },
          
    );
  }
}



class jobsection extends StatefulWidget {
  final List<DocumentSnapshot> data;
  final User user;
  
  
  jobsection({Key key,this.data,this.user}) : super(key: key);

  _jobsectionState createState() => _jobsectionState();
}

class _jobsectionState extends State<jobsection> {
  @override
  Widget build(BuildContext context) {
     int selectedindex=0;

    return  Container(
         child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Container(
                                  
                                   height: 100.0,
                                  
                                  decoration: BoxDecoration(
                                   
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.topRight,
                                      colors: [Color(0xff5979EC),Color(0xff00E3B3)]
                                    ),
                                    borderRadius:BorderRadius.only(topRight: Radius.circular(35.0),topLeft: Radius.circular(35.0)),
                                  ),

                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: widget.data.length,
                                    itemBuilder: (BuildContext context,int index){
                                      return GestureDetector(
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
                                        
                                        child: Column(

                                        children: <Widget>[

                                          
                                          Expanded(
                                              child: Padding(
                                              padding: const EdgeInsets.fromLTRB(10, 30, 0, 0),
                                              child: Column(
                                                children: <Widget>[
                                                  
                                                 Container(
                                                 height: 40.0,
                                                 width: 40.0,
                                                  decoration: new BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    image: DecorationImage(image:new AssetImage('assets/job${(index%9).toString()}.png'))
                                                    //image: DecorationImage(image:new NetworkImage(widget.data[index].data['icon'].toString()))
                                                  ),
                                                    ),
                                                  
                                                  //Icon(Icons.account_circle,size:50.0,color: index==selectedindex?Colors.white70 : Colors.white,),
                                                  Text(widget.data[index].data['title'].toString(),
                                                  style: TextStyle(
                                                    color:Colors.white,
                                                 fontSize:12.0,
                                                 
                                                 letterSpacing: 1
                                                  ),),
                                                  
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                          ),
                                       
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
      );
  }
}