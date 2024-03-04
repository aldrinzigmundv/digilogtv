import 'package:flutter/material.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
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
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
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
    );
  }
}
