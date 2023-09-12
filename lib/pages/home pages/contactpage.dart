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
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(18.0, 36.0, 18.0, 18.0),
            child: Text(
              'You can reach me at aldrinzigmund@tutamail.com',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(18.0),
            child: Text(
              'Due to the added workload of maintaining this app on the Google Play Store – where they recently required me to include the websites of each TV news channel, although I personally think it\'s not necessary as I trust my users\' ability to distinguish quality news from bad ones, and find the contact information of these TV news networks easily via a simple web search – and the rejection of my recent app update that was intended to promptly resolve a screen timeout issue during video playback till I comply with the said requirement, I\'m now considering the possibility of introducing ads for users who download my app from Google Play as a means of compensating for my efforts in enhancing the overall user experience.',
              style: TextStyle(fontSize: 18.0),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: (MediaQuery.of(context).size.height -
                kBottomNavigationBarHeight -
                AppBar().preferredSize.height),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                    padding: EdgeInsets.fromLTRB(9.0, 27.0, 9.0, 18.0),
                    child: Text(
                      'Donate Bitcoin to Help Me Maintain this App',
                      style: TextStyle(fontSize: 27.0),
                      textAlign: TextAlign.center,
                    )),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 9.0, vertical: 18.0),
                    child: GestureDetector(
                      onTap: () => copyBitcoinAddress(context),
                      child: Image.asset(
                        'assets/images/bitcoin.png',
                        height: 300.0,
                        width: 300.0,
                        fit: BoxFit.contain,
                      ),
                    )),
                const Padding(
                    padding: EdgeInsets.all(18.0),
                    child: Text(
                      'Tap the QR Code to Copy the Bitcoin Address to your Clipboard',
                      style: TextStyle(fontSize: 15.0),
                      textAlign: TextAlign.center,
                    )),
              ],
            ),
          ),
          SizedBox(
            height: (MediaQuery.of(context).size.height -
                kBottomNavigationBarHeight -
                AppBar().preferredSize.height),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                    padding: EdgeInsets.fromLTRB(9.0, 27.0, 9.0, 18.0),
                    child: Text(
                      'Donate Monero to Help Me Maintain this App',
                      style: TextStyle(fontSize: 27.0),
                      textAlign: TextAlign.center,
                    )),
                Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: GestureDetector(
                      onTap: () => copyMoneroAddress(context),
                      child: Image.asset(
                        'assets/images/monero.png',
                        height: 300.0,
                        width: 300.0,
                        fit: BoxFit.contain,
                      ),
                    )),
                const Padding(
                    padding: EdgeInsets.all(18.0),
                    child: Text(
                      'Tap the QR Codes to Copy the Monero Address to your Clipboard',
                      style: TextStyle(fontSize: 15.0),
                      textAlign: TextAlign.center,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
