import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:digilogtv/services/storage.dart';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class ChannelPageYouTube extends StatefulWidget {
  const ChannelPageYouTube(
      {super.key,
      required this.index,
      required this.storageProvider,
      required this.isTV});

  final int index;
  final StorageProvider storageProvider;
  final bool isTV;

  @override
  State<ChannelPageYouTube> createState() => _ChannelPageYouTubeState();
}

class _ChannelPageYouTubeState extends State<ChannelPageYouTube> {
  _ChannelPageYouTubeState();

  late int index;
  late StorageProvider storageProvider;
  late bool isTV;

  @override
  void initState() {
    isTV = widget.isTV;
    super.initState();
    index = widget.index;
    storageProvider = widget.storageProvider;
    WakelockPlus.enable();
  }

  @override
  void dispose() {
    WakelockPlus.disable();
    if (!isTV) {
      SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    isTV = widget.isTV;
    return Scaffold(
        appBar: (isTV)
            ? null
            : AppBar(
                title: Text(
                    storageProvider.channels.channelList[index].channelName),
                titleTextStyle: const TextStyle(color: Colors.white),
                centerTitle: true,
                backgroundColor: Colors.indigo[900],
                foregroundColor: Colors.white,
              ),
        backgroundColor: Colors.black,
        body: InAppWebView(
          initialUrlRequest: URLRequest(
              url: WebUri(storageProvider.channels.channelList[index].link)),
          initialSettings: InAppWebViewSettings(
            mediaPlaybackRequiresUserGesture: false,
            incognito: true,
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
        ));
  }
}
