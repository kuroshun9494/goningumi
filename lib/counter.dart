
import 'package:state_notifier/state_notifier.dart';

// StateNotifierを使った実装
class Counter extends StateNotifier<int> {
  Counter(): super(0);

  /// カウントを一個増やす
  void increment() => state++;
}

