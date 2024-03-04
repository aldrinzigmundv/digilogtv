import 'package:flutter/material.dart';

import 'package:digilogtv/pages/loadingpage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MaterialApp(
    title: "Digilog TV",
    home: LoadingPage(),
  ));
}
