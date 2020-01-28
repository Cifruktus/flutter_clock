import 'dart:async';
import 'dart:math';

import 'package:analog_clock/model/clock_type.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_clock_helper/model.dart';

class TimerModel extends ChangeNotifier {
  TimerModel({
    @required TickerProvider vsync,
  }) : _animationController = AnimationController(
          vsync: vsync,
          duration: const Duration(seconds: 1),
        ) {
    _updateTime();
  }
  ClockModel clockModel;
  final AnimationController _animationController;
  DateTime _now = DateTime.now();
  Timer _timer;

  DateTime get now => _now;

  Animation<double> getAnimation({@required ClockType type}) {
    switch (type) {
      case ClockType.hour:
        return _hourAnimation;
      case ClockType.minute:
        return _minuteAnimation;
      case ClockType.second:
        return _secondAnimation;
    }
    assert(false, 'Unexpected type: $type');
    return null;
  }

  Animation<double> get _secondAnimation => _animationController.drive(
        Tween(
          begin: -2 * pi * (now.second - 0.5) / 60,
          end: -2 * pi * (now.second + 0.5) / 60,
        ),
      );
  Animation<double> get _minuteAnimation => _animationController.drive(
        Tween(
          begin: -2 * pi * (now.minute + now.second / 60) / 60,
          end: -2 * pi * (now.minute + (now.second + 1) / 60) / 60,
        ),
      );
  Animation<double> get _hourAnimation => _animationController.drive(
        Tween(
          begin: -2 *
              pi *
              (now.hour % 24 * 60 + now.minute + now.second / 60) /
              (60 * _get12Or24),
          end: -2 *
              pi *
              (now.hour % 24 * 60 + now.minute + (now.second + 1) / 60) /
              (60 * _get12Or24),
        ),
      );

  int get _get12Or24 => clockModel.is24HourFormat as bool ? 24 : 12;

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
