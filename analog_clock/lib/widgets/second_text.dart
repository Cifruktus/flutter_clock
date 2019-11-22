import 'package:analog_clock/model/model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SecondText extends StatelessWidget {
  const SecondText({Key key}) : super(key: key);

  static final _inTween = Tween<Offset>(
    begin: const Offset(1, 0),
    end: const Offset(0, 0),
  );
  static final _outTween = Tween<Offset>(
    begin: const Offset(-1, 0),
    end: const Offset(0, 0),
  );

  static final _format = NumberFormat('00');

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<TimerModel>(context);
    final second = model.now.second;
    return Container(
      color: Colors.grey[200],
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: Text(
          _format.format(second),
          key: ValueKey(second),
          style: Theme.of(context).textTheme.title,
        ),
        transitionBuilder: (child, animation) {
          return _buildTransition(
            position: animation.drive(
              child.key == ValueKey(second) ? _inTween : _outTween,
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
