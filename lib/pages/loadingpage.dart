import 'package:flutter/material.dart';

import 'package:digilogtv/services/storage.dart';
import 'package:digilogtv/services/formatting.dart';
import 'package:digilogtv/services/routing.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  final StorageProvider storage = StorageProvider();
  final FormattingProvider formatingProvider = FormattingProvider();

  _startup() async {
    await storage.initialize();
    Future.delayed(const Duration(seconds: 1), () async {
      goToHomePage(
          context: context,
          storage: storage,
          formatingProvider: formatingProvider);
    });
  }

  @override
  void initState() {
    super.initState();
    _startup();
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
                padding: const EdgeInsets.all(9.0),
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
