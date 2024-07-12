import 'package:flutter/material.dart';

import 'package:digilogtv/services/storage.dart';
import 'package:digilogtv/services/formatting.dart';
import 'package:digilogtv/services/routing.dart';
import 'package:digilogtv/services/update.dart';

import 'package:device_info_plus/device_info_plus.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  final StorageProvider storage = StorageProvider();
  final FormattingProvider formatingProvider = FormattingProvider();
  UpdateManager updateManager = UpdateManager();
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  final FocusNode _focusNode = FocusNode();

  late AndroidDeviceInfo androidInfo;

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
    updateManager.removeUpdate(storage);
    Navigator.of(context).pop();
  }

  _startup() async {
    await Future.wait([
      Future(() => storage.initialize()),
      Future(() => deviceInfo.androidInfo),
    ]).then((values) => {
          androidInfo = values[1],
        });
    bool isTV =
        androidInfo.systemFeatures.contains('android.software.leanback');
    bool justUpdated = await updateManager.checkIfAppWasUpdated(storage);
    if (justUpdated) {
      await _showUpdateDialogBox(updateManager.getUpdateMessage());
    }
    Future.delayed(const Duration(seconds: 1), () async {
      goToChannelListPage(
          context: context,
          storage: storage,
          formattingProvider: formatingProvider,
          isTV: isTV);
    });
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
      bottomNavigationBar: const Padding(
        padding: EdgeInsets.all(13.0),
        child: SelectableText('Powered by aldrinzigmund.com',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 15.0)),
      ),
    );
  }
}
