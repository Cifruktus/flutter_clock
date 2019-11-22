import 'package:analog_clock/model/model.dart';
import 'package:flutter/material.dart';
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
    switch (type) {
      case ClockType.second:
        return now.second;
      case ClockType.minute:
        return now.minute;
      case ClockType.hour:
        return now.hour;
    }
    assert(false, 'Unexpected type: $type');
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final value = _getValue(context);
    return Card(
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: Text(
          _format.format(value),
          key: ValueKey(value),
          style: Theme.of(context).textTheme.title,
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
