import 'package:flutter/material.dart';

import 'package:digilogtv/widgets/home%20pages%20widgets/mainappbar.dart';
import 'package:digilogtv/widgets/home%20pages%20widgets/topnavbar.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({
    super.key,
    required this.isTV,
  });

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
                    'You can reach us at support@aldrinzigmund.com',
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
