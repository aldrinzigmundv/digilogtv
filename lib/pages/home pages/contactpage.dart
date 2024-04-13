import 'package:flutter/material.dart';

import 'package:digilogtv/services/storage.dart';
import 'package:digilogtv/services/formatting.dart';
import 'package:digilogtv/pages/home%20pages/home%20pages%20widgets/mainappbar.dart';
import 'package:digilogtv/pages/home%20pages/home%20pages%20widgets/topnavbar.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({
    super.key,
    required this.storage,
    required this.formattingProvider,
    required this.isTV,
  });

  final StorageProvider storage;
  final FormattingProvider formattingProvider;
  final bool isTV;

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  int _focusedIndex = 0;

  void _updateFocus(int newIndex) {
    setState(() {
      _focusedIndex = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(),
      body: Column(
        children: [
          TopNavBar(
            storage: widget.storage,
            formattingProvider: widget.formattingProvider,
            focusedIndex: _focusedIndex,
            updateFocus: _updateFocus,
            isTV: widget.isTV,
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(18.0, 36.0, 18.0, 18.0),
                  child: Image.asset(
                    'assets/icons/icon.png',
                    height: 180.0,
                    width: 180.0,
                    fit: BoxFit.contain,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(18.0, 36.0, 18.0, 18.0),
                  child: SelectableText(
                    'You can reach me at aldrinzigmund@tutamail.com',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(18.0, 36.0, 18.0, 18.0),
                  child: SelectableText(
                    'Digilog TV is powered by aldrinzigmund.com',
                    style: TextStyle(fontSize: 18.0),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
