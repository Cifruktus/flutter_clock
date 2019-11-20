// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/customizer.dart';
import 'package:provider/provider.dart';
import 'package:vsync_provider/vsync_provider.dart';

import 'analog_clock.dart';
import 'model/model.dart';

void main() {
  if (!kIsWeb && Platform.isMacOS) {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }
  runApp(ClockCustomizer(
    (model) => MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: model),
        VsyncProvider(),
        ChangeNotifierProvider(
          builder: (context) => TimerModel(vsync: VsyncProvider.of(context)),
        )
      ],
      child: const Clock(),
    ),
  ));
}
