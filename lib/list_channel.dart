import 'package:flutter/material.dart';
import 'package:goningumi/page.dart';



// void main() => runApp(App());
//
// class App extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(home: ListChannel());
//   }
// }


class ListChannel extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return EachChannelTransition();
  }
}



class EachChannelTransition extends State<ListChannel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:<Widget> [
            FloatingActionButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                // （2） 実際に表示するページ(ウィジェット)を指定する
                  builder: (context) => FirstPage()
              ));
            }),
            Text(
                "乃木坂",
                style: TextStyle(fontSize: 24),
            ),
            FloatingActionButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                // （2） 実際に表示するページ(ウィジェット)を指定する
                  builder: (context) => FirstPage()
              ));
            }),
            Text(
              "野球",
              style: TextStyle(fontSize: 24),
            ),
            FloatingActionButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                // （2） 実際に表示するページ(ウィジェット)を指定する
                  builder: (context) => FirstPage()
              ));
            }),
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