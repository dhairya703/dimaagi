import 'package:flutter/material.dart';

import '../Moodpage/ok.dart';
class TodoListPage extends StatelessWidget {
  final List<Todo> todos;

  TodoListPage({required this.todos});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          final todo = todos[index];
          return ListTile(
            title: Text('Rating: ${todo.rating.toStringAsFixed(1)}'),
            subtitle: Text('Review: ${todo.review}'),
          );
        },
      ),
    );
  }
}