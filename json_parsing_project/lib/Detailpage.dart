import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Model/Data.dart';
class Detail extends StatefulWidget {
  Data data;
  Detail(this.data);
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Data"),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Image.network(
                  widget.data.url,
                  height: 250.0,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 10.0,),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                          child:CircleAvatar(
                            child: Text(widget.data.id.toString()),
                          ) ),
                      SizedBox(height: 10.0,),
                      Expanded(
                        flex: 2,
                          child:Text(widget.data.toString()) )
                    ],
                  ),
                )
              ],
            ),
            
          )
        ],
      ),
    );
  }
}
