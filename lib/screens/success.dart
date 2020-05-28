import 'package:flutter/material.dart';









class Success
{
  Future<bool> successdig(context,msg,i)
{

 
    return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context)
    {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Container(
            height: 400.0,
            width: 300.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0)
            ),
            child: Column(
              
              children: <Widget>[
                Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[IconButton(icon:Icon(Icons.close,color:Colors.red),onPressed: (){Navigator.pop(context);},),],),
                SizedBox(height: 50,),
                Container(
                 height: 200.0,
                 child: Image.asset(i==1?'assets/happy2.png':'assets/sadkoch.png',fit: BoxFit.fill,)),
                 SizedBox(height: MediaQuery.of(context).size.height*0.07),

                 Expanded( child: Container(width: 300.0, 
                 decoration: BoxDecoration(
                   color: i==1?Colors.green:Colors.redAccent,
                   borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.0),bottomRight: Radius.circular(20.0)),
                 ),
                 child: Center(child: Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 13),
                   child: Text( msg,textAlign: TextAlign.center, style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600,color:Colors.white),),
                 )),),)
                
              ],
            ),
          )
      );
    });
}

}
