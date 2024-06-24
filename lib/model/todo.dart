import 'package:flutter/material.dart';

class ToDo {
  String? id;
  String? todotext;
  bool isDone;
  ToDo({
    required this.id,
    required this.todotext,
    this.isDone = false,
  });
  static List<ToDo> todoList(){
    return[
      ToDo(id: '01', todotext: 'aaaaa',isDone: true),
      ToDo(id: '02', todotext: 'wwwww'),
      ToDo(id: '03', todotext: 'qqqqqq',isDone: true),
      ToDo(id: '04', todotext: 'eeeee',isDone: false),
    ];
  }
}