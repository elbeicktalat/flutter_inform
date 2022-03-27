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
    const banner = InformBanner(
      content: Text('Inform Banner'),
      backgroundColor: Colors.amber,
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(18)),
    );
    showBanner(context, banner);
  }

  void getBannerOut() => hideBanner(context);
}
