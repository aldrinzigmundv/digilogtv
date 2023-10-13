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
              child: Text(
                'You can reach me at aldrinzigmund@tutamail.com',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(18.0, 36.0, 18.0, 18.0),
              child: Text(
                'You have downloaded the ad-free version of Digilog TV. Other ads are provided by their respective TV news channels.',
                style: TextStyle(fontSize: 18.0),
                textAlign: TextAlign.center,
              ),
            ),
            // const Padding(
            //   padding: EdgeInsets.fromLTRB(18.0, 36.0, 18.0, 18.0),
            //   child: Text(
            //     'You have downloaded the ad-supported version of Digilog TV from Google Play. An ad-free version is available on GitHub. Other ads are provided by their respective TV news channels.',
            //     style: TextStyle(fontSize: 18.0),
            //     textAlign: TextAlign.center,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
