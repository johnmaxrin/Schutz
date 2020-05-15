import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class Dialogues{

  final CollectionReference gigworks = Firestore.instance.collection('jobs');

  Future<bool>  gigone(context)
  {
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
                Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[IconButton(icon:Icon(Icons.close,color: Colors.red,),onPressed: (){Navigator.pop(context);},)],),
                Text('Delivery Jobs',style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.w300),),
                Container(
                  margin: EdgeInsets.only(top: 10.0),
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    itemCount: 8,
                    separatorBuilder: (ctx,index){return Divider();},
                    itemBuilder: (BuildContext context,int index){
                      return 
                          
                            ListTile(leading: 
                            
                            Container(height: 40,width: 40,
                              decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/job0.png'))),
                            ), 
                            subtitle: Text('Deleiver goods from one city to another',style: TextStyle(fontSize: 12.0,),),
                            trailing: Icon(Icons.navigate_next,size: 30.0,),title: Text('Inter City',style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w300),),);
                            
                    })
                    
                  ),
                
              ],
            ),


          ),
        );
      }
    );
  }

}