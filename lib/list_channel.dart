import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goningumi/all_channel.dart';
import 'package:goningumi/each_channel_chat.dart';
import 'package:goningumi/riverpods.dart';
import 'package:goningumi/create_channel.dart';



// void main() => runApp(App());
//
// class App extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(home: ListChannel());
//   }
// }
//


Widget channellistTile(BuildContext context, String channel, Color color) {
  return ListTile(
    title: Text(channel),
    leading: Icon(Icons.people),
    contentPadding: EdgeInsets.all(15.0),
    tileColor: color,
    onTap: (){
      context.read(channelProvider).state=channel;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FirstPage()),
      );
    },
    trailing: Icon(Icons.more_vert),
  );
}


@override
class ListChannel extends ConsumerWidget {
  Widget build(BuildContext context, ScopedReader watch) {
    return Scaffold(
        appBar: AppBar(
          title: Text('加入チャンネル'),
        ),
        body: Center(
            child: Container(
              margin: EdgeInsets.all(5),
              child: Column(
                children: <Widget>[
                  channellistTile(
                      context, "アウトドア", Colors.red.withOpacity(0.5)),
                  const SizedBox(height: 5),
                  channellistTile(
                      context, "漫画", Colors.yellow.withOpacity(0.5)),
                  const SizedBox(height: 5),
                  channellistTile(
                      context, "音楽", Colors.blue.withOpacity(0.5)),
                  const SizedBox(height: 5),
                  channellistTile(
                      context, "野球", Colors.green.withOpacity(0.5)),
                  const SizedBox(height: 5),
                  channellistTile(
                      context, "競プロ", Colors.pink.withOpacity(0.5)),
                ],
              ),
            )
        ),
        floatingActionButton: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FloatingActionButton(
                heroTag:'hero1',
                child: Icon(Icons.search),
                onPressed: () async {
                  await Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) {
                      return AllChannel();
                    }),
                  );
                },
              ),
              SizedBox(height:5),
              FloatingActionButton(
                heroTag:'hero2',
                child: Icon(Icons.add),
                onPressed: () async {
                  await Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) {
                      return CreateChannel();
                    }),
                  );
                },
              )
            ]
        )
    );
  }
}

