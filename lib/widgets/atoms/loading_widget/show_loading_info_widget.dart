// Thanks to Brayan Nieves for added this widget to synkron app

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

showLoadingInfoWidget() {
  return Center(
    child: Lottie.asset('assets/lottie_loading.json', width: 200.0),
  );
}
