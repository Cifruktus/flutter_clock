import 'package:analog_clock/model/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ClockText extends StatelessWidget {
  const ClockText({Key key, @required this.type}) : super(key: key);

  final ClockType type;

  static final _inTween = Tween<Offset>(
    begin: const Offset(1, 0),
    end: const Offset(0, 0),
  );
  static final _outTween = Tween<Offset>(
    begin: const Offset(-1, 0),
    end: const Offset(0, 0),
  );

  static final _format = NumberFormat('00');

  int _getValue(BuildContext context) {
    final model = Provider.of<TimerModel>(context);
    final now = model.now;
    final clockModel = Provider.of<ClockModel>(context);
    switch (type) {
      case ClockType.second:
        return now.second;
      case ClockType.minute:
        return now.minute;
      case ClockType.hour:
        return clockModel.is24HourFormat as bool ? now.hour : now.hour % 12;
    }
    assert(false, 'Unexpected type: $type');
    return 0;
  }

  Color get _textColor {
    switch (type) {
      case ClockType.hour:
        return const Color(0xFF41ACB7);
      case ClockType.minute:
        return const Color(0xFF6EBCC3);
      case ClockType.second:
        return const Color(0xFF90D4D9);
    }
  }

  TextStyle _baseTextStyle(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    switch (type) {
      case ClockType.hour:
      case ClockType.minute:
        return theme.headline;
      case ClockType.second:
        return theme.body1;
    }
  }

  ShapeBorder get _shapeBorder {
    switch (type) {
      case ClockType.hour:
      case ClockType.minute:
        return RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        );
      case ClockType.second:
        return const StadiumBorder();
    }
  }

  @override
  Widget build(BuildContext context) {
    final value = _getValue(context);
    return Card(
      elevation: 0,
      shape: _shapeBorder,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: Text(
          _format.format(value),
          key: ValueKey(value),
          style: _baseTextStyle(context).copyWith(
            fontWeight: FontWeight.bold,
            color: _textColor,
          ),
        ),
        transitionBuilder: (child, animation) {
          return _buildTransition(
            position: animation.drive(
              child.key == ValueKey(value) ? _inTween : _outTween,
            ),
            child: child,
          );
        },
      ),
    );
  }

  Widget _buildTransition({
    @required Animation<Offset> position,
    @required Widget child,
  }) {
    return ClipRect(
      child: SlideTransition(
        position: position,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: child,
        ),
      ),
    );
  }
}
