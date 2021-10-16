import 'package:flutter/material.dart';
import 'package:goningumi/group_menu.dart';
//import 'package:goningumi/main.dart';

class NewGroup extends StatefulWidget {
  NewGroup();

  //final String name ="";

  @override
  _NewGroupState createState() => _NewGroupState();
}

class _NewGroupState extends State<NewGroup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('新規グループ作成'),
      ),
      body: Container(
        // 余白を付ける
        padding: EdgeInsets.all(64),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // テキスト入力
            TextField(),
            const SizedBox(height: 8),
            Container(
              // 横幅いっぱいに広げる
              width: double.infinity,
              // リスト追加ボタン
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/group_menu');
                },
                child: Text('グループ追加', style: TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              // 横幅いっぱいに広げる
              width: double.infinity,
              // キャンセルボタン
              child: TextButton(
                // ボタンをクリックした時の処理
                onPressed: () {
                  // "pop"で前の画面に戻る
                  Navigator.of(context).pop();
                },
                child: Text('キャンセル')import 'package:flutter/material.dart';
              import 'package:goningumi/group_menu.dart';
              import 'package:goningumi/new_group.dart';
//import 'package:goningumi/main.dart';

              class GroupMenu extends StatefulWidget {
              GroupMenu();

              //final String name ="";

              @override
              _GroupMenuState createState() => _GroupMenuState();
              }

                class _GroupMenuState extends State<GroupMenu> {
              @override
              Widget build(BuildContext context) {
              return Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
              title: Text('グループメニュー'),
              ),
              body: SafeArea(
              child: ListView(
              children: const <Widget>[
              ListTile(
              leading: Icon(Icons.sports_soccer),
              title: Text('サッカー'),
              ),
              ListTile(
              leading: Icon(Icons.sports_baseball),
              title: Text('野球'),
              ),
              ListTile(
              leading: Icon(Icons.sports_baseball),
              title: Text('バスケ'),
              ),
              ],
              ),
              ),
              floatingActionButton: FloatingActionButton(
              onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewGroup()),
              ),
              child: Icon(Icons.add_box),
              ),
              );
              //
              }
              }

                ,
              ),
            ),
          ],
        ),
      ),
    );
    //
  }
}

