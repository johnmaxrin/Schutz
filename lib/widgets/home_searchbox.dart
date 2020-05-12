import 'package:flutter/material.dart';

class home_search extends StatefulWidget {
  home_search({Key key}) : super(key: key);

  _home_searchState createState() => _home_searchState();
}

class _home_searchState extends State<home_search> {
  @override
  Widget build(BuildContext context) {
    return Center(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 90),
                          height: 60.0,
                          width: 270.0,
                          child: 
                            Container(
                             
                              decoration: BoxDecoration(
                                color: Color(0xf2ffffff),
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.all(Radius.circular(30))
                              ),
                              child: TextField(
                                cursorColor: Colors.black,
                                cursorWidth: 1.0,
                                style: TextStyle(
                                  fontSize: 14.0
                                ),
                                textAlign: TextAlign.left,
                                
                                decoration: InputDecoration(
                                  
                                  hintText: 'What are you Looking for?',
                                  contentPadding: const EdgeInsets.all(20.0),
                                 
                                   border: InputBorder.none,
                                  suffixIcon: Icon(Icons.search,color: Colors.black,),
                                  
                                ),
                              ),
                            )
                            
                          
                          
                        ),
                      
    );
  }
}