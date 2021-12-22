import 'package:flutter/material.dart';



void main() => runApp(App());

class App extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyApp());
  }
}


class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MoveToEachChannel();
  }
}

class MoveToEachChannel extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(

            ),
            Text(
                "音楽",
                style: TextStyle(fontSize: 24),
            ),
            FloatingActionButton(onPressed: () {}),
            Text(
                "乃木坂",
                style: TextStyle(fontSize: 24),
            ),
            FloatingActionButton(onPressed: () {}),
            Text(
              "野球",
              style: TextStyle(fontSize: 24),
            ),
            FloatingActionButton(onPressed: () {}),
            Text(
              "音楽",
              style: TextStyle(fontSize: 24),
            ),
            FloatingActionButton(onPressed: () {}),
            Text(
              "勉強",
              style: TextStyle(fontSize: 24),
            ),
            FloatingActionButton(onPressed: () {}),
          ],
        )
      ),
    );
  }
}