import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class WeatherText extends StatelessWidget {
  const WeatherText({Key key}) : super(key: key);

  static const _textColor = Colors.white;
  static final _tempretureFormat = NumberFormat('#0');

  IconData _weatherIcon(WeatherCondition condition) {
    switch (condition) {
      case WeatherCondition.cloudy:
      case WeatherCondition.foggy:
        return FontAwesomeIcons.cloud;
      case WeatherCondition.rainy:
        return FontAwesomeIcons.cloudRain;
      case WeatherCondition.snowy:
        return FontAwesomeIcons.solidSnowflake;
      case WeatherCondition.sunny:
        return Icons.wb_sunny;
      case WeatherCondition.thunderstorm:
        return FontAwesomeIcons.pooStorm;
      case WeatherCondition.windy:
        return FontAwesomeIcons.wind;
    }
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ClockModel>(context);
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: model.temperatureString,
            style: Theme.of(context).textTheme.headline.copyWith(
                  color: _textColor,
                  fontWeight: FontWeight.w300,
                ),
          ),
          const WidgetSpan(child: SizedBox(width: 8)),
          WidgetSpan(
            child: Icon(
              _weatherIcon(model.weatherCondition),
              color: _textColor,
              size: Theme.of(context).textTheme.subhead.fontSize,
            ),
          ),
          const WidgetSpan(child: SizedBox(width: 8)),
          TextSpan(
            text: '${_tempretureFormat.format(model.low)}${model.unitString} - '
                '${_tempretureFormat.format(model.high)}${model.unitString}',
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
