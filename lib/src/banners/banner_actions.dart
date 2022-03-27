// Copyright (c) 2022 Talat El Beick. All rights reserved.
// Use of this source code is governed by a MIT-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

void showBanner(BuildContext context, MaterialBanner banner) {
  ScaffoldMessenger.of(context).showMaterialBanner(banner);
}

void removeCurrentBanner(
  BuildContext context, {
  MaterialBannerClosedReason reason = MaterialBannerClosedReason.remove,
}) {
  ScaffoldMessenger.of(context).removeCurrentMaterialBanner(reason: reason);
}

void clearBanners(BuildContext context) {
  ScaffoldMessenger.of(context).clearMaterialBanners();
}

void hideBanner(BuildContext context) {
  ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
}
