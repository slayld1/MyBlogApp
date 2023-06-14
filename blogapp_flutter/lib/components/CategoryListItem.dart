import 'dart:convert';

import 'package:blogapp_flutter/page/SelectCategoryBy.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../page/postDetails.dart';
class CategoryListItem extends StatefulWidget {
  const CategoryListItem({super.key});

  @override
  State<CategoryListItem> createState() => _CategoryListItemState();
}

class _CategoryListItemState extends State<CategoryListItem> {
  
  List categories= List.empty();
  Future getAllCategory()async
  {
    var url= Uri.parse("http://192.168.1.103/uploads/categoryAll.php");
    var response =await http.get(url);
    if(response.statusCode==200){
      var jsonData=jsonDecode(response.body);
      setState(() {
        categories=jsonData; 
      });
    }
  }
  @override
  void initState()
  {
    super.initState();
    getAllCategory();
  }


  Widget build(BuildContext context) {
    return Container
    (
      height: 70,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context,index)
      {
        return CategoryItem(category_name: categories[index]['name'],);
      }
      ),
    );
  }


}
class CategoryItem extends StatefulWidget {
  //const CategoryItem({super.key});
  final category_name;
  CategoryItem({this.category_name});

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          child: 
            InkWell
            (
              //height: 70,
              child:  Text(widget.category_name,style: TextStyle(color:Colors.grey,fontSize: 16,fontWeight: FontWeight.bold),),
              onTap: ()
              {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SelectCategoryBy(widget.category_name),  ));
                debugPrint( widget.category_name);
              },
              ),
            ),
          
        ),
      );
      
    
  }
}
class NewPostItem extends StatefulWidget {
  final image;
  final author;
  final post_date;
  final comments;
  final  total_like;
  final title;
  final body;
  final category_name;
  final create_date;
  NewPostItem(this.image,this.author,this.post_date,this.comments,this.total_like,this.title,this.body,this.category_name,this.create_date);
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
                    title:widget.title,
                    image:widget.image,
                   
                    body:widget.body,
                     author:widget.author,
                    post_date:widget.post_date
                  

                  ),));
                        } ,
              ),
            
            ),
        ],
      );
    
  }
}