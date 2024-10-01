import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:digilogtv/services/storage.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class ChannelPageIPTV extends StatefulWidget {
  const ChannelPageIPTV({super.key, required this.index, required this.isTV});

  final int index;
  final bool isTV;

  @override
  State<ChannelPageIPTV> createState() => _ChannelPageIPTVState();
}

class _ChannelPageIPTVState extends State<ChannelPageIPTV> {
  late StorageProvider storageProvider;
  late int index;
  late bool isTV;
  late VideoPlayerController _videoPlayerController;
  bool _appBarVisibility = true;

  @override
  void initState() {
    super.initState();
    index = widget.index;
    isTV = widget.isTV;
    storageProvider = StorageProvider();
    WakelockPlus.enable();
    _setupVideoPlayerController();
  }

  void _setupVideoPlayerController() {
    _videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(storageProvider.storage.get('channelList')[index].link), videoPlayerOptions: VideoPlayerOptions(allowBackgroundPlayback: true)
    )..initialize().then((_) {
        setState(() {});
        _videoPlayerController.play();
      });
  }

  void _hideUnhideAppBar() {
    if (!isTV) {
      setState(() {
        _appBarVisibility = !_appBarVisibility;
        if (!_appBarVisibility) {
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.landscapeLeft,
            DeviceOrientation.landscapeRight,
          ]);
        } else {
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
              overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
          SystemChrome.setPreferredOrientations(DeviceOrientation.values);
        }
      });
    }
  }

  @override
  void dispose() {
    WakelockPlus.disable();
    if (!isTV) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    }
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (isTV)
          ? null
          : _appBarVisibility
              ? AppBar(
                  title: Text(storageProvider.storage.get('channelList')[index].channelName),
                  titleTextStyle: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  centerTitle: true,
                  backgroundColor: Colors.indigo[900],
                  foregroundColor: Colors.white,
                )
              : null,
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: _hideUnhideAppBar,
        child: Center(
          child: _videoPlayerController.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _videoPlayerController.value.aspectRatio,
                  child: VideoPlayer(_videoPlayerController))
              : const Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
      bottomNavigationBar: (isTV)
          ? null
          : (MediaQuery.of(context).orientation == Orientation.portrait)
              ? Padding(
                  padding: const EdgeInsets.all(27.0),
                  child: Text(
                    'Tap the video for full screen viewing. \n \n To get in touch with this news channel, visit their website at: ${storageProvider.storage.get('channelList')[index].contactpage}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white),
                  ),
                )
              : null,
    );
  }
}
