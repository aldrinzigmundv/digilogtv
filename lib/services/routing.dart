import 'package:flutter/material.dart';

import 'package:digilogtv/pages/home%20pages/channellistpage.dart';
import 'package:digilogtv/pages/home%20pages/favoritespage.dart';
import 'package:digilogtv/pages/home%20pages/contactpage.dart';
import 'package:digilogtv/pages/channelpage_iptv.dart';
import 'package:digilogtv/pages/channelpage_youtube.dart';

class NoAnimationRoute<T> extends MaterialPageRoute<T> {
  NoAnimationRoute({
    required super.builder,
    super.settings,
  });

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return child;
  }
}

goToChannelListPage(
    {required BuildContext context,
    required bool isTV}) {
  Navigator.pushReplacement(
      context,
      NoAnimationRoute(
          builder: (context) => ChannelListPage(
                isTV: isTV,
              )));
}

goToFavoritesPage(
    {required BuildContext context,
    required bool isTV}) {
  Navigator.pushReplacement(
      context,
      NoAnimationRoute(
          builder: (context) => FavoritesPage(
                isTV: isTV,
              )));
}

goToContactPage(
    {required BuildContext context,
    required bool isTV}) {
  Navigator.pushReplacement(
      context,
      NoAnimationRoute(
          builder: (context) => ContactPage(
                isTV: isTV,
              )));
}

goToChannelPageIPTV(
    {required BuildContext context,
    required int index,
    required bool isTV}) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ChannelPageIPTV(
                index: index,
                isTV: isTV,
              )));
}

goToChannelPageYouTube(
    {required BuildContext context,
    required int index,
    required bool isTV}) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ChannelPageYouTube(
                index: index,
                isTV: isTV,
              )));
}
