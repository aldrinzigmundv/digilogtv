import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'package:digilogtv/services/storage.dart';

class ChannelPageYouTube extends StatefulWidget {
  const ChannelPageYouTube(
      {super.key,
      required this.index,
      required this.storageProvider});

  final int index;
  final StorageProvider storageProvider;

  @override
  State<ChannelPageYouTube> createState() =>
      _ChannelPageYouTubeState(index, storageProvider);
}

class _ChannelPageYouTubeState extends State<ChannelPageYouTube> {
  _ChannelPageYouTubeState(this.index, this.storageProvider);

  late int index;
  late StorageProvider storageProvider;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(storageProvider.channels.channelList[index].channelName),
          centerTitle: true,
          backgroundColor: Colors.indigo[900],
        ),
        backgroundColor: Colors.black,
        body: InAppWebView(
          initialUrlRequest:
          URLRequest(url: Uri.parse(storageProvider.channels.channelList[index].link)),
          initialOptions: InAppWebViewGroupOptions(
        crossPlatform: InAppWebViewOptions(
          mediaPlaybackRequiresUserGesture: false,
          incognito: true,
        ),
          ),
          onEnterFullscreen: (controller) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight
        ]);
          },
          onExitFullscreen: (controller) {
        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
          },
        )
        );
  }
}
