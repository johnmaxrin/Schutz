
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shutz_ui/screens/success.dart';
import 'package:shutz_ui/services/dbserv.dart';
import 'package:shutz_ui/widgets/notifications.dart';


class Dialogues{




Future<QuerySnapshot> getuser(title) async
{
 QuerySnapshot user = await Firestore.instance.collection('users').where('job_title',arrayContains:'$title').getDocuments().whenComplete(()=>print('done'));
  return user;
  
}

//////////////////////////////GIG ZERO//////////////////////////////////////


Future<bool>  gigzero(context, QuerySnapshot query)
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
              Text('Look for a Gigger',style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.w300),),
                Container(
                  margin: EdgeInsets.only(top: 10.0),
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
                              Dialogues().gigone(context,list[index]['name'],query);
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


  /////////////GIG ONE//////////////////////////////////


  Future<bool>  gigone(context,title, QuerySnapshot query)
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
                Text(title,style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.w300),),
                Container(
                  margin: EdgeInsets.only(top: 10.0),
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
                            subtitle: Text(list[index]['jobdesc'].toString(),style: TextStyle(fontSize: 12.0,),),
                            trailing: Icon(Icons.navigate_next,size: 30.0,),title: Text(list[index]['jobname'],style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w300),),
                            onTap: () async{

                              Navigator.popAndPushNamed(context, '/workerres',arguments: list[index]['jobname']);




                              //  Navigator.pushNamed(context, '/loading');
                              //  QuerySnapshot data = await getuser(list[index]['jobname']).whenComplete(()=>Navigator.pop(context));
                              //  Navigator.pop(context);
                              //  Dialogues().gigtwo(context,list[index]['jobname'],data);
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


///////////////////////GIG TWO ////////////////////////



////////////////////////////////////////EARN HERE ////////////////////////////////////////////////////

Future<bool>  fabearn(context)
{
  return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext ctx)
      {
        return Dialog(
          elevation: 10,
          
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
            child: Container(
              height: MediaQuery.of(context).size.height/3,
              width: MediaQuery.of(context).size.width/3,
              
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(20.0)
            
              ),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(

                    onTap: ()  {

                          Navigator.popAndPushNamed(context, '/workerdash');
                    },

                      child: Container(
                     
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0,),topRight: Radius.circular(20.0))
                      ),
                      height: MediaQuery.of(context).size.height/6,
                      child: Center(child: 
                      
                            Text('Wokr Here',style: TextStyle(
                              color: Colors.white,
                              fontSize: 25.0,
                              fontFamily: 'poppins',
                              fontWeight: FontWeight.w300
                            ),),),
                      
                    ),
                  ),

                  Expanded(
                    child: GestureDetector(
                      onTap: (){Notificationpre().showflush(context, 'Currently not available in your city.');},
                                          child: Container(
                       
                       decoration: BoxDecoration(
                         color: Colors.blueAccent,
                         borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.0),bottomRight: Radius.circular(20.0))
                       ),
                       height: MediaQuery.of(context).size.height/2,
                       child: Center(child: 
                      
                            Text('Rent Things',style: TextStyle(
                              color: Colors.white,
                              fontSize: 25.0,
                              fontFamily: 'poppins',
                              fontWeight: FontWeight.w300
                            ),),),
                       
                      ),
                    ),
                  ),
                  
                ],
              ),
                          )
          );
}
  );
}


}