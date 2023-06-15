import 'dart:convert';
//import 'dart:html';

import 'package:blogapp_flutter/admin/addEditCategory.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class CategoryDetails extends StatefulWidget {
  const CategoryDetails({super.key});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
 List category= List.empty();

 Future getAllCategory () async
 {
  var url= Uri.parse("http://192.168.1.103/uploads/categoryAll.php");
  var response=await http.get(url);
  if (response.statusCode==200)
  {
    var jsonData=jsonDecode(response.body);
    setState(() {
    category=jsonData;
    });
  }
  print(category);
 }
 void initState()
 {  super.initState();
 getAllCategory();

 }
 
 
  @override
  Widget build(BuildContext context) {
    return Scaffold
    (
      appBar: AppBar
      (
        title: Text('Kategori Detayları'),
        actions:[
        IconButton(onPressed: ()
        {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddEditCategory(),),);
        }, icon: Icon(Icons.add),)],
        ),
        
      
  body:  ListView.builder(
    itemCount: category.length,
    itemBuilder: (context, index) 
  {
    return Card(
      elevation: 2,
      child: ListTile(
        leading: IconButton(onPressed: ()
        {
          Navigator.push(context,MaterialPageRoute(builder: (context)=>AddEditCategory(categoryList: category,index: index,)));
        },icon: Icon(Icons.edit),),
        title: Text(category[index]['name']),
        trailing:  IconButton(onPressed: ()async
        {
          var url= Uri.parse("http://192.168.1.103/uploads/deleteCategory.php");
          var response= await http.post(url, body: {"id":category[index]['id']});
          if(response.statusCode==200)
          {
             showDialog(context: context, builder: (context)=>
      AlertDialog
      (
        title: Text('message'),
        content: Text('Category Deleted Successful'),
        actions: 
        [
          ElevatedButton(
             style: ElevatedButton.styleFrom
              (
                primary: Colors.red,
              ),
            onPressed: (){Navigator.pop(context);},
           child: Text('Cancel'))
        ],
      ),
      );
      
          }
        },icon: Icon(Icons.delete),),
        ),
    );
  }),
    );
  }
}