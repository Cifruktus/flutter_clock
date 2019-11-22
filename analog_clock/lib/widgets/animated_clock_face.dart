import 'package:analog_clock/model/model.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'widgets.dart';

class AnimatedClockFace extends StatelessWidget {
  const AnimatedClockFace({
    Key key,
    @required this.type,
  }) : super(key: key);

  final ClockType type;

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<TimerModel>(context, listen: false);
    return AnimatedBuilder(
      animation: model.getAnimation(type: type),
      builder: (context, child) {
        return Transform.rotate(
          angle: model.getAnimation(type: type).value,
          child: child,
        );
      },
      child: RepaintBoundary(
        child: ClockFace(type: type),
      ),
    );
  }
}
