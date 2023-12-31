

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/Screens/HomeScreen.dart';
class ViewToDo extends StatefulWidget {
  Map<String,dynamic> document;
  final String? id;
  ViewToDo({Key? key,required this.document,required this.id}):super(key:key);

  @override
  State<ViewToDo> createState() => _ViewToDoState();
}

class _ViewToDoState extends State<ViewToDo> {
  TextEditingController? _titleController;
  TextEditingController? _descriptionController;
  String? type;
  String? category;
  bool? edit=false;
  final CollectionReference _collectionReference =
  FirebaseFirestore.instance.collection('ToDo');
  void initState(){
    super.initState();
    String title=widget.document["title"]==null?"Hey There":widget.document["title"];
    _titleController=TextEditingController(text: title);
    _descriptionController=TextEditingController(text: widget.document["description"]);
    type=widget.document["task"];
    category=widget.document["category"];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors:[
            Color(0xff1d1e26),
            Color(0xff252041),
          ]
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30.0,left: 20.0),
                child: Row(

                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(onPressed: (){
                      Navigator.pop(
                        context,
                        MaterialPageRoute(builder: (context)=>HomeScreen()),
                      );
                    }, icon: Icon(CupertinoIcons.arrow_left,color: Colors.white,size: 30.0,)
                    ),
                    Spacer(),
                    IconButton(
                        onPressed: (){
                          _collectionReference.doc(widget.id).delete();
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.delete,color: Colors.red,size: 25.0,),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: IconButton(
                          onPressed: (){
                            setState(() {
                              edit=!edit!;

                            });
                          },
                          icon:Icon(Icons.edit,size: 25.0,color: edit!?Colors.green:Colors.white,),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      edit!?"Editing":"View",
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 4,
                      ),
                    ),
                    Text(
                      "Your ToDo",
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 4,
                      ),
                    ),
                    label("Task Title"),
                    SizedBox(height: 15.0,),
                    Container(
                      height: 55,
                      decoration: BoxDecoration(
                        color: Color(0xff2a2e3d),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: TextFormField(
                        controller: _titleController,
                        enabled: edit!,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Task Title",
                          hintStyle: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          labelStyle: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          contentPadding: EdgeInsets.only(left:10.0,right: 10.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 30.0,),
                    label("Task Type"),
                    SizedBox(height: 10.0,),
                    Row(
                      children: [
                        taskSelect("Important",0xff2664fa),
                        SizedBox(width: 15.0,),
                        taskSelect("Planned",0xff2bc8d9),
                      ],
                    ),
                    SizedBox(height: 15.0,),
                    label("Description"),
                    SizedBox(height: 15.0,),
                    Container(
                      height: 75,
                      decoration: BoxDecoration(
                        color: Color(0xff2a2e3d),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: TextFormField(
                        controller: _descriptionController,
                        enabled: edit!,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Description",
                          hintStyle: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,

                          ),
                          labelStyle: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          contentPadding: EdgeInsets.only(left:10.0,right: 10.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 15.0,),
                    label("Category"),
                    SizedBox(height: 10.0,),
                    Wrap(
                      runSpacing: 10.0,
                      children: [
                        categorySelect("Food", 0xffff6d6e),
                        SizedBox(width: 10.0,),
                        categorySelect("Workout", 0xfff29732),
                        SizedBox(width: 10.0,),
                        categorySelect("Work", 0xff6557ff),
                        SizedBox(width: 10.0,),
                        categorySelect("Design", 0xff234ebd),
                        SizedBox(width: 10.0,),
                        categorySelect("Run", 0xff2bc8d9),
                      ],
                    ),
                    SizedBox(height: 30.0,),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          try {
                            String? title = _titleController?.text;
                            String? description = _descriptionController?.text;

                            await _collectionReference.doc(widget.id).update({
                              'title': title,
                              'task': type,
                              'description': description,
                              'category': category,
                            });

                            Navigator.pop(context);
                          } catch (e) {
                            print('Error adding data to Firestore: $e');
                            // Handle the error as needed
                          }
                        },

                        style: ElevatedButton.styleFrom(
                          primary: Colors.purple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        child: Text('UPDATE TODO',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 17.0),),
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget label(String label) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 17.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
  Widget categorySelect(String label,int color) {
    return InkWell(
      onTap: edit!?() {
        setState(() {
          category=label;
        });
      }:null,
      child: Chip(
        backgroundColor: category == label ? Color(0xff2a2e3d) : Color(color),
        label: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
    Widget taskSelect(String label,int color){
      return InkWell(
        onTap: edit!?(){
          setState(() {
            type=label;
          });
        }:null,
        child: Chip(
          backgroundColor:type==label?Color(0xff2a2e3d):Color(color),
          label:Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17.0,
              color: Colors.white,
            ),
          ),
        ),
      );

  }
}
