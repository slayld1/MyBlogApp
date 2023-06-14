import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class AddEditPost extends StatefulWidget {
  final postList;
  final index;
  final author;

  AddEditPost({this.postList, this.index, this.author});

  @override
  State<AddEditPost> createState() => _AddEditPostState();
}

class _AddEditPostState extends State<AddEditPost> {
  File? _image;
  final picker = ImagePicker();

  String? selectedCategory;
  List categoryItem = [];
TextEditingController author = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController body = TextEditingController();
  bool editMode = false;

  Future choiceImage() async {
    var pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  Future addEditPost() async {
    if (editMode) {
      var uri = Uri.parse("http://192.168.1.103/uploads/updatePost.php");
      var request = http.MultipartRequest("POST", uri);
      request.fields['title'] = title.text;
      request.fields['body'] = body.text;
      request.fields['author'] = author.text;
      request.fields['category_name'] = selectedCategory!;
      if (_image != null) {
        var pic = await http.MultipartFile.fromPath('image', _image!.path);
        request.files.add(pic);
      }
      var response = await request.send();
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: 'Post Update Successful');
        Navigator.pop(context);
        print(title.text);
      }
    } else {
      var uri = Uri.parse("http://192.168.1.103/uploads/addPost.php");
      var request = http.MultipartRequest("POST", uri);
      request.fields['title'] = title.text;
      request.fields['body'] = body.text;
      request.fields['author'] = widget.author;
      request.fields['category_name'] = selectedCategory!;
      if (_image != null) {
        var pic = await http.MultipartFile.fromPath('image', _image!.path);
        request.files.add(pic);
      }
      var response = await request.send();
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: 'Post Add Successful');
        Navigator.pop(context);
        print(title.text);
      }
    }
  }

  Future getAllCategory() async {
    var url = Uri.parse("http://192.168.1.103/uploads/categoryAll.php");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      setState(() {
        categoryItem = jsonData;
      });
    }
    print(categoryItem);
  }

  @override
  void initState() {
    super.initState();
    _image = null;
    getAllCategory();
    if (widget.index != null) {
      editMode = true;
      title.text = widget.postList[widget.index]['title'];
      body.text = widget.postList[widget.index]['body'];
      selectedCategory = widget.postList[widget.index]['category_name'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(editMode ? 'Update' : 'Add Post'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(
8.0),
          child: TextField
          (
            controller: title,
            decoration: InputDecoration(labelText: 'Post Title'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField
          (
            controller: body,
            maxLines: 4,
            decoration: InputDecoration(labelText: 'Post Body'),
          ),
        ),
         Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField
          (
            controller: body,
            maxLines: 1,
            decoration: InputDecoration(labelText: 'Author Name'),
          ),
        ),
        IconButton(onPressed: ()
        {
         choiceImage();
        }, icon: Icon(Icons.image,size: 50,),),
       SizedBox(height: 20,),

    
     
     
     editMode ? Container
     (child: Image.network("http://192.168.1.103/uploads/${widget.postList[widget.index]['image']}"),width: 100,height: 100,): Text('data'),
            SizedBox(height: 20,),

      Container
       (
        child: _image==null? Center(child: Text('No image selected')): Image.file(_image!),width: 100,height: 100,
       ),
        SizedBox(height: 20,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButton(
            isExpanded: true,
            value: selectedCategory,
            hint: Text('Select Category'),
            items: categoryItem.map((category)
            {
              return DropdownMenuItem
              (
                value: category['name'],
                child: Text(category['name']));
            }).toList(),
             onChanged: (Object ? newValue ){
              
              setState(() {
              
              selectedCategory=newValue as String? ;
            }
            );
            }
            ),
        ),
         SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              
               style: ElevatedButton.styleFrom
              (
                primary: Colors.purple,
              ),onPressed: ()
              {
                  addEditPost();
                  
              },
               child: Text('Save Post')),
          )
        ],
      ),
    );
  }
}