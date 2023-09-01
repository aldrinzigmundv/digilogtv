import 'package:flutter/material.dart';

import 'package:digilogtv/services/storage.dart';
import 'package:digilogtv/services/formatting.dart';
import 'package:digilogtv/pages/homepage.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {

  final StorageProvider storage = StorageProvider();
  final FormattingProvider formatingProvider = FormattingProvider();

  startup () async {
    storage.initialize();
    Future.delayed(const Duration(seconds: 1), () async {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage(
                  storage: storage,
                  formattingProvider: formatingProvider,
                )));
    });
  }

  @override
  void initState() {
    super.initState();
    startup();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.indigo[900],
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.all(9.0),
                child: Image.asset('assets/icons/icon.png')),
            const Padding(
              padding: EdgeInsets.all(9.0),
              child: Text(
                'Digilog TV',
                style: TextStyle(color: Colors.white, fontSize: 27.0),
              ),
            )
          ],
        )));
  }
}
