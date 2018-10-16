import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http; 
void main() async{

  List _posts= await getPosts();
  
  runApp(new MaterialApp(
    home: new Scaffold(
      appBar: new AppBar(
        title: new Text("data"),
        centerTitle: true,
        ),
        body: Center(
          child: new ListView.builder(
            itemBuilder: (BuildContext context, int position) {
              if (position.isOdd) return new Divider();
              final index= position ~/2;
              return new ListTile(
                title: new Text('${_posts[index]['title']}',
                style: new TextStyle(fontSize: 16.0),),
                subtitle: new Text('${_posts[index]['body']}',
                style: new TextStyle(
                    fontStyle: FontStyle.italic,fontSize: 12.0,color: Colors.grey),),
                leading: new CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                  child: new Text("${_posts[index]['title'][0]}",
                  style: new TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),

                onTap: () {_alert(context, "${_posts[index]['title']}");} ,
              );
            },
            
            padding: const EdgeInsets.all(8.0),
            itemCount: _posts.length,
            ),
        ),
        )
      ),
    );
  }

  void _alert(BuildContext context, String msg){
     var alert=new AlertDialog(
       title: new Text('app'),
       content: new Text(msg),
       actions: <Widget>[
         new FlatButton(
           onPressed: () {Navigator.pop(context);},
           child: new Text('ok'),
         )
       ],
     );

     showDialog(context: context, builder: (context) => alert);
  }

Future<List> getPosts() async {
    String postsURL="https://jsonplaceholder.typicode.com/posts";

    http.Response response= await http.get(postsURL);

    return json.decode(response.body);

}
