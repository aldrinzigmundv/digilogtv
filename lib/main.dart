import 'package:flutter/material.dart';

//import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:digilogtv/pages/loadingpage.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // MobileAds.instance.initialize();

  runApp(const MaterialApp(
    title: "Digilog TV",
    home: LoadingPage(),
  ));
}
