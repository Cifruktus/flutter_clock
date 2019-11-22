import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class TimerModel extends ChangeNotifier {
  TimerModel({@required TickerProvider vsync})
      : _animationController = AnimationController(
          vsync: vsync,
          duration: const Duration(seconds: 1),
        ) {
    _updateTime();
  }
  final AnimationController _animationController;
  DateTime _now = DateTime.now();
  Timer _timer;

  DateTime get now => _now;
  Animation<double> get secondAnimation => _animationController.drive(
        Tween(
          begin: -2 * pi * (now.second - 0.5) / 60,
          end: -2 * pi * (now.second + 0.5) / 60,
        ),
      );
  Animation<double> get minuteAnimation => _animationController.drive(
        Tween(
          begin: -2 * pi * (now.minute + now.second / 60) / 60,
          end: -2 * pi * (now.minute + (now.second + 1) / 60) / 60,
        ),
      );
  Animation<double> get hourAnimation => _animationController.drive(
        Tween(
          begin: -2 *
              pi *
              (now.hour * 60 + now.minute + now.second / 60) /
              (60 * 24),
          end: -2 *
              pi *
              (now.hour * 60 + now.minute + (now.second + 1) / 60) /
              (60 * 24),
        ),
      );

  void _updateTime() {
    _now = DateTime.now();
    _animationController.forward(from: 0);
    notifyListeners();
    _timer = Timer(
      const Duration(seconds: 1) - Duration(milliseconds: _now.millisecond),
      _updateTime,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _timer.cancel();

    super.dispose();
  }
}
