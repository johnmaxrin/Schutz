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
                Container(
                 height: 300.0,
                 child: Image.asset(i==1?'assets/happy2.png':'assets/sadkoch.png',fit: BoxFit.fill,)),
                 SizedBox(height: MediaQuery.of(context).size.height*0.02),
                Text(msg,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600,color: i==1?Colors.green:Colors.redAccent),),
              ],
            ),
          )
      );
    });
}

}
