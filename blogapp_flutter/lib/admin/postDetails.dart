import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'addEditPost.dart';
class PostDetails extends StatefulWidget {
  //const PostDetails({super.key});
final author;
PostDetails(this.author);
  @override
  State<PostDetails> createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  List post =List.empty();
  
 /* Future getAllPost (String authorname) async
 {
  var url= Uri.parse("http://192.168.1.105/uploads/getblogbyauthor.php?authorname=$authorname");
  var response=await http.get(url);
  if (response.statusCode==200)
  {
    var jsonData=jsonDecode(response.body);
    setState(() {
    post=jsonData;
    });
  }
  print(post);
 }
 void initState()
 {  super.initState();
  getAllPost (widget.author) ;

 }*/
 Future<List<dynamic>> getAllPost(String authorname) async {
  var url = Uri.parse("http://192.168.1.103/uploads/postAll.php");
var response = await http.get(url);

  if (response.statusCode == 200) {
    var jsonData = jsonDecode(response.body);
    return List<dynamic>.from(jsonData);
  } else {
    throw Exception('Bloglar getirilirken bir hata oluştu.');
  }
}
Future showUserPosts(String userName) async {
  var url = Uri.parse("http://192.168.1.103/uploads/getlogbyauthor.php");
  var response = await http.post(url, body: {'name': userName});
  
  if (response.statusCode == 200) {
    var jsonData = jsonDecode(response.body);
    return jsonData;
  }
}


void initState() {
  super.initState();
  var authorname="";
  getAllPost(widget.author).then((posts) {
    setState(() {
      post = posts;
    });
  }).catchError((error) {
    print("Hata: $error");
  });
}

 
 
  @override
  Widget build(BuildContext context) {
    return Scaffold
    (
      appBar: AppBar(title: Text('Post Details'),
      actions: 
      [
        IconButton(onPressed: ()
        {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddEditPost(author: widget.author,),),).whenComplete(() {
            getAllPost(widget.author);
            });
        }, icon: Icon(Icons.add),)
      ],
      ),
      body: ListView
      .builder(
        itemCount: post.length,
        itemBuilder: (context, index) {
        return Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile
            (
                  leading: IconButton(icon: Icon(Icons.edit,color: Colors.green,),
                  onPressed: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AddEditPost(postList: post,index: index,author: widget.author,),)).whenComplete(() 
                    {
                      getAllPost(widget.author);
                    });
                  },),
                 
            title: Text(post[index]['title']),
            subtitle: Text(post[index]['body'],maxLines: 2,),
            trailing: IconButton(icon: Icon(Icons.delete,color: Colors.red,),onPressed: ()
            {
                  showDialog(context: context, builder: (context)=>
                AlertDialog
                (
                  title: Text('message'),
                  content: Text('Are you sure you want to delete post?'),
                  actions: 
                  [
            ElevatedButton(
               style: ElevatedButton.styleFrom
                (
                  primary: Colors.red,
                ),
              onPressed: (){Navigator.pop(context);
              setState(() {
                
              });
              },
             child: Text('Cancel')),
              ElevatedButton(
               style: ElevatedButton.styleFrom
                (
                  primary: Colors.green,
                ),
              onPressed: () async 
              {
              var url=Uri.parse("http://192.168.1.103/uploads/deletePost.php");
              var response=await http.post(url,body: {"id":post[index]['id']});
              if(response.statusCode==200)
              {
                Fluttertoast.showToast(msg: 'Post Deleted Successful');
                setState(() {
                  getAllPost(widget.author);
                });
                Navigator.pop(context);
                 
              }
              },
             child: Text('Ok'))
                  ],
                ),
                );
            },),
            ),
          ),
        );
      } ,),
    );
  }
}