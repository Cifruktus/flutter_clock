import 'package:analog_clock/model/model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DateText extends StatelessWidget {
  const DateText({Key key}) : super(key: key);

  static final _dateFormat = DateFormat('MM.dd');
  static final _weekFormat = DateFormat('EEE');
  static const _textColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<TimerModel>(context);
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: _dateFormat.format(model.now),
            style: Theme.of(context).textTheme.headline.copyWith(
                  color: _textColor,
                  fontWeight: FontWeight.w300,
                ),
          ),
          const WidgetSpan(child: SizedBox(width: 8)),
          TextSpan(
            text: _weekFormat.format(model.now),
            style: Theme.of(context).textTheme.subhead.copyWith(
                  color: _textColor,
                  fontWeight: FontWeight.w300,
                ),
          ),
        ],
      ),
    );
  }
}
