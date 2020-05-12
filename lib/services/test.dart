import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shutz_ui/Models/job_list.dart';
import 'package:shutz_ui/screens/success.dart';
import 'package:shutz_ui/services/dbserv.dart';
import 'package:shutz_ui/services/jwalgo.dart';
import 'package:shutz_ui/widgets/searchresdialogue.dart';


Future<bool> showdig(context,tag,user)
{

  final msgcontroller = TextEditingController();
   
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context)
    {
      return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Container(
            height: 330.0,
            width: 200.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0)
            ),

            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 20.0,),
                    Container(
                      child: RichText(text: TextSpan(
                        text:'Search for a ',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w300,color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(text: tag,style: TextStyle(fontWeight: FontWeight.w500,color: Colors.blueAccent))
                        ])),
                        
                    ),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(10.0,15.0,10.0,5.0),
                        child: Container(
                         decoration: new BoxDecoration(
                           border:  Border.all(color: Colors.blueAccent),
                           borderRadius: BorderRadius.all(Radius.circular(10.0)),
                           //boxShadow: [new BoxShadow(blurRadius: 3.0,offset: Offset(1, 1),color: Colors.black38)]
                         ),

                         child: TextField(
                                          controller: msgcontroller,
                                          maxLength: 500,
                                          maxLines: 5,
                                          cursorColor: Colors.black,
                                          cursorWidth: 1.0,
                                          style: TextStyle(
                                            fontSize: 13.0
                                          ),
                                          textAlign: TextAlign.left,
                                          
                                          decoration: InputDecoration(
                                            
                                            hintText: 'Anything special you wanna convey?',
                                            contentPadding: const EdgeInsets.all(10.0),
                                            
                                             border: InputBorder.none,
                                            
                                            
                                          ),
                                        ),
                   ),
                      ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(10.0,0,10.0,8.0),
                    child: Container(
                      child: Text('Responsibilities Inclue doing small works like helping you with cleaning, washing etc',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 10.5
                      ),),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(10.0,0,10.0,0.0),
                    child: Container(
                      child: Text('Will Expire After 30 minutes',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 13.0,
                        color: Colors.deepPurple
                      ),),
                    ),
                  ),
                    
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        RaisedButton(
                          color: Colors.red,
                          onPressed: (){Navigator.pop(context);},
                          child: Text('Dismiss',style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Colors.white
                          ),),
                        ),

                        RaisedButton(
                          color: Colors.blueAccent,
                          onPressed: () async {
                            QuerySnapshot snapshot;
                            Navigator.pushNamed(context, '/loading');

                            // POST JOB TO DB FOR 30 MIN
                            String msg2=msgcontroller.text !=""?msgcontroller.text : null;
                            print(msg2);
                            try{
                              Job_list job_list= await DbServ().postjob(user,msg2,tag,context);
                              snapshot =await jwmatch().workerrmatch(job_list);
                              DbServ().updateloc(user.uid);
                             

                            }catch(e){print(e);}
                                print(snapshot.documents);
                          
                              if(snapshot.documents.length==0)
                              {
                               
                                print('ARUM ILLA MWONUSE!!');
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Success().successdig(context, 'Found 0 Neayby, Try again',0);
                              }
                              else{
                                Navigator.pop(context);
                                Navigator.pop(context);
                                workersearchdig(context,snapshot,user);
                             
                              }
                              
                             
                           
                            
                            
                          },
                          child: Text('Search',style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Colors.white
                          ),),
                        ),
                      ],
                    ),
                  )
                  ],
                ),
              ),
            ),
          ),
      );
    }
  );
}