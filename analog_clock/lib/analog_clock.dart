// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:analog_clock/model/model.dart';
import 'package:analog_clock/widgets/weather_text.dart';
import 'package:flutter/material.dart';

import 'widgets/widgets.dart';

class Clock extends StatelessWidget {
  const Clock({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        const Background(),
        Center(
          child: LayoutBuilder(
            builder: (context, constraints) => Transform.translate(
              offset: Offset(0, constraints.maxHeight / 2),
              child: Transform.scale(
                scale: constraints.maxWidth / constraints.maxHeight,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Stack(
                      overflow: Overflow.visible,
                      fit: StackFit.passthrough,
                      children: <Widget>[
                        const FractionallySizedBox(
                          widthFactor: 0.95,
                          heightFactor: 0.95,
                          child: AnimatedClockFace(type: ClockType.hour),
                        ),
                        const FractionallySizedBox(
                          widthFactor: 0.65,
                          heightFactor: 0.65,
                          child: AnimatedClockFace(type: ClockType.minute),
                        ),
                        const FractionallySizedBox(
                          widthFactor: 0.35,
                          heightFactor: 0.35,
                          child: AnimatedClockFace(type: ClockType.second),
                        ),
                        const RepaintBoundary(
                          child: FractionallySizedBox(
                            heightFactor: 1.13,
                            child: ClockHand(),
                          ),
                        ),
                        Positioned.fill(
                          top: -4,
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: ClockText(type: ClockType.hour),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: const Padding(
                            padding: EdgeInsets.only(top: 48),
                            child: ClockText(type: ClockType.minute),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: const Padding(
                            padding: EdgeInsets.only(top: 99),
                            child: ClockText(type: ClockType.second),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const Positioned(
          top: 36,
          left: 48,
          child: const DateText(),
        ),
        const Positioned(
          top: 36,
          right: 48,
          child: const WeatherText(),
        )
      ],
    );
  }
}
