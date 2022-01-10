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
//


class ListChannel extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return EachChannelTransition();
  }
}



Widget buttonFunction(BuildContext context) {
  return FloatingActionButton(onPressed: () {
    Navigator.push(context, MaterialPageRoute(
      // （2） 実際に表示するページ(ウィジェット)を指定する
        builder: (context) => FirstPage()
    ));
  });
}


Widget chatTitle(String title) {
  return Text(
    title,
    style: TextStyle(fontSize: 24),
  );
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
            buttonFunction(context),
            chatTitle("乃木坂"),
            buttonFunction(context),
            chatTitle("野球"),
            buttonFunction(context),
            chatTitle("音楽"),
            buttonFunction(context),
            chatTitle("乃木坂"),
            buttonFunction(context),
            chatTitle("競プロ"),
          ],
        )
      ),
    );
  }
}