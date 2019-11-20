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
        padding: const EdgeInsets.all(16),
        child: AspectRatio(
          aspectRatio: 1,
          child: Stack(
            fit: StackFit.passthrough,
            children: <Widget>[
              AnimatedBuilder(
                animation: model.secondAnimation,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: model.secondAnimation.value,
                    child: child,
                  );
                },
                child: const RepaintBoundary(
                  child: ClockFace(),
                ),
              ),
              const RepaintBoundary(child: ClockHand()),
              Align(
                alignment: Alignment.topCenter,
                child: const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: SecondText(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
