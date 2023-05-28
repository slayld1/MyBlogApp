import 'dart:convert';

import 'package:blogapp_flutter/page/postDetails.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RecentPostItem extends StatefulWidget {
  const RecentPostItem({super.key});

  @override
  State<RecentPostItem> createState() => _RecentPostItemState();
}

class _RecentPostItemState extends State<RecentPostItem> {
 List recentPost = List.empty();
  
  Future recentPostData()async
  {
    var url=Uri.parse("http://192.168.1.105/uploads/postAll.php");
    var response=await http.get(url,headers: {"Accept":"application/json"});
    if (response.statusCode==200)
    {
      var jsonData= jsonDecode(response.body);
      setState(() {
        recentPost=jsonData;
        
      });
      print(jsonData);
      return jsonData;
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    recentPostData();
  }
 
  @override
  Widget build(BuildContext context) {
    return 
    Container(
      height: 200,
   child: ListView.builder
    (
      itemCount: recentPost.length,
      itemBuilder: (context,index)
      {
        return RecentItem
        (
          'http://192.168.1.105/uploads/${recentPost[index]['image']}',
           recentPost[index]['author'],
           recentPost[index]['title'],
           recentPost[index]['body'],
           recentPost[index]['create_date'],

          
           
          
        );
      }
      ),
    );
  }

}
class RecentItem extends StatefulWidget {
  final image;
  final author;
  final title;
  final body;
  final create_date;
  RecentItem(this.image,this.author,this.title,this.body,this.create_date);
  

  @override
  State<RecentItem> createState() => _RecentItemState();
}

class _RecentItemState extends State<RecentItem> {
  @override
  Widget build(BuildContext context) {
    return Container
    (
      child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>
      [
        Column
        (
          children: <Widget>
          [
            Padding(
                  padding:const EdgeInsets.all(8.0),
                  child:
                   InkWell(
                    onTap: ()
                    {
                      Navigator.push(
                        context, 
                        MaterialPageRoute
                        (
                          builder: (context)=>PostDetails
                          (
                    title:widget.title,
                    image:widget.image,
                   
                    body:widget.body,
                     author:widget.author,
                    post_date:widget.create_date
                  )));
                      debugPrint(widget.title);
                    },
                     child: Container(
                      width: 300,
                       child: Text
                       (
                        widget.title,
                       style: TextStyle
                       (fontSize: 20,fontFamily: 'Nasalization'),),
                     ),
                   ),
            ),
            Padding(
            padding: EdgeInsets.all(8.0),
           child: Row
            (
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
             Padding
             (
              padding: const EdgeInsets.all(8.0),
                child: Text
                (
                  widget.author,style: TextStyle(color: Colors.grey),),),
        
              ],
            ),
           ),
           Padding(
            padding: EdgeInsets.all(0.0),
           child: Row
            (
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
             Padding
             (
              padding: const EdgeInsets.all(0.0),
                child: Text("posted on: "+widget.create_date,style: TextStyle(color: Colors.grey),),),
       
              ],
            ),
           ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(0.0),
          child: Container
          (
            padding: EdgeInsets.all(0.0),
            child: Image.network(widget.image,height: 70,width: 70,),
          ),
        ),
      ],
      ),
    );
  }
}