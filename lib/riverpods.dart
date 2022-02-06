import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ユーザー情報の受け渡しを行うためのProvider
final userProvider = StateProvider((ref) {
  return FirebaseAuth.instance.currentUser;
});

// エラー情報の受け渡しを行うためのProvider
// ※ autoDisposeを付けることで自動的に値をリセットできます
final infoTextProvider = StateProvider.autoDispose((ref) {
  return '';
});

// メールアドレスの受け渡しを行うためのProvider
// ※ autoDisposeを付けることで自動的に値をリセットできます
final emailProvider = StateProvider.autoDispose((ref) {
  return '';
});

// アカウント名の受け渡しを行うためのProvider
// ※ autoDisposeを付けることで自動的に値をリセットできます
final userNameProvider = StateProvider((ref) => '');

// パスワードの受け渡しを行うためのProvider
// ※ autoDisposeを付けることで自動的に値をリセットできます
final passwordProvider = StateProvider.autoDispose((ref) {
  return '';
});

// パスワード1表示非常時の状態の受け渡しを行うためのProvider
// ※ boolean型で宣言、初期値はfalse
final obscure1Provider = StateProvider<bool>((ref) {
  return false;
});

// パスワード2表示非常時の状態の受け渡しを行うためのProvider
// ※ boolean型で宣言、初期値はfalse
final obscure2Provider = StateProvider<bool>((ref) {
  return false;
});

// 性別の受け渡しを行うためのProvider
// ※ autoDisposeを付けることで自動的に値をリセットできます
final sexProvider = StateProvider.autoDispose((ref) {
  return '';
});

// 誕生日の受け渡しを行うためのProvider
// ※ autoDisposeを付けることで自動的に値をリセットできます
final birthdayProvider = StateProvider.autoDispose((ref) {
  return '';
});

// 地域の受け渡しを行うためのProvider
// ※ autoDisposeを付けることで自動的に値をリセットできます
final regionProvider = StateProvider.autoDispose((ref) {
  return '';
});

final channelProvider = StateProvider((ref) => '');

// メッセージの受け渡しを行うためのProvider
// ※ autoDisposeを付けることで自動的に値をリセットできます
final messageTextProvider = StateProvider.autoDispose((ref) {
  return '';
});

final postsQueryProvider = StreamProvider.autoDispose((ref) {
  return FirebaseFirestore.instance
      .collection('posts')
      .orderBy('date')
      .snapshots();
});

// StreamProviderを使うことでStreamも扱うことができる
// ※ autoDisposeを付けることで自動的に値をリセットできます
final usersQueryProvider = StreamProvider.autoDispose((ref) {
  return FirebaseFirestore.instance
      .collection('users')
      .orderBy('email')
      .snapshots();
});
final groupQueryProvider = StreamProvider.autoDispose((ref) {
  return FirebaseFirestore.instance
      .collection('channels')
      .orderBy('channelName')
      .snapshots();
});
