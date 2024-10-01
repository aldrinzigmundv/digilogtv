import 'package:digilogtv/services/storage.dart';

import 'package:package_info_plus/package_info_plus.dart';

class UpdateManager {
  StorageProvider storageProvider = StorageProvider();
  late PackageInfo packageInfo;

  Future<bool> checkIfAppWasUpdated() async {
    packageInfo = await PackageInfo.fromPlatform();
    String lastVersion = storageProvider.storage.get('lastVersion', defaultValue: '0.0.0');
    if (lastVersion == packageInfo.version) {
      return false;
    } else {
      return true;
    }
  }

  getUpdateMessage() {
    return "Faster channel updates via GitHub—no app update needed anymore!\n\nImproved support for Google and Android TV.\n\nNon-disruptive ads added (PlayStore version only) to support future development plans.\n\nBig thanks to Free-TV/IPTV on GitHub for free, legal and publicly available content!";
  }

  removeUpdate() async {
    storageProvider.storage.put('lastVersion', packageInfo.version);
  }
}