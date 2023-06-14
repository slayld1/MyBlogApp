import 'dart:convert';

import 'package:blogapp_flutter/page/postDetails.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class TopPostCard extends StatefulWidget {
  final userEmail;
  TopPostCard({this.userEmail});

  @override
  State<TopPostCard> createState() => _TopPostCardState();
}

class _TopPostCardState extends State<TopPostCard> {
  
  List postData = List.empty();
  
  Future ShowAllPost()async
  {
    var url=Uri.parse("http://192.168.1.103/uploads/postAll.php");
    var response=await http.get(url,headers: {"Accept":"application/json"});
    if (response.statusCode==200)
    {
      var jsonData= jsonDecode(response.body);
      setState(() {
        postData=jsonData;
        
      });
      print(jsonData);
      return jsonData;
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ShowAllPost();
  }
    @override
  Widget build(BuildContext context) {
    return Container
    (
      height: 200,
      width: MediaQuery.of(context).size.width,
      color: Colors.amber,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: postData.length,
        //scrollDirection: Axis.horizontal,
        itemBuilder: (context,index)
        {
            return NewPostItem

            
            (
              postData[index]['id'],
              'http://192.168.1.103/uploads/${postData[index]['image']}',
              postData[index]['author'] ,
              postData[index]['post_date'].toString(),
              postData[index]['comments'].toString(),
              postData[index]['total_like'].toString(),
              postData[index]['title'].toString(),
              postData[index]['body'].toString(),
              postData[index]['categoryName'].toString(),
              postData[index]['create_date'].toString(),
              widget.userEmail
             
            );
          print(postData[index]['post_date']);
        }

        
        ),

    );
  }
}
class NewPostItem extends StatefulWidget {
  final id;
  final image;
  final author;
  final post_date;
  final comments;
  final total_like;
  final title;
  final body;
  final category_name;
  final create_date;
  final userEmail;
  
  NewPostItem(
    this.id,this.image,this.author,this.post_date,this.comments,this.total_like,this.title,this.body,this.category_name,this.create_date,this.userEmail);
  //const NewPostItem({super.key});
  

  @override
  State<NewPostItem> createState() => _NewPostItemState();
}

class _NewPostItemState extends State<NewPostItem> {
  @override
  Widget build(BuildContext context) {
    return  Stack
      (
        children: <Widget>
        [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container
            (
              height: 200,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration
              (
                color: Colors.amber,
                borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient
              (
                begin: Alignment.topRight,
                end: Alignment.bottomLeft ,
                colors: [Colors.amber,Colors.pink],
                ),
              ),
              
              
            ),
          ),
          Positioned(top: 30,
            left: 30,
            child: CircleAvatar
            (
              radius: 20,
              //child: Icon(Icons.person),
              backgroundImage: NetworkImage(widget.image),
              ),),
          Positioned
          (
            top: 10,
            left: 80,
            child: Text(widget.author,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontFamily: 'Nasalization')),
            
            ),
             Positioned
          (
            top: 30,
            left: 100,
            child: Text(widget.create_date,style: TextStyle(color: Colors.grey[200]),),
            
            ),
             Positioned
          (
            top: 50,
            left: 100,
            child:Icon(Icons.comment,color: Colors.white,),
            
            ),
              Positioned
          (
            top: 50,
            left: 140,
            child: Text(widget.comments,style: TextStyle(color: Colors.grey[200],fontWeight: FontWeight.bold,fontFamily: 'Nasalization'),),
            ),
               Positioned
          (
            top: 50,
            left: 170,
            child:Icon(Icons.label,color: Colors.white,),
            
            ),
               Positioned
          (
            top: 50,
            left: 200,
            child: Text(widget.total_like.toString(),style: TextStyle(color: Colors.grey[200],fontWeight: FontWeight.bold,fontFamily: 'Nasalization'),),
            
            ),
             Positioned
          (
            top: 70,
            left: 30,
            child: Text(widget.title,style: TextStyle(color: Colors.grey[200],fontWeight: FontWeight.bold,fontFamily: 'Nasalization'),),
            
            ),
            Positioned
          (
            top: 146,
            left: 30,
            child:Icon(Icons.arrow_back,color: Colors.white,),
            
            ),
             Positioned
             (
            top: 150,
            left: 60,
            child: 
            InkWell
            (child: Text(
              "Read More",
              style: TextStyle
              (color: Colors.grey[200],
              fontFamily: 'Nasalization'
              ),
              ),
              onTap:(){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> PostDetails
                  (
                    id:widget.id,
                   title: widget.title,
                    image:widget.image,
                   
                    body:widget.body,
                    author:widget.author,
                   post_date: widget.post_date,
                    userEmail:widget.userEmail,

                  ),),);
                        } ,
              ),
            
            ),
        ],
      );
    
  }
}