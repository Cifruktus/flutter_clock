import 'package:analog_clock/model/model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SecondText extends StatelessWidget {
  const SecondText({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<TimerModel>(context);
    final second = model.now.second;
    return Container(
      color: Colors.grey[200],
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: Text(
          '$second',
          key: ValueKey(second),
          style: Theme.of(context).textTheme.title,
        ),
//        layoutBuilder: (currentChild, previousChildren) => currentChild,
        transitionBuilder: (child, animation) {
          final inAnimation =
              Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0))
                  .animate(animation);
          final outAnimation =
              Tween<Offset>(begin: const Offset(-1, 0), end: const Offset(0, 0))
                  .animate(animation);

          if (child.key == ValueKey(second)) {
            return ClipRect(
              child: SlideTransition(
                position: inAnimation,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: child,
                ),
              ),
            );
          } else {
            return ClipRect(
              child: SlideTransition(
                position: outAnimation,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: child,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
