import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class TimerModel extends ChangeNotifier {
  TimerModel({@required TickerProvider vsync})
      : _secondAnimation = AnimationController(
          vsync: vsync,
          duration: const Duration(seconds: 1),
        ) {
    _updateTime();
  }
  final AnimationController _secondAnimation;
  DateTime _now = DateTime.now();
  Timer _timer;

  DateTime get now => _now;
  Animation<double> get secondAnimation => _secondAnimation.drive(
        Tween(
          begin: -2 * pi * (now.second - 0.5) / 60,
          end: -2 * pi * (now.second + 0.5) / 60,
        ),
      );

  void _updateTime() {
    _now = DateTime.now();
    _secondAnimation.forward(from: 0);
    notifyListeners();
    _timer = Timer(
      const Duration(seconds: 1) - Duration(milliseconds: _now.millisecond),
      _updateTime,
    );
  }

  @override
  void dispose() {
    _secondAnimation.dispose();
    _timer.cancel();

    super.dispose();
  }
}
