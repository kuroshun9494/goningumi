import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum RadioValue { male, female }

class EntryUser extends StatefulWidget {
  //CreateAccountPage();
  @override
  _EntryUserState createState() => _EntryUserState();
}

class _EntryUserState extends State<EntryUser> {
  RadioValue _sex = RadioValue.male;
  var birthdayController = TextEditingController();
  var regionController = TextEditingController();

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
          title: Text('アカウント登録'),
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
                  title: Text('男性'),
                  value: RadioValue.male,
                  groupValue: _sex,
                  onChanged: (value) => _onChanged(value),
                ),
                RadioListTile(
                  title: Text('女性'),
                  value: RadioValue.female,
                  groupValue: _sex,
                  onChanged: (value) => _onChanged(value),
                ),
                TextFormField(
                  controller: birthdayController,
                  decoration: InputDecoration(
                    labelText: '誕生日',
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.blueAccent, width: 1),
                    ),
                  ),
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,

                      locale: const Locale("ja"),
                      //日本語化（アプリ自体を日本語対応させる必要があります。今回は省略させていただきます）
                      initialDatePickerMode: DatePickerMode.year,
                      //最初に年から入力させる
                      initialDate: DateTime(DateTime.now().year - 10),
                      //最初に選択させる日付（今回は10年前）

                      firstDate: DateTime(DateTime.now().year - 100,
                          DateTime.now().month, DateTime.now().day),
                      //選択可能な、もっとも古い日付（今回は100年前の今日にしています）
                      lastDate: DateTime(
                          DateTime.now().year - 6,
                          DateTime.now().month,
                          DateTime.now()
                              .day), ////選択可能な、もっとも新しい日付（今回は6年前の今日にしています）
                    );

                    if (date != null) {
                      //誕生日を取得した後の処理をここに書く
                      setState(() {
                        birthdayController.text =
                            (DateFormat('yyyy/MM/dd')).format(date);
                      });
                    }
                  },
                ),
                SizedBox(
                  //TextFormFieldどうしの隙間を空ける
                  height: 20.0,
                ),
                TextFormField(
                    controller: regionController,
                    decoration: InputDecoration(
                      labelText: 'お住まいの地域',
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blueAccent, width: 1),
                      ),
                    ),
                    onTap: () {
                      // キーボードが出ないようにする
                      FocusScope.of(context).requestFocus(new FocusNode());
                      _showModalPicker(context);
                      CupertinoPicker(
                        itemExtent: 40,
                        children: _regions.map(_pickerRegion).toList(),
                        onSelectedItemChanged: _onSelectedRegionChanged,
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
  String _selectedRegion = 'none';

  final List<String> _regions = [
    '北海道',
    '青森',
    '秋田',
    '岩手',
    '山形',
    '仙台',
  ];

  Widget _pickerRegion(String str) {
    return Text(
      str,
      style: const TextStyle(fontSize: 32),
    );
  }

  void _onSelectedRegionChanged(int index) {
    setState(() {
      regionController.text = _regions[index];
    });
  }
  void _showModalPicker(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height / 3,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: CupertinoPicker(
              itemExtent: 40,
              children: _regions.map(_pickerRegion).toList(),
              onSelectedItemChanged: _onSelectedRegionChanged,
            ),
          ),
        );
      },
    );
  }
}

