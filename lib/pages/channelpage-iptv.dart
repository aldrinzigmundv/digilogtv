import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:video_player/video_player.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import 'package:digilogtv/services/storage.dart';

class ChannelPageIPTV extends StatefulWidget {
  const ChannelPageIPTV(
      {super.key,
      required this.index,
      required this.storage});

  final int index;
  final StorageProvider storage;

  @override
  State<ChannelPageIPTV> createState() =>
      _ChannelPageIPTVState(index, storage);
}

class _ChannelPageIPTVState extends State<ChannelPageIPTV> {
  _ChannelPageIPTVState(this.index, this.storage);

  late int index;
  late StorageProvider storage;

  late VideoPlayerController _videoPlayerController;

  bool _appBarVisibility = true;

  _hideUnhideAppBar() {
    setState(() {
      _appBarVisibility = !_appBarVisibility;
      if (!_appBarVisibility) {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight
        ]);
      } else {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
            overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    WakelockPlus.enable();
    _videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse(storage.channels.channelList[index].link))
      ..initialize().then((_) {
        setState(() {});
        _videoPlayerController.play();
      });
  }

  @override
  void dispose() async {
    WakelockPlus.disable();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBarVisibility
            ? AppBar(
                title: Text(storage.channels.channelList[index].channelName),
                centerTitle: true,
                backgroundColor: Colors.indigo[900],
              )
            : null,
        backgroundColor: Colors.black,
        body: GestureDetector(
          onTap: () => _hideUnhideAppBar(),
          child: Center(
            child: _videoPlayerController.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _videoPlayerController.value.aspectRatio,
                    child: VideoPlayer(_videoPlayerController))
                : const Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator()),
          ),
        ),
        bottomNavigationBar:
            (MediaQuery.of(context).orientation == Orientation.portrait)
                ? const Padding(
                    padding: EdgeInsets.all(27.0),
                    child: Text(
                      'Tap the video for full screen viewing', textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : null);
  }
}
