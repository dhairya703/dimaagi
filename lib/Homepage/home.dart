import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../Moodpage/bad.dart';
import '../Widgets/slider.dart';
import '../main.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? savedName;
  int selectedMood = 0;
  int selPage = 0;
  List<Todo> _todos = [];

  Future<String?> getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('name');
  }

  @override
  void initState() {
    super.initState();
    getName().then((name) {
      setState(() {
        savedName = name;
      });
    });
    _loadTodos();
  }

  void resetName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('name');
    setState(() {
      savedName = null;
    });
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MyHomePage()),
    );
  }

  void submitGood(int index) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/homePage');
        break;
      case 1:
        Navigator.pushNamed(context, '/meditationPage');
        break;

      case 2:
        Navigator.pushNamed(context, '/reportPage');
        break;
      case 3:
        Navigator.pushNamed(context, '/sharePage');
        break;
    }
  }

  void submitMood() {
    switch (selectedMood) {
      case 0:
        Navigator.pushNamed(context, '/sadPage');
        break;
      case 1:
        Navigator.pushNamed(context, '/bad');
        break;
      case 2:
        Navigator.pushNamed(context, '/happyPage');
        break;
      case 3:
        Navigator.pushNamed(context, '/superHappyPage');
        break;
      case 4:
        Navigator.pushNamed(context, '/greatPage');
        break;
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Mind Care',
          style: TextStyle(color: Colors.black),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Text(
                'Drawer Header',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ListTile(
              title: Text('Reset Profile'),
              onTap: () {
                resetName();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              savedName != null
                  ? Text(
                'How are you today, $savedName ?',
                style: TextStyle(fontSize: 25),
              )
                  : Text('No name saved'),
              const SizedBox(
                height: 10,
              ),
              Text("Use slider to describe how you're feeling. "),
              const SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.center,
                child: MyCircularSlider(
                  onMoodSelected: (int mood) {
                    setState(() {
                      selectedMood = mood;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: submitMood,
                      child: Text('Submit'),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Selected Mood:',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 5),
                    // Display the photo based on selected mood
                    if (selectedMood == 0)
                      Image.asset(
                        'images/awful.jpg',
                        width: 300,
                        height: 300,
                      ),
                    if (selectedMood == 1)
                      Image.asset(
                        'images/bad.jpg',
                        width: 300,
                        height: 300,
                      ),
                    if (selectedMood == 2)
                      Image.asset(
                        'images/ok.jpg',
                        width: 300,
                        height: 300,
                      ),
                    if (selectedMood == 3)
                      Image.asset(
                        'images/good.jpeg',
                        width: 300,
                        height: 300,
                      ),
                    if (selectedMood == 4)
                      Image.asset(
                        'images/great.jpg',
                        width: 300,
                        height: 300,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selPage,
        onTap: (int index) {
          setState(() {
            selPage = index;
          });
          submitGood(index); // Call submitGood with the tapped index
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.phone),
            label: 'Instant Care',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.do_not_disturb_on_total_silence),
            label: 'Meditation',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.receipt,

              size: 30,
            ),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.share,

            ),
            label: 'Share App',
          ),
        ],
      ),
    );
  }
}

class ResultPage extends StatelessWidget {
  final String moodText;

  ResultPage({required this.moodText});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result Page'),
      ),
      body: Center(
        child: Text(moodText),
      ),
    );
  }
}

class MyCircularSlider extends StatefulWidget {
  final Function(int) onMoodSelected;

  const MyCircularSlider({Key? key, required this.onMoodSelected})
      : super(key: key);

  @override
  _MyCircularSliderState createState() => _MyCircularSliderState();
}

class _MyCircularSliderState extends State<MyCircularSlider> {
  double _value = 0.0;
  List<String> labels = [
    'Awful',
    'Bad',
    'Ok',
    'Good',
    'Great',
  ];

  void _handleSliderChange(double newValue) {
    setState(() {
      _value = newValue;
    });
    final moodIndex = newValue.toInt();
    widget.onMoodSelected(moodIndex);
  }

  @override
  Widget build(BuildContext context) {
    return SleekCircularSlider(
      appearance: CircularSliderAppearance(
        size: 150,
        startAngle: 150,
        angleRange: 240,
        customWidths: CustomSliderWidths(progressBarWidth: 30),
        customColors: CustomSliderColors(
          trackColor: Colors.grey[300],
          progressBarColors: [Colors.blue, Colors.green, Colors.yellow],
          dotColor: Colors.white,
          hideShadow: true,
        ),
        infoProperties: InfoProperties(
          mainLabelStyle: TextStyle(
            color: Colors.blue,
            letterSpacing: .5,
          ),
        ),
      ),
      min: 0,
      max: 4,
      initialValue: _value,
      onChange: _handleSliderChange,
      innerWidget: (double value) {
        return Center(
          child: Text(
            labels[value.toInt()],
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
        );
      },
    );
  }
}

class Todo {
  final double rating;
  final String review;

  Todo({required this.rating, required this.review});
}
