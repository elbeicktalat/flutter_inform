// Copyright (c) 2022 Talat El Beick. All rights reserved.
// Use of this source code is governed by a MIT-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:inform/inform.dart';

void main() {
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: getBannerIn,
              child: const Text('Show banner'),
            ),
            ElevatedButton(
              onPressed: getBannerOut,
              child: const Text('Hide banner'),
            ),
          ],
        ),
      ),
    );
  }

  void getBannerIn() {
    Gradient gradient = const LinearGradient(
      colors: [
        Color(0xffef1385),
        Color(0xfff12280),
        Color(0xfff63d76),
        Color(0xfff84f70),
      ],
      stops: [
        0.2,
        0.4,
        0.6,
        0.8,
      ],
    );

    final banner = InformBanner(
      content: const Text('Inform Banner'),
      gradient: gradient,
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(18)),
    );
    showBanner(context, banner);
  }

  void getBannerOut() => hideBanner(context);
}
