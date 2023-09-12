import 'package:flutter/material.dart';

import 'package:digilogtv/pages/loadingpage.dart';

void main() => runApp(
  MaterialApp(
    title: "Digilog TV",
    initialRoute: '/',
    routes: {
      '/': (context) => const LoadingPage(),
    },
));