import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../admin/addEditPost.dart';

class PostListPage extends StatefulWidget {
  final String authorName;

  PostListPage({required this.authorName});

  @override
  _PostListPageState createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage> {
  List<dynamic> posts = [];

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    final response = await http.get(Uri.parse('http://192.168.1.103/uploads/getblogbyauthor.php?authorname=${widget.authorName}'));
    if (response.statusCode == 200) {
      setState(() {
        posts = json.decode(response.body);
      });
    } else {
      print('Veriler alınırken bir hata oluştu: ${response.reasonPhrase}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Listesi'),
      actions: 
      [
        IconButton(onPressed: ()
         {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddEditPost(author: widget.authorName,),),).whenComplete(() {
            fetchPosts();
            });
        },  icon: Icon(Icons.add))
      ],
      ),
      
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: IconButton(icon: Icon(Icons.edit,color: Colors.green,),
               onPressed: ()
               {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AddEditPost(postList: post,index: index,author: widget.authorName,))).whenComplete(() => fetchPosts());
               },
              ),
              title: Text(posts[index]['title']),
              subtitle: Text(posts[index]['body'],maxLines: 2,),
              trailing: IconButton(icon: Icon(Icons.delete,color: Colors.red,),
              onPressed: ()
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
                  fetchPosts();
                });
                Navigator.pop(context);
                 
              }
              },
             child: Text('Ok'))
                  ],
                ),
                );
                
        }),
            ),
            ),
          );
        },
      ),
    );
  }
}
