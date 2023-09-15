import 'package:flutter/material.dart';

import 'package:digilogtv/services/storage.dart';
import 'package:digilogtv/services/formatting.dart';
import 'package:digilogtv/pages/homepage.dart';
import 'package:digilogtv/pages/channelpage-iptv.dart';
import 'package:digilogtv/pages/channelpage-youtube.dart';

goToHomePage(
    {required BuildContext context,
    required StorageProvider storage,
    required FormattingProvider formatingProvider}) {
  Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => HomePage(
                storage: storage,
                formattingProvider: formatingProvider,
              )));
}

goToChannelPageIPTV(
    {required BuildContext context,
    required int index,
    required StorageProvider storage}) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ChannelPageIPTV(
                index: index,
                storage: storage,
              )));
}

goToChannelPageYouTube(
    {required BuildContext context,
    required int index,
    required StorageProvider storage}) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ChannelPageYouTube(
                index: index,
                storageProvider: storage,
              )));
}
