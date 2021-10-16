import 'package:flutter/material.dart';
import 'package:goningumi/group_menu.dart';
//import 'package:goningumi/main.dart';

class NewGroup extends StatefulWidget {
  NewGroup();

  @override
  _NewGroupState createState() => _NewGroupState();
}

class _NewGroupState extends State<NewGroup> {
  _NewGroupState(this._GroupTexts);

  List _GroupTexts = [];
  var textController = TextEditingController();

  //List _GroupTexts = [];

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
            TextField(
              controller: textController,
            ),

            const SizedBox(height: 8),
            Container(
              // 横幅いっぱいに広げる
              width: double.infinity,
              // リスト追加ボタン
              child: ElevatedButton(
                onPressed: () => setState(
                  () {
                    _GroupTexts.add(textController.text);
                    print(_GroupTexts);
                    Navigator.of(context).pushReplacementNamed('/group_menu');
                  },
                ),
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
                child: Text('キャンセル'),
              ),
            ),
          ],
        ),
      ),
    );
    //
  }
}
