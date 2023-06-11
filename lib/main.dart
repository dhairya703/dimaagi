import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Homepage/home.dart';
import 'Moodpage/awful.dart';
import 'Moodpage/bad.dart';
import 'Moodpage/good.dart';
import 'Moodpage/great.dart';
import 'Moodpage/ok.dart';
import 'navigation/article.dart';
import 'navigation/sharepage.dart';
import 'navigation/MeditationPage.dart';
import 'navigation/Instantcare.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _reviewController = TextEditingController();

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/homePage': (context) => InstantCare(),
        '/meditationPage': (context) => TimerScreen(),
        '/reportPage': (context) => ArticlePage(),
        '/sharePage': (context) => SharePage(),
        '/sadPage': (context) => awful(moodText: 'awful'),
        '/bad': (context) => bad(moodText: 'bad'),
        '/happyPage': (context) => ok(moodText: 'okay'),
        '/superHappyPage': (context) => good(moodText: 'good'),
        '/greatPage': (context) => great(moodText: 'great'),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}



class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController nameController = TextEditingController();

  get _todos => null;

  void saveName(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('name', name);
  }

  Future<String?> getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('name');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: getName(),
      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          // Name has been previously saved, navigate to AnotherPage
          WidgetsBinding.instance!.addPostFrameCallback((_) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Home()),
            );
          });
          return Container(); // Return an empty container while navigating
        } else {
          // Name has not been saved, show input page
          return Scaffold(
            backgroundColor: Colors.pinkAccent,
            appBar: AppBar(
               leading: Image.asset('images/logo.jpg'),
              title: Text('Mind Care'),
            ),
            body: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'Welcome!',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Please enter your name:',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Your Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),),
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () {
                      String name = nameController.text;
                      if (name.isNotEmpty) {
                        // Handle the entered name
                        print('Welcome, $name!');
                      }
                      saveName(name);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Home()),
                      );
                    },
                    child: Text('Get Started'),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}


