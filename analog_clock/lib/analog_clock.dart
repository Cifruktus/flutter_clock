// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/model.dart';
import 'widgets/widgets.dart';

class Clock extends StatelessWidget {
  const Clock({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<TimerModel>(context, listen: false);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: AspectRatio(
          aspectRatio: 1,
          child: Stack(
            fit: StackFit.passthrough,
            children: <Widget>[
              FractionallySizedBox(
                widthFactor: 0.95,
                heightFactor: 0.95,
                child: AnimatedBuilder(
                  animation: model.hourAnimation,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: model.hourAnimation.value,
                      child: child,
                    );
                  },
                  child: const RepaintBoundary(
                    child: ClockFace(type: ClockType.hour),
                  ),
                ),
              ),
              FractionallySizedBox(
                widthFactor: 0.65,
                heightFactor: 0.65,
                child: AnimatedBuilder(
                  animation: model.minuteAnimation,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: model.minuteAnimation.value,
                      child: child,
                    );
                  },
                  child: const RepaintBoundary(
                    child: ClockFace(type: ClockType.minute),
                  ),
                ),
              ),
              FractionallySizedBox(
                widthFactor: 0.35,
                heightFactor: 0.35,
                child: AnimatedBuilder(
                  animation: model.secondAnimation,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: model.secondAnimation.value,
                      child: child,
                    );
                  },
                  child: const RepaintBoundary(
                    child: ClockFace(type: ClockType.second),
                  ),
                ),
              ),
              const RepaintBoundary(child: ClockHand()),
              Align(
                alignment: Alignment.topCenter,
                child: const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: ClockText(type: ClockType.hour),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: const Padding(
                  padding: EdgeInsets.only(top: 70),
                  child: ClockText(type: ClockType.minute),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: const Padding(
                  padding: EdgeInsets.only(top: 120),
                  child: ClockText(type: ClockType.second),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
