import 'dart:convert';

import 'package:digilogtv/models/channel.dart';
import 'package:flutter/material.dart';

import 'package:digilogtv/services/storage.dart';
import 'package:digilogtv/services/routing.dart';
import 'package:digilogtv/services/update.dart';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  StorageProvider storageProvider = StorageProvider();
  UpdateManager updateManager = UpdateManager();
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  final FocusNode _focusNode = FocusNode();

  late AndroidDeviceInfo androidInfo;

  String _bottomMessage = 'Powered by aldrinzigmund.com';

  bool buttonFocused = false;

  _showUpdateDialogBox(String updatemessage) async {
    await showDialog(
      context: context,
      useRootNavigator: true,
      useSafeArea: true,
      barrierDismissible: false,
      builder: (BuildContext context) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _focusNode.requestFocus();
        });
        return AlertDialog(
          title: const Text('Digilog TV Updated'),
          content: Text(updatemessage),
          actions: [
            TextButton(
              focusNode: _focusNode,
              onFocusChange: (_) => _returnDialogBoxFocus,
              style: ButtonStyle(
                foregroundColor: WidgetStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () => _closeUpdateDialogBox(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  _returnDialogBoxFocus(_) {
    _focusNode.requestFocus();
  }

  _closeUpdateDialogBox() {
    updateManager.removeUpdate();
    Navigator.of(context).pop();
  }

  Future<void> fetchAndStoreChannelList() async {
    const String remoteJsonUrl =
        'https://raw.githubusercontent.com/aldrinzigmundv/digilogtv/master/assets/data/channels.json';
    const String localJsonPath = 'assets/data/channels.json';

    try {
      List<Channel> channels = await fetchRemoteChannelList(remoteJsonUrl);

      await storageProvider.storage.put('channelList', channels);
    } catch (e) {
      if (mounted) {
        setState(() {
        _bottomMessage = 'Failed to fetch channel list online.';
      });
      }

      List<Channel> localChannels = storageProvider.storage
          .get('channelList', defaultValue: []).cast<Channel>();

      if (localChannels.isNotEmpty) {
        return;
      }

      List<Channel> channels = await fetchLocalChannelList(localJsonPath);

      await storageProvider.storage.put('channelList', channels);
    }
  }

  Future<List<Channel>> fetchRemoteChannelList(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Channel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load remote JSON');
    }
  }

  Future<List<Channel>> fetchLocalChannelList(String path) async {
    final String jsonString = await rootBundle.loadString(path);
    List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((json) => Channel.fromJson(json)).toList();
  }

  _startup() async {
    final results = await Future.wait([
      storageProvider.initialize(),
      deviceInfo.androidInfo,
    ]);
    await fetchAndStoreChannelList();
    final androidInfo = results[1] as AndroidDeviceInfo;
    bool isTV =
        androidInfo.systemFeatures.contains('android.software.leanback');
    bool justUpdated = await updateManager.checkIfAppWasUpdated();
    if (justUpdated) {
      await _showUpdateDialogBox(updateManager.getUpdateMessage());
    }
    if (mounted) {
      goToChannelListPage(
          context: context, isTV: isTV);
    }
  }

  @override
  void initState() {
    super.initState();
    _startup();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[900],
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
              padding: const EdgeInsets.all(9.0),
              child: Image.asset('assets/icons/icon.png')),
          const Padding(
            padding: EdgeInsets.all(9.0),
            child: Text(
              'Digilog TV',
              style: TextStyle(color: Colors.white, fontSize: 27.0),
            ),
          ),
        ],
      )),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(13.0),
        child: SelectableText(_bottomMessage,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 15.0)),
      ),
    );
  }
}
