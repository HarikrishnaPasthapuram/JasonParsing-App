import'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import'Model/Data.dart';
import 'Detailpage.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<MaterialColor>_color=[Colors.deepOrange,Colors.blue,Colors.yellow,Colors.green,Colors.brown,Colors.pink,Colors.deepPurple,Colors.red];
  Future<List<Data>> getAllData() async{
    var api="https://jsonplaceholder.typicode.com/photos";
    var data=await http.get(api);
    var jsonData=json.decode(data.body);
    List<Data>listOf=[];
    for (var i in jsonData){
      Data data=Data(i["id"],i["title"],i["url"],i["thumbnailurl"]);
      listOf.add(data);
    }
    return listOf;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Json Parsing App"),
        actions: <Widget>[
          IconButton(
              icon:Icon(Icons.search),
              onPressed: (){
                debugPrint('Search');
              }),
          IconButton(icon: Icon(Icons.add),
              onPressed: (){
                debugPrint("add");
              })
        ],
      ),
      drawer: Drawer(
        child:ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Jaffa"),
              accountEmail: Text("Jaffa@gmail.com"),
              decoration: BoxDecoration(
                  color: Colors.blue
              ),

            ),
            ListTile(
              title: Text("first page"),
              leading: Icon(Icons.search,color: Colors.red,),
              onTap: (){
                Navigator.of(context).pop();
              },

            ),
            ListTile(
              title: Text("Second page"),
              leading: Icon(Icons.add,color: Colors.green,),
              onTap: (){
                Navigator.of(context).pop();
              },

            ),
            ListTile(
              title: Text("third page"),
              leading: Icon(Icons.title,color: Colors.blue,),
              onTap: (){
                Navigator.of(context).pop();
              },

            ),
            ListTile(
              title: Text("first page"),
              leading: Icon(Icons.list,color: Colors.yellow,),
              onTap: (){
                Navigator.of(context).pop();
              },

            ),
            Divider(
              height: 7.0,
            ),
            ListTile(
              title: Text("close"),
              leading: Icon(Icons.close,color: Colors.red,),
              onTap: (){
                Navigator.of(context).pop();
              },

            )

          ],
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10.0),
            height: 250.0,
            child: FutureBuilder(
              future: getAllData(),
                builder:(BuildContext c,AsyncSnapshot snapshot){
                  if(snapshot.data==null){
                    return Center(
                      child: Text("Loading Data......."),
                    );
                  }else{
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext c,int index){
                        MaterialColor mColor=_color[index % _color.length];
                        return Card(
                          elevation: 10.0,
                          child: Column(
                            children: <Widget>[
                              Image.network(snapshot.data[index].url,
                              height: 150.0,
                                width: 150.0,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(height: 7.0,),
                              Container(
                                margin: EdgeInsets.all(6.0),
                                height: 50.0,
                                child:Row(
                                  children: <Widget>[
                                    Container(
                                        child:CircleAvatar(
                                          child: Text(snapshot.data[index].id.toString()),
                                          backgroundColor: mColor,
                                          foregroundColor: Colors.white,

                                        ),
                                    ),
                                    SizedBox(
                                      width: 6.0,
                                    ),
                                    Container(
                                      width: 80.0,
                                      child: Text(snapshot.data[index].title,
                                      maxLines: 1
                                      ),

                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  }
                }
            ),
          ),
          SizedBox(height: 7.0,),
          Container(
            margin: EdgeInsets.all(10.0),
            height: MediaQuery.of(context).size.height,
            child: FutureBuilder(
              future: getAllData(),
                builder:(BuildContext c, AsyncSnapshot snapshot){
                if (snapshot.data==null){
                  return Center(
                    child:Text("Loading Data.....") ,
                  );
                }else{
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder:(BuildContext c,int index){
                        MaterialColor mColor=_color[index % _color.length];
                        return Card(
                          elevation: 7.0,
                          child: Container(
                            height: 80.0,
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child:Image.network(
                                    snapshot.data[index].url,
                                    height: 60.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: 6.0,),
                                Expanded(
                                    flex: 2,
                                    child:InkWell(
                                      child: Text(
                                        snapshot.data[index].title,
                                        maxLines: 2,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      onTap: (){
                                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext c)=>Detail(snapshot.data[index])));
                                      },
                                    ) ),
                                Expanded(
                                    flex: 1,
                                    child:Align(
                                      alignment: Alignment.center,
                                      child: CircleAvatar(
                                        child: Text(snapshot.data[index].id.toString()),
                                        backgroundColor: mColor,
                                        foregroundColor: Colors.white,
                                      ),
                                    ) )
                              ],
                            ),
                          ),
                        );
                      }
                  );

                }

                }),
          )
        ],
      ),

    );
  }
}




