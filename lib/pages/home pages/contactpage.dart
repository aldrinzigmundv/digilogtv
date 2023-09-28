import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  copyBitcoinAddress(BuildContext context) {
    Clipboard.setData(const ClipboardData(
        text: 'bc1qruus6vnxrww6pqac3hvg6vsepmqv8d66dwjm59'));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Bitcoin Address copied to clipboard."),
      duration: Duration(seconds: 2),
    ));
  }

  copyMoneroAddress(BuildContext context) {
    Clipboard.setData(const ClipboardData(
        text:
            '86cQoPfKTJ2bRfGH5Ts2kzaXCRcVRiX8CUHKc9xmeUmQ8YM8Uzk9S97T5gQaqYu58C9wuFK7opDH7cM9EJyR4V5LAq9RGv4'));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Monero Address copied to clipboard."),
      duration: Duration(seconds: 2),
    ));
  }

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
              child: Text(
                'You can reach me at aldrinzigmund@tutamail.com',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(18.0, 36.0, 18.0, 18.0),
              child: Text(
                'You have downloaded the ad-supported version of this app from Google Play. An ad-free version is available on GitHub. Other ads are provided by their respective TV news channels.',
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
