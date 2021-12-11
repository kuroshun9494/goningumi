import 'package:flutter/material.dart';

enum RadioValue { male, female }




class EntryUser extends StatefulWidget {
  //CreateAccountPage();
  @override
  _EntryUserState createState() => _EntryUserState();
}

class _EntryUserState extends State<EntryUser> {
  RadioValue _sex = RadioValue.male;


  void _onChanged(value) {
    setState(() {
      _sex = value;
    });
  }


  @override
  Widget build(BuildContext context) {
    // Providerから値を受け取る
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('アカウント作成'),
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'アカウント名',
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.blueAccent, width: 1),
                    ),
                  ),
                  maxLength: 10,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                Text('性別', style: TextStyle(fontSize: 14)),
                RadioListTile(
                  title: Text('男'),
                  value: RadioValue.male,
                  groupValue: _sex,
                  onChanged: (value) => _onChanged(value),
                ),
                RadioListTile(
                  title: Text('女'),
                  value: RadioValue.female,
                  groupValue: _sex,
                  onChanged: (value) => _onChanged(value),
                ),
                ElevatedButton(
                  child: Text('誕生日を設定する'),
                  onPressed: () async {
                    final date = await showDatePicker(
                      context: context,

                      //locale: const Locale("ja"), //日本語化（アプリ自体を日本語対応させる必要があります。今回は省略させていただきます）
                      initialDatePickerMode: DatePickerMode.year, //最初に年から入力させる
                      initialDate: DateTime(DateTime.now().year - 10), //最初に選択させる日付（今回は10年前）

                      firstDate: DateTime(DateTime.now().year - 100, DateTime.now().month, DateTime.now().day), //選択可能な、もっとも古い日付（今回は100年前の今日にしています）
                      lastDate: DateTime(DateTime.now().year - 6, DateTime.now().month, DateTime.now().day), ////選択可能な、もっとも新しい日付（今回は6年前の今日にしています）
                    );

                    if (date != null) {
                      //誕生日を取得した後の処理をここに書く
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
