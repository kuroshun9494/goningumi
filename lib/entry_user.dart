import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:goningumi/riverpods.dart';

import 'list_channel.dart';

enum RadioValue { male, female }

class EntryUser extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();

  RadioValue _sex = RadioValue.male;

  var birthdayController = TextEditingController();
  var regionController = TextEditingController();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    // Providerから値を受け取る
    final accountName = watch(accountNameProvider).state;
    final email = watch(emailProvider).state;
    final password = watch(passwordProvider).state;
    final _isObscure1 = watch(obscure1Provider).state;
    final _isObscure2 = watch(obscure2Provider).state;
    final sex = watch(sexProvider).state;
    final birthday = watch(birthdayProvider).state;
    final region = watch(regionProvider).state;

    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text('新規会員登録'),
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
                  onChanged: (String value) {
                    // Providerから値を更新
                    context.read(accountNameProvider).state = value;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a account-name.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'メールアドレス',
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.blueAccent, width: 1),
                    ),
                  ),
                  onChanged: (String value) {
                    // Providerから値を更新
                    context.read(emailProvider).state = value;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a email-address.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'パスワード',
                    suffixIcon: IconButton(
                      // 文字の表示・非表示でアイコンを変える
                      icon: Icon(_isObscure1
                          ? Icons.visibility_off
                          : Icons.visibility),
                      // アイコンがタップされたら現在と反対の状態をセットする
                      onPressed: () {
                        // Providerから値を更新
                        context.read(obscure1Provider).state = !_isObscure1;
                      },
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.blueAccent, width: 1),
                    ),
                  ),
                  obscureText: _isObscure1,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a password.';
                    }
                    if (value.length <= 6) {
                      return 'password must be longer than 6 characters.';
                    }

                    return null;
                  },
                  onChanged: (String value) {
                    // Providerから値を更新
                    context.read(passwordProvider).state = value;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'パスワード確認',
                    suffixIcon: IconButton(
                      // 文字の表示・非表示でアイコンを変える
                      icon: Icon(_isObscure2
                          ? Icons.visibility_off
                          : Icons.visibility),
                      // アイコンがタップされたら現在と反対の状態をセットする
                      onPressed: () {
                        // Providerから値を更新
                        context.read(obscure2Provider).state = !_isObscure2;
                      },
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.blueAccent, width: 1),
                    ),
                  ),
                  obscureText: _isObscure2,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a password.';
                    }
                    if (value.length <= 6) {
                      return 'password must be longer than 6 characters.';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 10),
                Text('性別', style: TextStyle(fontSize: 14)),
                RadioListTile(
                  title: Text('男性'),
                  value: RadioValue.male,
                  groupValue: _sex,
                  onChanged: (value) {
                    // Providerから値を更新
                    context.read(sexProvider).state = value.toString();
                  },
                ),
                RadioListTile(
                  title: Text('女性'),
                  value: RadioValue.female,
                  groupValue: _sex,
                  onChanged: (value) {
                    // Providerから値を更新
                    context.read(sexProvider).state = value.toString();
                  },
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

                      context.read(birthdayProvider).state =
                          (DateFormat('yyyy/MM/dd')).format(date);
                    }
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a birthday.';
                    }

                    return null;
                  },
                ),
                const SizedBox(
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
                      onSelectedItemChanged: (index) {
                        context.read(birthdayProvider).state = _regions[index];
                      },
                    );
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a region.';
                    }

                    return null;
                  },
                ),
                const SizedBox(
                  //TextFormFieldどうしの隙間を空ける
                  height: 30.0,
                ),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text('登録する'),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // 入力データが正常な場合の処理
                        /*try {
                          // メール/パスワードでユーザー登録
                          final FirebaseAuth auth = FirebaseAuth.instance;
                          final result = await auth.createUserWithEmailAndPassword(
                            email: email,
                            password: password,
                          );
                          // ユーザー情報を更新
                          context.read(userProvider).state = result.user;
                          // チャット画面に遷移＋ログイン画面を破棄
                          await Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) {
                              return ListChannel();
                            }),
                          );
                        } catch (e) {
                          // Providerから値を更新
                          context.read(infoTextProvider).state =
                          "登録に失敗しました：${e.toString()}";
                        }*/
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

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
              onSelectedItemChanged: (index) {
                context.read(birthdayProvider).state = _regions[index];
              },
            ),
          ),
        );
      },
    );
  }
}
