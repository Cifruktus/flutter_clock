import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isLight
              ? const [
                  Color(0xFF80C3CB),
                  Color(0xFFD9E1C0),
                ]
              : const [
                  Color(0xFF0D014A),
                  Color(0xFF380E86),
                  Color(0xFF551988),
                ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }
}
