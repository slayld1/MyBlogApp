import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class AddEditCategory extends StatefulWidget {
  final categoryList;
 final index;
 AddEditCategory
 (
  {
    this.categoryList,
    this.index,
    
  }
 );


  @override
  State<AddEditCategory> createState() => _AddEditCategoryState();
}

class _AddEditCategoryState extends State<AddEditCategory> {
  TextEditingController categoryNameController=TextEditingController();
  bool editMode= false;
  Future addEditCategory()async
  {
    if(categoryNameController.text!="")
    {  if(editMode)
    {
      var url=Uri.parse("http://192.168.1.103/uploads/updateCategory.php");
      var response = await http.post
      (url,body: {"id":widget.categoryList[widget.index]['id'],"name":categoryNameController.text});
    if(response.statusCode==200)
    {
      showDialog(context: context, builder: (context)=>
      AlertDialog
      (
        title: Text('message'),
        content: Text('Category Update Successful'),
        actions: 
        [
          ElevatedButton(
             style: ElevatedButton.styleFrom
              (
                primary: Colors.red,
              ),onPressed: (){Navigator.pop(context);},
           child: Text('Cancel'))
        ],
      ),
      );
      
    }
    }
    else
    {
       var url=Uri.parse("http://192.168.1.103/uploads/addCategory.php");
      var response = await http.post
      (url,body: {"name":categoryNameController.text});
    if(response.statusCode==200)
    {
      showDialog(context: context, builder: (context)=>
      AlertDialog
      (
        title: Text('message'),
        content: Text('Category Add Successful'),
        actions: 
        [
          ElevatedButton(
             style: ElevatedButton.styleFrom
              (
                primary: Colors.red,
              ),onPressed: (){Navigator.pop(context);},
           child: Text('Cancel'))
        ],
      ),
      );
      
    }
    }

    }
  }
  @override
  void initState() {
    super.initState();
    if(widget.index!=null)
    {
      editMode=true;
      categoryNameController.text=widget.categoryList[widget.index]['name'];

    }
  }
   
  @override
  Widget build(BuildContext context) {
    return Scaffold
    (
      appBar: AppBar(
        title: Text(editMode? 'Update':'add'),
      ),
      body: Column
      (
        children: 
        [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: categoryNameController,
              decoration: InputDecoration(labelText: 'Category Name'),),
          ),
          MaterialButton(
            color: Colors.purple,
            child: Text(editMode ? 'Update':'Save',style: TextStyle(color: Colors.white),),
            onPressed: ()
            {
              addEditCategory();
            })
        ],
      ),
    );
  }
}