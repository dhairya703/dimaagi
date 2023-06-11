import 'package:flutter/material.dart';
class SharePage extends StatelessWidget {
  const SharePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("About us"),),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Yash sharma 22BCE1038",style: TextStyle(fontSize: 29),),
            Text("Dhairya Garg 22BPS1050",style: TextStyle(fontSize: 29),),
          ],
        ),
      ),
    );
  }
}
