import 'package:flutter/material.dart';
import 'package:shutz_ui/services/const.dart';

class profile_wid extends StatefulWidget {
  profile_wid({Key key}) : super(key: key);

  _profile_widState createState() => _profile_widState();
}

class _profile_widState extends State<profile_wid> {

  int selectindex;
  final List<String> activities=['Worker','Activity','Payment','Account'];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170.0,
         child:  ListView.builder(
          shrinkWrap: true,
         scrollDirection: Axis.horizontal,
         itemCount: 4,
         itemBuilder: (BuildContext context,int index){
           return GestureDetector(
               onTap: (){
                 setState(() {
                   selectindex=index;
                 });

                if(selectindex==0)
                {
                  Navigator.pushNamed(context, hireacceptedroute);
                } 
               
               },

               child: Padding( 
                 padding: const EdgeInsets.all(10.0),
                 child: 
                     
                     
                     Container(
                      
                     width: 120.0,
                     padding: EdgeInsets.all(20.0),
                     child: Column(
                      
                       children:<Widget>[Text(activities[index],style: TextStyle(color: Colors.black,fontSize: 15.0),)],),
                     decoration: new BoxDecoration(
                       color: Colors.white,
                       //border: Border.all(color: Colors.white),
                       image: DecorationImage(
                         image: new AssetImage('assets/profile_wid.png'),
                         fit: BoxFit.contain
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
                                                
               )
           );
         },
       ),
      );
  }
}