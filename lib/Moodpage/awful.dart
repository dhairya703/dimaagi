import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class awful extends StatefulWidget {
  final String moodText;

  awful({required this.moodText});

  @override
  _awfulState createState() => _awfulState();
}

class _awfulState extends State<awful> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _reviewController = TextEditingController();
  double _rating = 0.0;
  List<Todo> _todos = [];

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  void _loadTodos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? todoList = prefs.getStringList('todos');
    if (todoList != null) {
      setState(() {
        _todos = todoList.map((todo) {
          final List<String> values = todo.split(',');
          return Todo(
            rating: double.parse(values[0]),
            review: values[1],
          );
        }).toList();
      });
    }
  }

  void _saveTodos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> todoList = _todos.map((todo) {
      return '${todo.rating},${todo.review}';
    }).toList();
    prefs.setStringList('todos', todoList);
  }

  void _addTodo() {
    if (_formKey.currentState!.validate()) {
      final review = _reviewController.text;

      setState(() {
        _todos.add(Todo(
          rating: _rating,
          review: review,
        ));
        _saveTodos();
      });

      _reviewController.clear();
      _rating = 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Mind Care",

        ),
      ),
      body: SingleChildScrollView(
        child:Container(

          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/bg.jpg'),
              fit:BoxFit.fill,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                "Sorry to hear you're feeling ${widget.moodText}.",
                style: TextStyle(fontSize: 23),
              ),

              SizedBox(height: 10),
              Text("Now let's rate your anxiety:"),
              Text("0 = no anxiety, 10 = extremely anxious"),
              SizedBox(height: 20),
              Slider(
                value: _rating,
                min: 0,
                max: 10,
                divisions: 10,
                onChanged: (value) {
                  setState(() {
                    _rating = value;
                  });
                },
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text("What's going on?"),
                    Text("Describe what's going on in your life right now and/or what's on your mind."),
                    SizedBox(height: 20,),
                    Text("e.g. I have so much to do right now. I'm worried I won't be able to get it all done."),
                    Form(
                      key: _formKey,
                      child: TextFormField(
                        controller: _reviewController,
                        decoration: InputDecoration(
                          labelText: 'Write a review',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a review';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: _addTodo,
                child: Text('Submit'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TodoListPage(todos: _todos),
                    ),
                  );
                },
                child: Text('Review'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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

class Todo {
  final double rating;
  final String review;

  Todo({required this.rating, required this.review});
}

void main() {
  runApp(MaterialApp(
    home: awful(moodText: 'awful'),
  ));
}
