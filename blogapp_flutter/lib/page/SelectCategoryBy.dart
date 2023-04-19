import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../components/CategoryListItem.dart';
class SelectCategoryBy extends StatefulWidget {
  //const SelectCategoryBy({super.key});
  final category_name;
  SelectCategoryBy(this.category_name);

  @override
  State<SelectCategoryBy> createState() => _SelectCategoryByState();
}

class _SelectCategoryByState extends State<SelectCategoryBy> {
  List categoryByPost = List.empty();
  Future categoryByDate()async
   {
    var url=Uri.parse("http://192.168.1.100/uploads/categoryByPost.php");
    var response=await http.post(url,body:{'name': widget.category_name});
    if(response.statusCode==200){
      var jsonData=jsonDecode(response.body);
      setState(() {
        categoryByPost=jsonData;

      });
    }
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold
    (
      appBar: AppBar(title: Text(widget.category_name),),
      body: Container
      (
        child: ListView.builder(
          itemCount: categoryByPost.length,
          itemBuilder: (context,index)
        {

          return NewPostItem
            (
              'http://192.168.1.100/${categoryByPost[index]['image']}',
              categoryByPost[index]['author'] ,
              categoryByPost[index]['post_date'].toString(),
              categoryByPost[index]['comments'].toString(),
              categoryByPost[index]['totalLike'].toString(),
              categoryByPost[index]['title'].toString(),
              categoryByPost[index]['body'].toString(),
              categoryByPost[index]['categoryName'].toString(),
              categoryByPost[index]['createDate'].toString(),
             
            );
        }
        ),
      )
    );
  }
}