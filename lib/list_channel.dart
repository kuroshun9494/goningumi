import 'package:flutter/material.dart';
import 'package:goningumi/each_channel_chat.dart';



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


Widget channellistTile(BuildContext context, String title, Color color) {
  return ListTile(
    title: Text(title),
    leading: Icon(Icons.people),
    contentPadding: EdgeInsets.all(15.0),
    tileColor: color,
    onTap: (){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FirstPage()),
      );
    },
    trailing: Icon(Icons.more_vert),
  );
}



class EachChannelTransition extends State<ListChannel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('チャンネル一覧'),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(5),
          // padding: EdgeInsets.all(5),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children:<Widget> [
              channellistTile(context, "アウトドア", Colors.red.withOpacity(0.5)),
              const SizedBox(height: 5),
              channellistTile(context, "漫画", Colors.yellow.withOpacity(0.5)),
              const SizedBox(height: 5),
              channellistTile(context, "音楽", Colors.blue.withOpacity(0.5)),
              const SizedBox(height: 5),
              channellistTile(context, "野球", Colors.green.withOpacity(0.5)),
              const SizedBox(height: 5),
              channellistTile(context, "競プロ", Colors.pink.withOpacity(0.5)),
            ],
          ),
        )
      ),
    );
  }
}

/*
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
*/
