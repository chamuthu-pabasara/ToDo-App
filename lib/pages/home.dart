import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo__app/model/todo.dart';
import 'package:todo__app/widgets/todoitem.dart';

class HomePage extends StatefulWidget {
   HomePage({super.key}) ;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final todoList = ToDo.todoList();
  List<ToDo> _foundtodo = [];
  final _tofocontroller = TextEditingController();

  @override
  void initState(){
    _foundtodo = todoList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(236, 212, 255, 1),
      appBar: _buildAppbar(),
      body:  Stack(
        children:[ Container(
          padding: EdgeInsets.symmetric(horizontal: 20 ,vertical: 15),
          child:Column(children: [serchbox(),
          Expanded(
            child: ListView(
              children: [Container(
                margin: EdgeInsets.only(top: 50,bottom: 20),
                child: Text(
                  'All ToDos',style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              for(ToDo toDoo in _foundtodo.reversed)
              ToDoItems(toDo: toDoo,onToDoChange: _handleTodoChange,
              onDeleteItem: _deletetodoitem,),
              ],
            ),
          )
          ],
          ),
          ),
         Align(
          alignment: Alignment.bottomCenter,
          child: Row(children: [
            Expanded(child: Container(
              margin: EdgeInsets.only(
                bottom: 20,
                right: 20,
                left: 20,
              ),
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 0.0),
                  blurRadius: 10.0,
                  spreadRadius: 0.0,
                )],
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: _tofocontroller,
                decoration: InputDecoration(
                  hintText: 'Add new ToDo item',
                  border: InputBorder.none,
                ),
              ),
            )),
            Container(
              margin: EdgeInsets.only(bottom: 20,right: 20),
              child: ElevatedButton(
                child: Text('+',style: TextStyle(fontSize: 40,color: Colors.white),),
                onPressed: (){
                  _addtodoitem(_tofocontroller.text);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 44, 73, 220),
                 // minimumSize: Size(60, 60),
                  elevation: 10,
                ),
              ),
            )
          ],),
         )
          ]
      ),
    );
  }

void _handleTodoChange(ToDo){
  setState(() {
    ToDo.isDone = !ToDo.isDone ;
  });
}
void _deletetodoitem(String id){
  setState(() {
    todoList.removeWhere((item) => item.id == id);
  });

}
void _addtodoitem (String toDo){
  setState(() {
    todoList.add(ToDo(id: DateTime.now().microsecondsSinceEpoch.toString(), todotext: toDo));
  });
  _tofocontroller.clear();

}
void _runfilter (String enteredkeyword){
  List<ToDo> results = [];
  if(enteredkeyword.isEmpty){
    results = todoList;
  }else{
    results = todoList.where((item) => item.todotext!.toLowerCase().contains(enteredkeyword.toLowerCase())).toList();
  }
  setState(() {
    _foundtodo = results ;
  });
}


  Widget serchbox(){
    return Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20)
          ),
          child:  TextField(
            onChanged: (value) => _runfilter(value),
            decoration: InputDecoration(contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(Icons.search,size: 20,),
            prefixIconConstraints: BoxConstraints(
              maxHeight: 20,
              maxWidth: 20,
            ),
            border: InputBorder.none,
            hintText: 'Search',
            hintStyle: TextStyle(color: Colors.grey)
            )
            
          ),
        );
  }

  AppBar _buildAppbar() {
    return AppBar(
      elevation: 0,
    backgroundColor:  Color.fromRGBO(236, 212, 255, 1),
    title:  Row (
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
      Icon(Icons.menu,
      color: Colors.black,
      size: 30,),
      Icon(Icons.person,
      size: 50,
      color: Color.fromARGB(255, 0, 0, 0),
      )
    
    ],));
  }
}