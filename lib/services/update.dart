import 'package:digilogtv/services/storage.dart';

import 'package:package_info_plus/package_info_plus.dart';

class UpdateManager {
  late PackageInfo packageInfo;

  Future<bool> checkIfAppWasUpdated(StorageProvider storage) async {
    packageInfo = await PackageInfo.fromPlatform();
    String lastVersion = storage.getLastVersion() ?? '0.0.0';
    if (lastVersion == packageInfo.version) {
      return false;
    } else {
      return true;
    }
  }

  getUpdateMessage() {
    return "We've updated the Digilog TV channel list! A big thanks to our content partner, Free-TV/IPTV on GitHub, for providing us with free, legal, and publicly available content.\n\nWe're also excited to announce the release of Digilog TV - Japanese Edition. You can find it now on GitHub, and it will be available on the Play Store soon.";
  }

  removeUpdate(StorageProvider storage) async {
    storage.updateVersion(packageInfo.version);
  }
}